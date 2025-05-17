package controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.booking_reportDAO;

public class HomeController extends HttpServlet{
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
        str.append(year);        		
        str.append(month);
        
        String s1 = str.toString();
        
        str.append(day);        
        String s2 = str.toString();
        
        int br_id_1 = Integer.parseInt(s1);
        int br_id_2 = Integer.parseInt(s2);
        
        ArrayList<Integer> list = new ArrayList<>();
        list.add(booking_reportDAO.getInstance().selectById(year).getBr_amount());
        list.add(booking_reportDAO.getInstance().selectById(br_id_1).getBr_amount());
        list.add(booking_reportDAO.getInstance().selectById(br_id_2).getBr_amount());
        
        req.setAttribute("br_list", list);
		
		req.getRequestDispatcher("/adjsp/index.jsp").forward(req, resp);
	}
}
