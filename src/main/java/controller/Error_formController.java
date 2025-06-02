package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Error_formController extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private static final String link_err_1 = "https://forms.gle/wbUTYR19c98tinc78";
	private static final String link_err_2 = "https://forms.gle/rc44ptw75DiZXKsx5";
	private static final String link_err_3 = "https://forms.gle/GVxQVmz5TuSn8AdM8";
	private static final String link_err_4 = "https://forms.gle/cnVebKdDQUuwBJWWA";
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/adjsp/rpform.jsp").forward(req, resp);
	}

	public static String getLinkErr1() {
		return link_err_1;
	}

	public static String getLinkErr2() {
		return link_err_2;
	}

	public static String getLinkErr3() {
		return link_err_3;
	}

	public static String getLinkErr4() {
		return link_err_4;
	}
	
}
