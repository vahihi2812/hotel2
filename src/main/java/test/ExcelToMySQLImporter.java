package test;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.FileInputStream;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ExcelToMySQLImporter {

    private static final String EXCEL_FILE_PATH = "C:\\Users\\Admin\\OneDrive\\Desktop\\booking_data_diverse_time.xlsx";

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/hotel01?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    public static void main(String[] args) {
        importExcelToDB(EXCEL_FILE_PATH);
    }

    public static void importExcelToDB(String filePath) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        FileInputStream fis = null;

        String insertSQL = "INSERT INTO booking (booking_time, booking_start_date, booking_end_date, " +
                "booking_room_cost, booking_service_cost, booking_food_cost, booking_sport_cost, booking_spa_cost, " +
                "booking_total_cost, payment_time, customer_id, room_id, payment_id, bs_id) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            // Kết nối DB
            conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);

            // Đọc file Excel
            fis = new FileInputStream(filePath);
            Workbook workbook = new XSSFWorkbook(fis);
            Sheet sheet = workbook.getSheetAt(0);

            pstmt = conn.prepareStatement(insertSQL);

            SimpleDateFormat datetimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

            int count = 0;

            // Bỏ qua header (dòng 0)
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null) continue;

                // booking_time (datetime)
                String bookingTimeStr = getCellString(row.getCell(0));
                Timestamp bookingTime = parseTimestamp(bookingTimeStr, datetimeFormat);

                // booking_start_date (date)
                String bookingStartStr = getCellString(row.getCell(1));
                Date bookingStartDate = dateFormat.parse(bookingStartStr);
                java.sql.Date bookingStart = new java.sql.Date(bookingStartDate.getTime());

                // booking_end_date (date)
                String bookingEndStr = getCellString(row.getCell(2));
                Date bookingEndDate = dateFormat.parse(bookingEndStr);
                java.sql.Date bookingEnd = new java.sql.Date(bookingEndDate.getTime());

                // booking_room_cost (decimal)
                double roomCost = row.getCell(3).getNumericCellValue();

                // booking_service_cost (decimal)
                double serviceCost = row.getCell(4).getNumericCellValue();

                // booking_food_cost (decimal)
                double foodCost = row.getCell(5).getNumericCellValue();

                // booking_sport_cost (decimal)
                double sportCost = row.getCell(6).getNumericCellValue();

                // booking_spa_cost (decimal)
                double spaCost = row.getCell(7).getNumericCellValue();

                // booking_total_cost (decimal)
                double totalCost = row.getCell(8).getNumericCellValue();

                // payment_time (datetime, nullable)
                String paymentTimeStr = getCellString(row.getCell(9));
                Timestamp paymentTime = null;
                if (paymentTimeStr != null && !paymentTimeStr.isEmpty()) {
                    paymentTime = parseTimestamp(paymentTimeStr, datetimeFormat);
                }

                // customer_id (int)
                int customerId = (int) row.getCell(10).getNumericCellValue();

                // room_id (int)
                int roomId = (int) row.getCell(11).getNumericCellValue();

                // payment_id (int)
                int paymentId = (int) row.getCell(12).getNumericCellValue();

                // bs_id (int)
                int bsId = (int) row.getCell(13).getNumericCellValue();

                // Set values vào PreparedStatement
                pstmt.setTimestamp(1, bookingTime);
                pstmt.setDate(2, bookingStart);
                pstmt.setDate(3, bookingEnd);
                pstmt.setDouble(4, roomCost);
                pstmt.setDouble(5, serviceCost);
                pstmt.setDouble(6, foodCost);
                pstmt.setDouble(7, sportCost);
                pstmt.setDouble(8, spaCost);
                pstmt.setDouble(9, totalCost);
                if (paymentTime != null) {
                    pstmt.setTimestamp(10, paymentTime);
                } else {
                    pstmt.setNull(10, Types.TIMESTAMP);
                }
                pstmt.setInt(11, customerId);
                pstmt.setInt(12, roomId);
                pstmt.setInt(13, paymentId);
                pstmt.setInt(14, bsId);

                pstmt.executeUpdate();
                count++;
            }

            workbook.close();
            System.out.println("Đã import thành công " + count + " bản ghi.");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
                if (fis != null) fis.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private static String getCellString(Cell cell) {
        if (cell == null) return null;

        if (cell.getCellType() == CellType.STRING) {
            return cell.getStringCellValue().trim();
        } else if (cell.getCellType() == CellType.NUMERIC) {
            if (DateUtil.isCellDateFormatted(cell)) {
                // Chuyển sang String yyyy-MM-dd hoặc yyyy-MM-dd HH:mm:ss
                Date date = cell.getDateCellValue();
                SimpleDateFormat sdf = (date.getHours() == 0 && date.getMinutes() == 0 && date.getSeconds() == 0)
                        ? new SimpleDateFormat("yyyy-MM-dd") : new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                return sdf.format(date);
            } else {
                return String.valueOf(cell.getNumericCellValue());
            }
        }
        return null;
    }

    private static Timestamp parseTimestamp(String datetimeStr, SimpleDateFormat sdf) throws Exception {
        Date date = sdf.parse(datetimeStr);
        return new Timestamp(date.getTime());
    }
}

