package test;

import java.util.ArrayList;

import com.itextpdf.kernel.color.Color;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.property.HorizontalAlignment;
import com.itextpdf.layout.property.TextAlignment;

import dao.booking_reportDAO;
import model.booking_report;

public class testbr {
	public static void main(String[] args) {
		ArrayList<booking_report> list = booking_reportDAO.getInstance().selectAll();
		
		try {
			String path = "E:\\my_booking_report.pdf";
			PdfWriter writer = new PdfWriter(path);
			PdfDocument pdfdocument = new PdfDocument(writer);
			Document document = new Document(pdfdocument);
			
			String fontPath = "C:/Windows/Fonts/arial.ttf"; // Đường dẫn font Windows, sửa cho phù hợp với máy bạn
		    PdfFont font = PdfFontFactory.createFont(fontPath, com.itextpdf.io.font.PdfEncodings.IDENTITY_H, true);
			
			Paragraph p = new Paragraph("Thống kê lượt đặt phòng theo thời gian")
					.setFont(font)
				    .setFontSize(18)                    // cỡ chữ to
				    .setBold()                         // chữ đậm
				    .setFontColor(Color.BLUE) // màu xanh
				    .setTextAlignment(TextAlignment.CENTER) // căn giữa
					.setMarginBottom(30);
			
			document.add(p);
				
			// Bảng	
			int stt = 1;	
				
			//	Số cột + độ rộng
			float[] columnWidths = {100F, 150F, 250F};
			Table table = new Table(columnWidths);
			table.setHorizontalAlignment(HorizontalAlignment.CENTER)
				 .setFont(font)
				 .setFontSize(13)
				 .setTextAlignment(TextAlignment.CENTER);
			
			// Thêm tiêu đề
			table.addHeaderCell(new Cell().add(new Paragraph("STT").setBold()));
			table.addHeaderCell(new Cell().add(new Paragraph("Thời gian").setBold()));
			table.addHeaderCell(new Cell().add(new Paragraph("Số lượt đặt").setBold()));

			
			for(booking_report br : list) {
				table.addCell(String.valueOf(stt));
				table.addCell(formatDateId(String.valueOf(br.getBr_id())));
				table.addCell(String.valueOf(br.getBr_amount()));
				stt++;
			}
			
			document.add(table);
			
			document.close();
		} catch (Exception e) {
			System.err.println("Loi in pdf " + e);
			return;
		}finally {
			System.out.println("in thanh cong!");
		}
	}
	
	private static String formatDateId(String id) {
	    if (id == null || id.length() < 4) return "ID không hợp lệ";
	
	    try {
	        if (id.length() == 4) {   //20250517
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
}
