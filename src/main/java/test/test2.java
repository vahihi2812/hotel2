package test;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

import dao.booking_reportDAO;
import model.booking_report;

public class test2 {
	public static void main(String[] args) {
		ArrayList<booking_report> list = booking_reportDAO.getInstance().selectBetween(2022, 2025);
		String filePath = "E:\\myrp" + System.currentTimeMillis() + ".csv";

		try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
			// Ghi tiêu đề
			writer.write("date, y");
			writer.newLine();

			// Ghi từng dòng dữ liệu
			for (booking_report report : list) {
				writer.write(report.getBr_id() + "," + report.getBr_amount());
				writer.newLine();
			}

			System.out.println("Đã ghi file booking_report.csv thành công.");
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
}
