package controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itextpdf.io.image.ImageData;
import com.itextpdf.io.image.ImageDataFactory;
import com.itextpdf.kernel.color.Color;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Image;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.property.HorizontalAlignment;
import com.itextpdf.layout.property.TextAlignment;

import dao.revenue_reportDAO;
import model.revenue_report;

public class Revenue_reportController extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private ArrayList<revenue_report> list;
	private ArrayList<Double> list_tong_cong;
	private String img_path = "E:/noimg.png";
	private String pdf_path;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		LocalDate localDate = LocalDate.now();

		int day = localDate.getDayOfMonth();
		int month = localDate.getMonthValue();
		int year = localDate.getYear();

		int rr_id_1 = year * 100 + month;
		int rr_id_2 = year * 10000 + month * 100 + day;

		this.list = new ArrayList<>();
		this.list_tong_cong = new ArrayList<>();

		// revenue
		list.add(revenue_reportDAO.getInstance().selectById(year));
		list.add(revenue_reportDAO.getInstance().selectById(rr_id_1));
		list.add(revenue_reportDAO.getInstance().selectById(rr_id_2));

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
		req.getRequestDispatcher("/adjsp/revenue_report.jsp").forward(req, resp);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");
		if (action == null || "".equals(action)) {
			saveimg(req, resp);
		} else if ("savepdf".equals(action)) {
			savePDF(req, resp);
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
		this.img_path = "E:/revenue_chart_image_" + System.currentTimeMillis() + ".png";

		try (FileOutputStream fos = new FileOutputStream(this.img_path)) {
			fos.write(imageBytes);
		}
	}

	private void savePDF(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//int kq = 1;

		try {
			in_file_pdf();
		} catch (Exception e) {
			//kq = 0;
		}

//		String message = (kq > 0) ? "success" : "fail";
//		resp.sendRedirect(req.getContextPath() + "/revenue_report?message=" + message);
	}
	
	private void in_file_pdf() {
		try {

			this.pdf_path = "E:\\my_revenue_report_" + System.currentTimeMillis() + ".pdf";

			PdfWriter writer = new PdfWriter(this.pdf_path);
			PdfDocument pdfdocument = new PdfDocument(writer);
			Document document = new Document(pdfdocument);

			String fontPath = "C:/Windows/Fonts/arial.ttf"; // Đường dẫn font Windows, sửa cho phù hợp với máy bạn
			PdfFont font = PdfFontFactory.createFont(fontPath, com.itextpdf.io.font.PdfEncodings.IDENTITY_H, true);

			Paragraph p = new Paragraph("Thống kê doanh thu theo thời gian").setFont(font) // font
					.setFontSize(18) // cỡ chữ
					.setBold() // chữ đậm
					.setFontColor(Color.BLUE) // màu xanh
					.setTextAlignment(TextAlignment.CENTER) // căn giữa
					.setMarginBottom(30); // margin

			document.add(p);

			// *** ẢNH ***
			// File ảnh hoặc byte[] ảnh
			ImageData imageData = ImageDataFactory.create(this.img_path);
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
			table.addHeaderCell(new Cell().add(new Paragraph("Phòng").setBold()));
			table.addHeaderCell(new Cell().add(new Paragraph("Làm đẹp").setBold()));
			table.addHeaderCell(new Cell().add(new Paragraph("Thể thao").setBold()));
			table.addHeaderCell(new Cell().add(new Paragraph("Dịch vụ").setBold()));
			table.addHeaderCell(new Cell().add(new Paragraph("Ăn uống").setBold()));
			table.addHeaderCell(new Cell().add(new Paragraph("Tổng cộng").setBold()));

			double[] a = { 0, 0, 0, 0, 0, 0 };
			
			for (revenue_report rr : this.list) {
				table.addCell(String.valueOf(stt));
				table.addCell(formatDateId(String.valueOf(rr.getRr_id())));
				table.addCell(String.valueOf(rr.getRr_room()));
				table.addCell(String.valueOf(rr.getRr_spa()));
				table.addCell(String.valueOf(rr.getRr_sport()));
				table.addCell(String.valueOf(rr.getRr_service()));
				table.addCell(String.valueOf(rr.getRr_food()));
				table.addCell(String.valueOf(rr.getRr_amount()));
				a[0] += rr.getRr_room();
				a[1] += rr.getRr_spa();
				a[2] += rr.getRr_sport();
				a[3] += rr.getRr_service();
				a[4] += rr.getRr_food();
				a[5] += rr.getRr_amount();
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
	
	private ArrayList<revenue_report> report_by_day(int syear, int eyear, int smonth, int emonth, int sday, int eday) {
		ArrayList<revenue_report> list = new ArrayList<>();

		int s_id = syear * 10000 + smonth * 100 + sday; // yyyyMMdd 20250101
		int e_id = eyear * 10000 + emonth * 100 + eday;

		list = revenue_reportDAO.getInstance().selectBetween(s_id, e_id);

		return list;
	}

	private ArrayList<revenue_report> report_by_month(int syear, int eyear, int smonth, int emonth) {
		ArrayList<revenue_report> list = new ArrayList<>();

		int s_id = syear * 100 + smonth; // 202501
		int e_id = eyear * 100 + emonth;

		list = revenue_reportDAO.getInstance().selectBetween(s_id, e_id);

		return list;
	}

	private ArrayList<revenue_report> report_by_year(int syear, int eyear) {
		ArrayList<revenue_report> list = new ArrayList<>();

		int s_id = syear; // 2025
		int e_id = eyear;

		list = revenue_reportDAO.getInstance().selectBetween(s_id, e_id);

		return list;
	}
	
	private ArrayList<Double> getListTongCong() {
		ArrayList<Double> list = new ArrayList<>();

		double[] a = { 0, 0, 0, 0, 0, 0 };
		for (revenue_report rr : this.list) {
			a[0] += rr.getRr_room();
			a[1] += rr.getRr_spa();
			a[2] += rr.getRr_sport();
			a[3] += rr.getRr_service();
			a[4] += rr.getRr_food();
			a[5] += rr.getRr_amount();
		}

		for(int i = 0; i < 6; i++) {
			list.add(a[i]);
		}
		
		return list;
	}
}
