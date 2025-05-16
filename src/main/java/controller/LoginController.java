package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.accountDAO;
import dao.userDAO;
import model.account;
import model.user;

public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// Hiển thị trang đăng nhập
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/adjsp/pages-login.jsp").forward(req, resp);
	}

	// Xử lý đăng nhập
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username = req.getParameter("username");
		String password = req.getParameter("password");

		account acc = accountDAO.getIns().findByUsernameAndPassword(username, password);
		// Kiểm tra username/password (ví dụ đơn giản, bạn có thể thay bằng check từ DB)
		if (acc != null && acc.getRole_id() == 1) {
			
			user u = userDAO.getInstance().getUserByAccountId(acc.getAccount_id());
			accountDAO.getIns().updateLastLogin(acc);
			
			HttpSession session = req.getSession();			
			session.setAttribute("account", acc);
			session.setAttribute("user", u);
			
			resp.sendRedirect(req.getContextPath() + "/home");
		} else {
			req.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
			req.getRequestDispatcher("/adjsp/pages-login.jsp").forward(req, resp);
		}
	}
}
