package controller;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.OutputStream;

public class GenerateQRServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String text = req.getParameter("text"); // nội dung QR code
        if (text == null || text.isEmpty()) {
            text = "Hello, QR Code!";
        }else {
//        	text = "https://docs.google.com/forms/d/e/1FAIpQLSdTjMKtKK5s0OvLRZE0R_2ipSopVamvtfGofCEtPIc91fpd4g/viewform?usp=header";
//        	text = "http://192.168.1.8:8080/hotel2/booking_report";
        	text = "http://192.168.1.8:8080/hotel2/download?ft=" + text;
        }   

        try {
            BitMatrix bitMatrix = new MultiFormatWriter().encode(text, BarcodeFormat.QR_CODE, 250, 250);
            resp.setContentType("image/png");
            OutputStream os = resp.getOutputStream();
            MatrixToImageWriter.writeToStream(bitMatrix, "PNG", os);
            os.flush();
            os.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
}
