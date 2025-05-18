package controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.cj.Session;

import dao.booking_reportDAO;
import dao.customer_reportDAO;
import dao.revenue_reportDAO;

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
        str.append(year); // 2025
        
        if(month < 10)
        	str.append(0);
        str.append(month);
        
        String s1 = str.toString(); // year + month 202505
        
        if(day < 10)
        	str.append(0);
        str.append(day);        
        String s2 = str.toString(); // year + month + day 20250517
        
        int br_id_1 = Integer.parseInt(s1);
        int br_id_2 = Integer.parseInt(s2);
        
        ArrayList<Integer> list = new ArrayList<>();
        // booking
        list.add(booking_reportDAO.getInstance().selectById(year).getBr_amount());
        list.add(booking_reportDAO.getInstance().selectById(br_id_1).getBr_amount());
        list.add(booking_reportDAO.getInstance().selectById(br_id_2).getBr_amount());
        
        // customer
        list.add(customer_reportDAO.getInstance().selectById(year).getCr_amount());
        list.add(customer_reportDAO.getInstance().selectById(br_id_1).getCr_amount());
        list.add(customer_reportDAO.getInstance().selectById(br_id_2).getCr_amount());
        
        
        
        req.setAttribute("br_list", list);
		
		req.getRequestDispatcher("/adjsp/index.jsp").forward(req, resp);
	}
}
