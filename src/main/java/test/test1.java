package test;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import dao.booking_reportDAO;
import model.booking_report;

public class test1 {
	public static void main(String[] args) {
		// Excel
		ArrayList<booking_report> list = booking_reportDAO.getInstance().selectBetween(2022, 2025);

		Workbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("Danh sách");

		int rowIndex = 0;
		for (booking_report br : list) {
			Row row = sheet.createRow(rowIndex++);
			row.createCell(0).setCellValue(br.getBr_id());
			row.createCell(1).setCellValue(br.getBr_amount());
		}

		try {
			FileOutputStream fileOut = new FileOutputStream("E:\\danhsach.csv");
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
}
