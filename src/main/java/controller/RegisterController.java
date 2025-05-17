package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.accountDAO;
import dao.customerDAO;
import model.account;
import model.customer;

public class RegisterController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/adjsp/pages-register.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");

		if("reg".equals(action)){
			registerAcc(req, resp);
		}
	}
	
	private void registerAcc(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		String username = req.getParameter("username");
		String password = req.getParameter("password");

		int kq = accountDAO.getIns().findByUsername(username);
		if (kq == 0) {	
			account acc = new account(0, username, password, 1, null, null, null, 0, 2);
			accountDAO.getIns().insert(acc);
			
			acc = accountDAO.getIns().findByUsernameAndPassword(username, password);
//			customer cus = new customer();
//			cus.setCustomer_firstname(username);
//			cus.setCustomer_lastname(username);
//			cus.setAccount_id(acc.getAccount_id());
//			customerDAO.getIns().insert(cus);
			
			req.setAttribute("noti", "Tạo tài khoản thành công");
			req.getRequestDispatcher("/adjsp/pages-register.jsp").forward(req, resp);
		} else {
			req.setAttribute("error", "Tài khoản đã tồn tại");
			req.getRequestDispatcher("/adjsp/pages-register.jsp").forward(req, resp);
		}
	}
}
