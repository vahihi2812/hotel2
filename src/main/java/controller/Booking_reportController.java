package controller;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Image;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.property.HorizontalAlignment;
import com.itextpdf.layout.property.TextAlignment;
import com.itextpdf.io.image.ImageData;
import com.itextpdf.io.image.ImageDataFactory;
import com.itextpdf.kernel.color.Color;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;

import dao.booking_reportDAO;
import model.booking_report;
import util.SendEmail;

public class Booking_reportController extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private ArrayList<booking_report> list;
	private ArrayList<Integer> list_tong_cong;
	private static String img_path = "E:/noimg.png";
	private static String pdf_path = "E:\\mau.pdf";
	private static String csv_path = "E:\\mau.csv";
	private static String xlsx_path = "E:\\mau.xlsx";
	private int[] a = { 0, 0, 0, 0, 0, 0 };

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		LocalDate localDate = LocalDate.now();

		int day = localDate.getDayOfMonth();
		int month = localDate.getMonthValue();
		int year = localDate.getYear();

		int br_id_1 = year * 100 + month;
		int br_id_2 = year * 10000 + month * 100 + day;

		this.list = new ArrayList<>();
		this.list_tong_cong = new ArrayList<>();

		// booking
		this.list.add(booking_reportDAO.getInstance().selectById(year));
		this.list.add(booking_reportDAO.getInstance().selectById(br_id_1));
		this.list.add(booking_reportDAO.getInstance().selectById(br_id_2));

		String start_date = "";
		String end_date = "";
		String d = "";

		// ?action=ana&d=day&s=2025-05-06&e=2025-05-22
		String action = req.getParameter("action");

		if (action != null && !"".equals(action)) {

			start_date = req.getParameter("s");
			end_date = req.getParameter("e");
			String[] s = start_date.split("-");
			String[] e = end_date.split("-");
			int syear = Integer.parseInt(s[0]);
			int eyear = Integer.parseInt(e[0]);
			int smonth = Integer.parseInt(s[1]);
			int emonth = Integer.parseInt(e[1]);
			int sday = Integer.parseInt(s[2]);
			int eday = Integer.parseInt(e[2]);

			// Thong ke theo
			d = req.getParameter("d");

			switch (d) {
			case "year":
				this.list = report_by_year(syear, eyear);
				break;
			case "month":
				this.list = report_by_month(syear, eyear, smonth, emonth);
				break;
			case "day":
				this.list = report_by_day(syear, eyear, smonth, emonth, sday, eday);
				break;
			default:
				break;
			}
		}

		this.list_tong_cong = getListTongCong();

		req.setAttribute("d", d);
		req.setAttribute("s", start_date);
		req.setAttribute("e", end_date);
		req.setAttribute("list", this.list);
		req.setAttribute("list_tong_cong", this.list_tong_cong);

		req.getRequestDispatcher("/adjsp/booking_report.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");
		if (action == null || "".equals(action)) {
			saveimg(req, resp); // save image
		} else {
			switch (action) {
			case "savepdf": {
				savePDF(req, resp);
				break;
			}
			case "savexlsx": {
				saveXLSX(req, resp);
				break;
			}
			case "savecsv": {
				saveCSV(req, resp);
				break;
			}
			case "send_em": {
				sendEM(req, resp);
				break;
			}
			default:
				break;
			}
		}
	}

	private void sendEM(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String recipientEmail = req.getParameter("recipientEmail");
			String format = req.getParameter("format");
			SendEmail se = new SendEmail(recipientEmail, format);
			se.send_email();
		} catch (Exception e) {
			System.err.println("send email " + e);
		}
	}

	private void saveimg(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String base64Image = req.getParameter("imageData");

		// Xóa phần tiền tố "data:image/png;base64,"
		if (base64Image != null && base64Image.startsWith("data:image")) {
			base64Image = base64Image.substring(base64Image.indexOf(",") + 1);
		}

		// Giải mã base64 thành mảng byte
		byte[] imageBytes = Base64.getDecoder().decode(base64Image);

		// Lưu file ảnh
		img_path = "E:/booking_chart_image_" + System.currentTimeMillis() + ".png";

		try (FileOutputStream fos = new FileOutputStream(img_path)) {
			fos.write(imageBytes);
		}
	}

	private void savePDF(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			in_file_pdf();
		} catch (Exception e) {
			System.err.println("Xuat booking report pdf " + e);
		}
	}

	private void saveXLSX(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			in_file_xlsx();
		} catch (Exception e) {
			System.err.println("Xuat booking report xlsx " + e);
		}
	}

	private void saveCSV(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			in_file_csv();
		} catch (Exception e) {
			System.err.println("Xuat booking report csv " + e);
		}
	}

	private void in_file_xlsx() {
		// Excel
		Workbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("danh_sach");

		int rowIndex = 0;

		Row row = sheet.createRow(rowIndex++);
		row.createCell(0).setCellValue("STT");
		row.createCell(1).setCellValue("Thời gian");
		row.createCell(2).setCellValue("Tầng 1");
		row.createCell(3).setCellValue("Tầng 2");
		row.createCell(4).setCellValue("Tầng 3");
		row.createCell(5).setCellValue("Tầng 4");
		row.createCell(6).setCellValue("Tầng 5");
		row.createCell(7).setCellValue("Tổng");

		for (booking_report br : list) {
			row = sheet.createRow(rowIndex++);
			row.createCell(0).setCellValue(rowIndex - 1);
			row.createCell(1).setCellValue(formatDateId(String.valueOf(br.getBr_id())));
			row.createCell(2).setCellValue(br.getBr_floor_1());
			row.createCell(3).setCellValue(br.getBr_floor_2());
			row.createCell(4).setCellValue(br.getBr_floor_3());
			row.createCell(5).setCellValue(br.getBr_floor_5());
			row.createCell(6).setCellValue(br.getBr_floor_5());
			row.createCell(7).setCellValue(br.getBr_amount());
		}

		try {
			xlsx_path = "E:\\my_booking_report_" + System.currentTimeMillis() + ".xlsx";
			FileOutputStream fileOut = new FileOutputStream(xlsx_path);
			workbook.write(fileOut);
			System.out.println("Ghi Excel thành công!");
		} catch (IOException e) {
			e.printStackTrace();
		}

		try {
			workbook.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void in_file_csv() {
		csv_path = "E:\\my_booking_report_" + System.currentTimeMillis() + ".csv";

		try (BufferedWriter writer = new BufferedWriter(new FileWriter(csv_path))) {
			// Ghi tiêu đề
			writer.write("date, f1, f2, f3, f4, f5, total");
			writer.newLine();

			// Ghi từng dòng dữ liệu
			for (booking_report report : list) {
				StringBuilder tmp = new StringBuilder("");
				tmp.append(formatDateIdforCSV(String.valueOf(report.getBr_id())) + ",");
				tmp.append(report.getBr_floor_1() + ",");
				tmp.append(report.getBr_floor_2() + ",");
				tmp.append(report.getBr_floor_3() + ",");
				tmp.append(report.getBr_floor_4() + ",");
				tmp.append(report.getBr_floor_5() + ",");
				tmp.append(report.getBr_amount());

				writer.write(tmp.toString());
				writer.newLine();
			}

			System.out.println("Đã ghi file booking_report.csv thành công.");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void in_file_pdf() {
		try {
			pdf_path = "E:\\my_booking_report_" + System.currentTimeMillis() + ".pdf";

			PdfWriter writer = new PdfWriter(pdf_path);
			PdfDocument pdfdocument = new PdfDocument(writer);
			Document document = new Document(pdfdocument);

			String fontPath = "C:/Windows/Fonts/arial.ttf"; // Đường dẫn font Windows, sửa cho phù hợp với máy bạn
			PdfFont font = PdfFontFactory.createFont(fontPath, com.itextpdf.io.font.PdfEncodings.IDENTITY_H, true);

			Paragraph p = new Paragraph("Thống kê lượt đặt phòng theo thời gian").setFont(font) // font
					.setFontSize(18) // cỡ chữ
					.setBold() // chữ đậm
					.setFontColor(Color.BLUE) // màu xanh
					.setTextAlignment(TextAlignment.CENTER) // căn giữa
					.setMarginBottom(30); // margin

			document.add(p);

			// *** ẢNH ***
			// File ảnh hoặc byte[] ảnh
			ImageData imageData = ImageDataFactory.create(img_path);
			Image pdfImage = new Image(imageData);

			// Chỉnh kích thước
			pdfImage.scaleToFit(500, 750);
			pdfImage.setHorizontalAlignment(HorizontalAlignment.CENTER);

			// add
			document.add(pdfImage);

			// *** BANG ***
			int stt = 1;

			// Số cột + độ rộng
			float[] columnWidths = { 50F, 100F, 60F, 60F, 60F, 60F, 60F, 50F };
			Table table = new Table(columnWidths);
			table.setHorizontalAlignment(HorizontalAlignment.CENTER).setFont(font).setFontSize(13)
					.setTextAlignment(TextAlignment.CENTER);

			// Thêm tiêu đề
			table.addHeaderCell(new Cell().add(new Paragraph("STT").setBold()));
			table.addHeaderCell(new Cell().add(new Paragraph("Thời gian").setBold()));
			table.addHeaderCell(new Cell().add(new Paragraph("Tầng 1").setBold()));
			table.addHeaderCell(new Cell().add(new Paragraph("Tầng 2").setBold()));
			table.addHeaderCell(new Cell().add(new Paragraph("Tầng 3").setBold()));
			table.addHeaderCell(new Cell().add(new Paragraph("Tầng 4").setBold()));
			table.addHeaderCell(new Cell().add(new Paragraph("Tầng 5").setBold()));
			table.addHeaderCell(new Cell().add(new Paragraph("Tổng").setBold()));

			for (booking_report br : this.list) {
				table.addCell(String.valueOf(stt));
				table.addCell(formatDateId(String.valueOf(br.getBr_id())));
				table.addCell(String.valueOf(br.getBr_floor_1()));
				table.addCell(String.valueOf(br.getBr_floor_2()));
				table.addCell(String.valueOf(br.getBr_floor_3()));
				table.addCell(String.valueOf(br.getBr_floor_4()));
				table.addCell(String.valueOf(br.getBr_floor_5()));
				table.addCell(String.valueOf(br.getBr_amount()));
				a[0] += br.getBr_floor_1();
				a[1] += br.getBr_floor_2();
				a[2] += br.getBr_floor_3();
				a[3] += br.getBr_floor_4();
				a[4] += br.getBr_floor_5();
				a[5] += br.getBr_amount();
				stt++;
			}

			table.addCell("");
			table.addCell("Tổng cộng");
			table.addCell(String.valueOf(a[0]));
			table.addCell(String.valueOf(a[1]));
			table.addCell(String.valueOf(a[2]));
			table.addCell(String.valueOf(a[3]));
			table.addCell(String.valueOf(a[4]));
			table.addCell(String.valueOf(a[5]));

			document.add(table);

			document.close();
		} catch (Exception e) {
			System.err.println("Loi in pdf " + e);
		}
	}

	private String formatDateId(String id) {
		if (id == null || id.length() < 4)
			return "ID không hợp lệ";

		try {
			if (id.length() == 4) { // 20250517
				// Năm
				return "Năm " + id;
			} else if (id.length() == 6) {
				// Tháng + Năm (yyyyMM)
				String year = id.substring(0, 4);
				String month = id.substring(4, 6);
				return "Tháng " + Integer.parseInt(month) + "/" + year;
			} else if (id.length() == 8) {
				// Ngày + Tháng + Năm (yyyyMMdd)
				String year = id.substring(0, 4);
				String month = id.substring(4, 6);
				String day = id.substring(6, 8);
				return Integer.parseInt(day) + "/" + Integer.parseInt(month) + "/" + year;
			} else {
				return "Định dạng ID không hỗ trợ";
			}
		} catch (Exception e) {
			return "Lỗi định dạng ID";
		}
	}

	private String formatDateIdforCSV(String id) {
		if (id == null || id.length() < 4)
			return "ID không hợp lệ";

		try {
			if (id.length() == 4) { // 20250517
				// Năm
				return id;
			} else if (id.length() == 6) {
				// Tháng + Năm (yyyyMM)
				String year = id.substring(0, 4);
				String month = id.substring(4, 6);
				return Integer.parseInt(month) + "/" + year;
			} else if (id.length() == 8) {
				// Ngày + Tháng + Năm (yyyyMMdd)
				String year = id.substring(0, 4);
				String month = id.substring(4, 6);
				String day = id.substring(6, 8);
				return Integer.parseInt(day) + "/" + Integer.parseInt(month) + "/" + year;
			} else {
				return "Định dạng ID không hỗ trợ";
			}
		} catch (Exception e) {
			return "Lỗi định dạng ID";
		}
	}

	private ArrayList<booking_report> report_by_day(int syear, int eyear, int smonth, int emonth, int sday, int eday) {
		ArrayList<booking_report> list = new ArrayList<>();

		int s_id = syear * 10000 + smonth * 100 + sday; // yyyyMMdd 20250101
		int e_id = eyear * 10000 + emonth * 100 + eday;

		list = booking_reportDAO.getInstance().selectBetween(s_id, e_id);

		return list;
	}

	private ArrayList<booking_report> report_by_month(int syear, int eyear, int smonth, int emonth) {
		ArrayList<booking_report> list = new ArrayList<>();

		int s_id = syear * 100 + smonth; // 202501
		int e_id = eyear * 100 + emonth;

		list = booking_reportDAO.getInstance().selectBetween(s_id, e_id);

		return list;
	}

	private ArrayList<booking_report> report_by_year(int syear, int eyear) {
		ArrayList<booking_report> list = new ArrayList<>();

		int s_id = syear; // 2025
		int e_id = eyear;

		list = booking_reportDAO.getInstance().selectBetween(s_id, e_id);

		return list;
	}

	private ArrayList<Integer> getListTongCong() {
		ArrayList<Integer> list = new ArrayList<>();

		int[] a = { 0, 0, 0, 0, 0, 0 };
		for (booking_report br : this.list) {
			a[0] += br.getBr_floor_1();
			a[1] += br.getBr_floor_2();
			a[2] += br.getBr_floor_3();
			a[3] += br.getBr_floor_4();
			a[4] += br.getBr_floor_5();
			a[5] += br.getBr_amount();
		}

		for (int i = 0; i < 6; i++) {
			list.add(a[i]);
		}

		return list;
	}

	public static String getPDFPath() {
		return pdf_path;
	}

	public static String getXLSXPath() {
		return xlsx_path;
	}

	public static String getCSVPath() {
		return csv_path;
	}
	
	public static String getImg_path() {
		return img_path;
	}
}
