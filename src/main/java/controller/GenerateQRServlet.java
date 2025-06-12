package controller;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;

import util.IPFetcher;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.OutputStream;

public class GenerateQRServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String ip_root = "http://" + IPFetcher.getInstance().getVa_ip() + ":8080/hotel2/";
		
		String text = req.getParameter("text"); // nội dung QR code
		if (text == null || text.isEmpty()) {
			text = "Hello, QR Code!";
		} 
		else {
			switch (text) {
				case "ft_pdf": {
					text = ip_root + "download?ft=" + "ft_pdf";
					break;
				}
				case "ft_xlsx": {
					text = ip_root + "download?ft=" + "ft_xlsx";
					break;
				}
				case "ft_csv": {
					text = ip_root + "download?ft=" + "ft_csv";
					break;
				}
				case "ft_png": {
					text = ip_root + "download?ft=" + "ft_png";
					break;
				}
				case "err1": {
					text = Error_formController.getLinkErr1();
					break;
				}
				case "err2": {
					text = Error_formController.getLinkErr2();
					break;
				}
				case "err3": {
					text = Error_formController.getLinkErr3();
					break;
				}
				case "err4": {
					text = Error_formController.getLinkErr4();
					break;
				}
				default:{
					text = "https://www.facebook.com/viet.anh.ao.41373";
				}
			}
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
