package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.*;
import model.*;

public class AccountController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ArrayList<account> list = accountDAO.getIns().selectAll();
		ArrayList<account> list_acc_admin = new ArrayList<>();
		ArrayList<account> list_acc_cus = new ArrayList<>();
		
		for(account a : list) {
			if(a.getRole_id() == 1) {
				list_acc_admin.add(a);
			}
			else {
				list_acc_cus.add(a);
			}
		}
		
		String action = req.getParameter("filter");
		
		if("cus".equals(action)) {
			list = list_acc_cus;
		}
		else if("admin".equals(action)) {
			list = list_acc_admin;
		}
		
		req.setAttribute("list_acc", list);
		
		req.getRequestDispatcher("/adjsp/accounts.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");

		if("add".equals(action)){
			addAcc(req, resp);
		}
		else if("delete".equals(action)){
			delAcc(req, resp);
		}
		else if("edit".equals(action)){
			editAcc(req, resp);
		}
	}
	
	private void addAcc(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		String account_username = req.getParameter("account_username");
		String account_password = req.getParameter("account_password");
		int role_id = Integer.parseInt(req.getParameter("role_id"));

		account acc = new account();
		acc.setAccount_username(account_username);
		acc.setAccount_password(account_password);
		acc.setRole_id(role_id);
		acc.setAccount_status(0);
		
		int kq = accountDAO.getIns().insert(acc);

		String message;
		if (kq > 0) {
		    message = "success";
		} else {
		    message = "fail";
		}
		resp.sendRedirect(req.getContextPath() + "/accounts?message=" + message);
		
	}
	
	private void delAcc(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		int account_id = Integer.parseInt(req.getParameter("account_id"));
		
		String message = "";
		int kq = 0;
		
		account acc = accountDAO.getIns().selectById(account_id);
		if(acc.getAccount_status() == 0) {
			kq = accountDAO.getIns().delete(acc);
		}

		if (kq > 0) {
		    message = "success";
		} else {
		    message = "fail";
		}
		resp.sendRedirect(req.getContextPath() + "/accounts?message=" + message);
	}
	
	private void editAcc(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		int account_id = Integer.parseInt(req.getParameter("account_id"));
		String account_password = req.getParameter("account_password");
		
		account acc = accountDAO.getIns().selectById(account_id);
		acc.setAccount_password(account_password);
		int kq = 0;
		kq = accountDAO.getIns().update(acc);
		
		String message;
		if (kq > 0) {
		    message = "success";
		} else {
		    message = "fail";
		}
		resp.sendRedirect(req.getContextPath() + "/accounts?message=" + message);
	}

}
