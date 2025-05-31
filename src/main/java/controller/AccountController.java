package controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import dao.*;
import model.*;

public class AccountController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private ArrayList<account> list, list_acc_admin, list_acc_cus;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		list = accountDAO.getIns().selectAll();
		list_acc_admin = new ArrayList<>();
		list_acc_cus = new ArrayList<>();

		for (account a : list) {
			if (a.getRole_id() == 1) {
				list_acc_admin.add(a);
			} else {
				list_acc_cus.add(a);
			}
		}

		String action = req.getParameter("filter");

		if ("cus".equals(action)) {
			list = list_acc_cus;
		} else if ("admin".equals(action)) {
			list = list_acc_admin;
		}

		req.setAttribute("filter", action == null ? "all" : action);
		req.setAttribute("list_acc", list);

		req.getRequestDispatcher("/adjsp/accounts.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");

		if ("add".equals(action)) {
			addAcc(req, resp);
		} else if ("delete".equals(action)) {
			delAcc(req, resp);
		} else if ("edit".equals(action)) {
			editAcc(req, resp);
		} else if ("addbyexcel".equals(action)) {
			addAccByExcel(req, resp);
		} else if ("addbyexcel".equals(action)) {
			req.setAttribute("list_acc", list);
			req.getRequestDispatcher("/adjsp/accounts.jsp").forward(req, resp);
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
		if (acc.getAccount_status() == 0) {
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

	private void addAccByExcel(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
	    int kq = 1;
	    
	    ArrayList<account> list = new ArrayList<>();

	    Part filePart = req.getPart("file");
	    InputStream inputStream = filePart.getInputStream();

	    try (Workbook workbook = new XSSFWorkbook(inputStream)) {
	        Sheet sheet = workbook.getSheetAt(0);
	        for (Row row : sheet) {
	            if (row.getRowNum() == 0) continue; // Bỏ qua dòng tiêu đề

	            String account_username = getCellValueAsString(row.getCell(0));
	            String account_password = getCellValueAsString(row.getCell(1));
	            String roleStr = getCellValueAsString(row.getCell(2));

	            // Bỏ qua dòng nếu thiếu dữ liệu
	            if (account_username.isEmpty() || account_password.isEmpty() || roleStr.isEmpty()) {
	                System.out.println("Dòng thiếu dữ liệu, bỏ qua.");
	                continue;
	            }

	            int role_id;
	            try {
	                role_id = Integer.parseInt(roleStr);
	            } catch (NumberFormatException e) {
	                System.out.println("Role ID không hợp lệ: " + roleStr);
	                continue;
	            }

	            account acc = new account();
	            acc.setAccount_username(account_username);
	            acc.setAccount_password(account_password);
	            acc.setRole_id(role_id);
	            list.add(acc);	            
	        }
	        
	        kq = accountDAO.getIns().insertIgnore(list);
	        System.out.println("Inserted " + kq + " account(s)");
	        
	    } catch (Exception e) {
	        kq = 0;
	        e.printStackTrace();
	    }

	    String message = (kq > 0) ? "success" : "fail";
	    resp.sendRedirect(req.getContextPath() + "/accounts?message=" + message);
	}
	
	// Hàm chuyển Cell về chuỗi an toàn
	private String getCellValueAsString(Cell cell) {
	    if (cell == null) return "";
	    switch (cell.getCellType()) {
	        case STRING:
	            return cell.getStringCellValue().trim();
	        case NUMERIC:
	            // Nếu là số nguyên, không cần hiển thị phần thập phân
	            return String.valueOf((int) cell.getNumericCellValue());
	        case BOOLEAN:
	            return String.valueOf(cell.getBooleanCellValue());
	        case FORMULA:
	            try {
	                return cell.getStringCellValue().trim(); // hoặc xử lý thêm nếu cần
	            } catch (IllegalStateException e) {
	                return String.valueOf(cell.getNumericCellValue());
	            }
	        default:
	            return "";
	    }
	}
}
