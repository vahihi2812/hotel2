package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

import dao.PayOSHelper;

public class PayServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderCode = "HD12345"; // Mã đơn hàng (có thể random)
        int amount = 100000; // Số tiền cần thanh toán
        String returnUrl = "http://localhost:8080/hotel2/return.jsp"; // URL trả về sau khi thanh toán

        try {
            String paymentUrl = PayOSHelper.createPaymentLink(amount, orderCode, returnUrl);
            response.sendRedirect(paymentUrl);
        } catch (IOException e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi tạo thanh toán: " + e.getMessage());
        }
    }
}