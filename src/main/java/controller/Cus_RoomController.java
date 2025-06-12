package controller;

import java.io.IOException;
import java.util.ArrayList;

import model.room;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.roomDAO;

public class Cus_RoomController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		ArrayList<room> list = new ArrayList<>();
		
		list = roomDAO.getIns().selectAll();
		
		String floor_id = req.getParameter("floor_id");
		String rt_id = req.getParameter("rt_id");
		String rs_id = req.getParameter("rs_id");
		
		if(floor_id != null) {
			list = getRoomByCondition(list, floor_id, rt_id, rs_id);
		}
		
		req.setAttribute("list_room_all", list);
        
        req.getRequestDispatcher("/adjsp/phong.jsp").forward(req, resp);
	}
	
	public ArrayList<room> getRoomByCondition(ArrayList<room> l, String floor_id, String rt_id, String rs_id){		
		return filterByFloor(filterByType(filterByStatus(l, rs_id), rt_id), floor_id);
	}
	
	public ArrayList<room> filterByFloor(ArrayList<room> rooms, String floor_id) {
	    if ("all".equalsIgnoreCase(floor_id)) {
	        return rooms;
	    }

	    int id = Integer.parseInt(floor_id);
	    ArrayList<room> result = new ArrayList<>();
	    for (room room : rooms) {
	        if (room.getFloor_id() == id) {
	            result.add(room);
	        }
	    }
	    return result;
	}

	public ArrayList<room> filterByStatus(ArrayList<room> rooms, String rs_id) {
	    if ("all".equalsIgnoreCase(rs_id)) {
	        return rooms;
	    }

	    int id = Integer.parseInt(rs_id);
	    ArrayList<room> result = new ArrayList<>();
	    for (room room : rooms) {
	        if (room.getRs_id() == id) {
	            result.add(room);
	        }
	    }
	    return result;
	}

	public ArrayList<room> filterByType(ArrayList<room> rooms, String rt_id) {
	    if ("all".equalsIgnoreCase(rt_id)) {
	        return rooms;
	    }

	    int id = Integer.parseInt(rt_id);
	    ArrayList<room> result = new ArrayList<>();
	    for (room room : rooms) {
	        if (room.getRt_id() == id) {
	            result.add(room);
	        }
	    }
	    return result;
	}
}
