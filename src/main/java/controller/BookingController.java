package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.bookingDAO;
import dao.roomDAO;
import model.booking;
import model.room;
import model.room_type;

public class BookingController extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ArrayList<booking> list = bookingDAO.getIns().selectAll();
		ArrayList<room> listroom = roomDAO.getIns().selectAll();
		
		req.setAttribute("listbk", list);
		req.setAttribute("listroom", list);
		
		req.getRequestDispatcher("/adjsp/booking.jsp").forward(req, resp);
	}
}
