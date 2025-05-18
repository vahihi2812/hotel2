package controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.booking_reportDAO;
import model.booking_report;

public class Booking_reportController extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		LocalDate localDate = LocalDate.now();

		int day = localDate.getDayOfMonth();
		int month = localDate.getMonthValue();
		int year = localDate.getYear();

		StringBuilder str = new StringBuilder();
		str.append(year); // 2025

		if (month < 10)
			str.append(0);
		str.append(month);

		String s1 = str.toString(); // year + month 202505

		if (day < 10)
			str.append(0);
		str.append(day);
		String s2 = str.toString(); // year + month + day 20250517

		int br_id_1 = Integer.parseInt(s1);
		int br_id_2 = Integer.parseInt(s2);

		ArrayList<booking_report> list = new ArrayList<>();

		// booking
		list.add(booking_reportDAO.getInstance().selectById(year));
		list.add(booking_reportDAO.getInstance().selectById(br_id_1));
		list.add(booking_reportDAO.getInstance().selectById(br_id_2));

		req.setAttribute("list", list);
		
		req.getRequestDispatcher("/adjsp/booking_report.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");		
	}
}
