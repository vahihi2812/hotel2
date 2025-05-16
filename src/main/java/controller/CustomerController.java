package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.*;
import model.*;

public class CustomerController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		ArrayList<customer> list = customerDAO.getIns().selectAll();
			
		req.setAttribute("list_all", list);
		
		req.getRequestDispatcher("/adjsp/customers.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		String action = req.getParameter("action");

		if("add".equals(action)){
			addCus(req, resp);
		}
		else if("delete".equals(action)){
			delCus(req, resp);
		}
		else if("edit".equals(action)){
			editCus(req, resp);
		}
	}
	
	private void addCus(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException{
	    String customer_firstname = req.getParameter("customer_firstname");
	    String customer_lastname = req.getParameter("customer_lastname");
	    String customer_date_of_birth = req.getParameter("customer_date_of_birth");
	    int customer_gender = Integer.parseInt(req.getParameter("customer_gender"));
	    String customer_phone_number = req.getParameter("customer_phone_number");
	    String customer_email = req.getParameter("customer_email");
	    String customer_address = req.getParameter("customer_address");
	    String customer_cccd = req.getParameter("customer_cccd");
	    int account_id = Integer.parseInt(req.getParameter("account_id"));

	    // Tạo đối tượng Customer
	    customer customer = new customer();
	    customer.setCustomer_firstname(customer_firstname);
	    customer.setCustomer_lastname(customer_lastname);
	    	    
	    try {
            // Chuyển đổi ngày sinh từ String về java.sql.Date
            if (customer_date_of_birth != null && !customer_date_of_birth.isEmpty()) {
                java.sql.Date dateOfBirth = java.sql.Date.valueOf(customer_date_of_birth);
                customer.setCustomer_date_of_birth(dateOfBirth);
            }
        } catch (IllegalArgumentException e) {
            // Handle invalid date
            e.printStackTrace();
        }
	    
	    customer.setCustomer_gender(customer_gender);
	    customer.setCustomer_phone_number(customer_phone_number);
	    customer.setCustomer_email(customer_email);
	    customer.setCustomer_address(customer_address);
	    customer.setCustomer_cccd(customer_cccd);
	    customer.setAccount_id(account_id);

	    int kq = customerDAO.getIns().insert(customer);

	    String message = (kq > 0) ? "success" : "fail";
	    resp.sendRedirect(req.getContextPath() + "/customers?message=" + message);
	}

	
	private void delCus(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		int customer_id = Integer.parseInt(req.getParameter("customer_id"));
		
		String message = "";
		int kq = 0;
		
		customer cus = customerDAO.getIns().selectById(customer_id);
		if(cus != null)
			kq = customerDAO.getIns().delete(cus);

		if (kq > 0) {
		    message = "success";
		} else {
		    message = "fail";
		}
		resp.sendRedirect(req.getContextPath() + "/customers?message=" + message);
	}
	
	private void editCus(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		int customer_id = Integer.parseInt(req.getParameter("customer_id"));
		
		String customer_firstname = req.getParameter("customer_firstname");
	    String customer_lastname = req.getParameter("customer_lastname");
	    String customer_date_of_birth = req.getParameter("customer_date_of_birth");
	    int customer_gender = Integer.parseInt(req.getParameter("customer_gender"));
	    String customer_phone_number = req.getParameter("customer_phone_number");
	    String customer_email = req.getParameter("customer_email");
	    String customer_address = req.getParameter("customer_address");
	    String customer_cccd = req.getParameter("customer_cccd");
	    String str_acc_id = req.getParameter("customer_account_id");
	    int account_id = 0;
	    if(!str_acc_id.equals(""))
	    	account_id = Integer.parseInt(str_acc_id);
		
		customer cus = customerDAO.getIns().selectById(customer_id);
		
	    cus.setCustomer_firstname(customer_firstname);
	    cus.setCustomer_lastname(customer_lastname);
	    try {
            // Chuyển đổi ngày sinh từ String về java.sql.Date
            if (customer_date_of_birth != null && !customer_date_of_birth.isEmpty()) {
                java.sql.Date dateOfBirth = java.sql.Date.valueOf(customer_date_of_birth);
                cus.setCustomer_date_of_birth(dateOfBirth);
            }
        } catch (IllegalArgumentException e) {
            // Handle invalid date
            e.printStackTrace();
        }
	    cus.setCustomer_gender(customer_gender);
	    cus.setCustomer_phone_number(customer_phone_number);
	    cus.setCustomer_email(customer_email);
	    cus.setCustomer_address(customer_address);
	    cus.setCustomer_cccd(customer_cccd);
	    cus.setAccount_id(account_id);
		
		int kq = 0;
		kq = customerDAO.getIns().update(cus);
		
		String message = "";
		if (kq > 0) {
		    message = "success";
		} else {
		    message = "fail";
		}
		resp.sendRedirect(req.getContextPath() + "/customers?message=" + message);
	}

}

