package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.*;
import model.*;


public class Room_TypeController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		ArrayList<room_type> list = new ArrayList<>();
		
		list = room_typeDAO.getIns().selectAll();
		
		req.setAttribute("list_room_type_all", list);
		
		req.getRequestDispatcher("/adjsp/room_type.jsp").forward(req, resp);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		String action = req.getParameter("action");

		if("edit".equals(action)){
			editRT(req, resp);
		}
	}
	
	private void editRT(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		int kq = 0;
		
		int rt_id = Integer.parseInt(req.getParameter("rt_id"));
		
		room_type rt = room_typeDAO.getIns().selectById(rt_id);
		
		String rt_name = req.getParameter("rt_name");
		String rt_description = req.getParameter("rt_description");
		java.math.BigDecimal rt_price = java.math.BigDecimal.valueOf(Double.parseDouble(req.getParameter("rt_price")));
		int rt_max_occupancy = Integer.parseInt(req.getParameter("rt_max_occupancy"));
		int rt_is_smoking_allowed = Integer.parseInt(req.getParameter("rt_is_smoking_allowed"));
		
		rt.setRt_name(rt_name);
		rt.setRt_description(rt_description);
		rt.setRt_price(rt_price);
		rt.setRt_max_occupancy(rt_max_occupancy);
		rt.setRt_is_smoking_allowed(rt_is_smoking_allowed);
		
		kq = room_typeDAO.getIns().update(rt);
		
		String message;
		if (kq > 0) {
		    message = "success";
		} else {
		    message = "fail";
		}
		resp.sendRedirect(req.getContextPath() + "/room_type?message=" + message);
	}

}
