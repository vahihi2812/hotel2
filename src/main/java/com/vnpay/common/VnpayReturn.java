package com.vnpay.common;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.time.LocalDate;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import dao.bookingDAO;
import dao.booking_reportDAO;
import dao.revenue_reportDAO;
import dao.roomDAO;
import model.booking;
import model.customer;

public class VnpayReturn extends HttpServlet {
    
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            Map fields = new HashMap();
            for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
                String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    fields.put(fieldName, fieldValue);
                }
            }

            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            if (fields.containsKey("vnp_SecureHashType")) {
                fields.remove("vnp_SecureHashType");
            }
            if (fields.containsKey("vnp_SecureHash")) {
                fields.remove("vnp_SecureHash");
            }
            String signValue = Config.hashAllFields(fields);
            if (signValue.equals(vnp_SecureHash)) {
                String paymentCode = request.getParameter("vnp_TransactionNo");
                
                String orderId = request.getParameter("vnp_TxnRef");
                
                String orderInfo = request.getParameter("vnp_OrderInfo");
                String[] parts = orderInfo.split("_");
                int roomId = Integer.parseInt(parts[0]);
                int rentDays = Integer.parseInt(parts[1]);
                Double r_cost = Double.parseDouble(parts[2]);
                r_cost /= 1000000;
                System.out.println("roomid " + roomId  + " rentDays " + rentDays);
                booking bk = new booking();
                HttpSession session = request.getSession();
                customer cus = (customer)session.getAttribute("customer");
                LocalDate today = LocalDate.now(); // ngày hôm nay
                LocalDate endDate = today.plusDays(rentDays); // ngày kết thúc

                // Nếu bạn dùng java.sql.Date để lưu vào DB:
                Date sqlStartDate = Date.valueOf(today);
                Date sqlEndDate = Date.valueOf(endDate);
                bk.setRoom_id(roomId);
                bk.setCustomer_id(cus.getCustomer_id());
                bk.setBooking_start_date(sqlStartDate);
                bk.setBooking_end_date(sqlEndDate);
                bk.setBooking_room_cost(r_cost);
                bk.setBooking_total_cost(r_cost);
                
                boolean transSuccess = false;
                if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
                    //update banking system
                    transSuccess = true;
                    // insert
                    bookingDAO.getIns().insert(bk);
                    System.out.println("Insert to booking");
                    // chuyen trang thai phong
                    roomDAO.getIns().updateTrangThai(roomId, 2);
                    // update booking report
            		int day = today.getDayOfMonth();
            		int month = today.getMonthValue();
            		int year = today.getYear();           		
                    booking_reportDAO.getInstance().updateAfterBookingSuccess(year * 10000 + month * 100 + day);
                    // update rev
                    revenue_reportDAO.getInstance().updateAfterBookig(r_cost, year * 10000 + month * 100 + day);
                } else {
                }
                request.setAttribute("transResult", transSuccess);
                request.getRequestDispatcher("paymentResult.jsp").forward(request, response);
            } else {
                //RETURN PAGE ERROR
                System.out.println("GD KO HOP LE (invalid signature)");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
