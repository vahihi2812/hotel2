package controller;

import java.io.*;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DownloadServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private static String filePath = "E:\\pdfmau.pdf";

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String fileName = req.getParameter("ft");
        if (fileName == null || fileName.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing file parameter");
            return;
        }
        
        switch(fileName) {
        	case "ft_pdf":{
        		String tmp = Booking_reportController.getPDFPath();
                if(tmp != null || !"".equals(tmp)) {
                	filePath = tmp;
                }break;
        	}
        	
        	case "ft_xlsx":{
        		String tmp = Booking_reportController.getXLSXPath();
                if(tmp != null || !"".equals(tmp)) {
                	filePath = tmp;
                }break;
        	}
        	
        	case "ft_csv":{
        		String tmp = Booking_reportController.getCSVPath();
                if(tmp != null || !"".equals(tmp)) {
                	filePath = tmp;
				}
				break;
        	}
        	
        	default:{
        		break;
        	}
        	
        }
        
        File file = new File(filePath);
        
        if (!file.exists()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found");
            return;
        }
        
        // Set header để trình duyệt tải file
        resp.setContentType(getServletContext().getMimeType(filePath));
        resp.setHeader("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"");
        resp.setContentLengthLong(file.length());
        
        // Đọc và ghi file ra response
        try (BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
             BufferedOutputStream out = new BufferedOutputStream(resp.getOutputStream())) {
            byte[] buffer = new byte[8192];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }
    }
}
