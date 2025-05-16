package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.roomDAO;
import model.room;


public class RoomController extends HttpServlet {

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
		
		req.getRequestDispatcher("/adjsp/room.jsp").forward(req, resp);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		String action = req.getParameter("action");

		if("edit".equals(action)){
			editRoom(req, resp);
		}
	}
	
	private void editRoom(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		int kq = 0;
		
		int room_id = Integer.parseInt(req.getParameter("room_id"));
		String room_description = req.getParameter("room_description");
		String room_view = req.getParameter("room_view");
		int rt_id = Integer.parseInt(req.getParameter("rt_id"));
		int rs_id = Integer.parseInt(req.getParameter("rs_id"));
		
		room r = roomDAO.getIns().selectById(room_id);
		r.setRoom_description(room_description);
		r.setRoom_view(room_view);
		r.setRs_id(rs_id);
		r.setRt_id(rt_id);
		
		kq = roomDAO.getIns().update(r);
		
		String message;
		if (kq > 0) {
		    message = "success";
		} else {
		    message = "fail";
		}
		resp.sendRedirect(req.getContextPath() + "/rooms?message=" + message);
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
