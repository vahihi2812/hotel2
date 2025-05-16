package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.accountDAO;
import dao.userDAO;
import model.*;

public class ProfileController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		HttpSession session = req.getSession();
		account acc = (account) session.getAttribute("account");
		//user u = (user) session.getAttribute("user");

		if (acc == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		int role_id = acc.getRole_id();

		if (role_id != 1) {
			// Chỉ cho phép vai trò ADMIN truy cập
			resp.sendRedirect(req.getContextPath() + "/login"); // Chuyển hướng đến trang login
			return;
		}

		req.getRequestDispatcher("/adjsp/users-profile.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		String action = req.getParameter("action");

		if ("u_pw".equals(action)) {
			updatePass(req, resp);
		} else if ("u_inf".equals(action)) {
			updateInfo(req, resp);
		}
	}

	private void updatePass(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String password = req.getParameter("password");
		String newPassword = req.getParameter("newPassword");
		String renewPassword = req.getParameter("renewPassword");

		HttpSession session = req.getSession();
		account acc = (account) session.getAttribute("account"); // lấy từ session

		int kq = 0;

		if (password.equals(acc.getAccount_password())) {
			
			if (newPassword.equals(renewPassword)) {
				acc.setAccount_password(newPassword);
				kq = accountDAO.getIns().update(acc);
			}
		}

		String message = "";

		if (kq == 1) {
			//session.setAttribute("account", acc); // cập nhật lại session nếu cần - không hiểu sao có dòng này thì lỗi không đổi mk
			message = "success";
		} else {
			message = "fail";
		}
		resp.sendRedirect(req.getContextPath() + "/profile?message=" + message);
	}

	private void updateInfo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    // Lấy tham số theo đúng name trong form
	    String fullName = req.getParameter("user_fullname");
	    String dob = req.getParameter("user_date_of_birth");
	    String address = req.getParameter("user_address");
	    String genderStr = req.getParameter("user_gender");
	    String phone = req.getParameter("user_phone_number");
	    String email = req.getParameter("user_email");

	    HttpSession session = req.getSession();
	    user u = (user) session.getAttribute("user");

	    String message = "";

	    if (u != null) {
	        u.setUser_fullname(fullName);
	        u.setUser_address(address);
	        u.setUser_phone_number(phone);
	        u.setUser_email(email);

	        try {
	            // Chuyển đổi ngày sinh từ String về java.sql.Date
	            if (dob != null && !dob.isEmpty()) {
	                java.sql.Date dateOfBirth = java.sql.Date.valueOf(dob);
	                u.setUser_date_of_birth(dateOfBirth);
	            }
	        } catch (IllegalArgumentException e) {
	            // Handle invalid date
	            e.printStackTrace();
	        }

	        try {
	            u.setUser_gender(Integer.parseInt(genderStr));
	        } catch (NumberFormatException e) {
	            u.setUser_gender(0); // mặc định là nam nếu lỗi
	        }

	        int kq = userDAO.getInstance().update(u);

	        if (kq != 0) {
	            session.setAttribute("user", u); // cập nhật lại session
	            message = "success";
	        } else {
	            message = "fail";
	        }
	    } else {
	        message = "fail";
	    }

	    resp.sendRedirect(req.getContextPath() + "/profile?message=" + message);
	}


}
