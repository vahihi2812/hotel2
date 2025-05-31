package controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.booking_reportDAO;
import dao.customer_reportDAO;
import dao.revenue_reportDAO;
import model.booking_report;
import model.customer_report;
import model.revenue_report;

public class HomeController extends HttpServlet {
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

		int id_1 = year * 100 + month;
		int id_2 = year * 10000 + month * 100 + day;

		req.setAttribute("total_list", getTotalList(year, id_1, id_2));
		req.setAttribute("list1", getRevList(year, id_1, id_2));

		ArrayList<booking_report> list_tuan = getListBookingTuan(id_2);
		req.setAttribute("list_tuan", list_tuan);

		req.setAttribute("list_ty_le", getListTyLe(list_tuan));
		
		req.setAttribute("list_ss", getListSoSanh(year, month, day));

		req.getRequestDispatcher("/adjsp/index.jsp").forward(req, resp);
	}
	
	private ArrayList<Double> getListSoSanh(int year, int month, int day){
		ArrayList<Double> list = new ArrayList<>();
		ArrayList<revenue_report> list_1 = null;
		int id_1 = year * 10000 + month * 100 + day;
		
		revenue_report rr_hom_qua = null;
		revenue_report rr_hom_nay = revenue_reportDAO.getInstance().selectById(id_1);
		
		if(day == 1) {
			if(month == 1) {
				year -= 1;
				month = 12;
			}
			else{
				month -= 1;
			}
			list_1 = revenue_reportDAO.getInstance().selectBetween(year * 10000 + month * 100 + 28, year * 10000 + month * 100 + 31);
			rr_hom_qua = list_1.get(list_1.size() - 1);
		}else {
			rr_hom_qua = revenue_reportDAO.getInstance().selectById(id_1 - 1);
		}		
		
		list.add(rr_hom_qua.getRr_room());
		list.add(rr_hom_qua.getRr_food());
		list.add(rr_hom_qua.getRr_service());
		list.add(rr_hom_qua.getRr_spa());
		list.add(rr_hom_qua.getRr_sport());
		
		list.add(rr_hom_nay.getRr_room());
		list.add(rr_hom_nay.getRr_food());
		list.add(rr_hom_nay.getRr_service());
		list.add(rr_hom_nay.getRr_spa());
		list.add(rr_hom_nay.getRr_sport());
		
		return list;
	}

	private ArrayList<Integer> getListTyLe(ArrayList<booking_report> tmp) {
		ArrayList<Integer> list = new ArrayList<>();

		int[] a = { 0, 0, 0, 0, 0 };

		for (booking_report br : tmp) {
			a[0] += br.getBr_floor_1();
			a[1] += br.getBr_floor_2();
			a[2] += br.getBr_floor_3();
			a[3] += br.getBr_floor_4();
			a[4] += br.getBr_floor_5();
		}

		for (int i = 0; i < 5; i++) {
			list.add(a[i]);
		}

		return list;
	}

	private ArrayList<booking_report> getListBookingTuan(int id_2) {
		// bieu do theo tuan
		ArrayList<booking_report> list_tuan = new ArrayList<>();
		list_tuan = booking_reportDAO.getInstance().selectBetween(id_2 - 6, id_2);
		return list_tuan;
	}

	private ArrayList<Integer> getTotalList(int year, int id_1, int id_2) {
		ArrayList<Integer> list = new ArrayList<>();

		// booking
		booking_report br1 = booking_reportDAO.getInstance().selectById(year);
		if (br1 == null) {
			booking_reportDAO.getInstance().insert(new booking_report(year, 0, 0, 0, 0, 0, 0));
			list.add(0);
		} else {
			list.add(br1.getBr_amount());
		}

		booking_report br2 = booking_reportDAO.getInstance().selectById(id_1);
		if (br2 == null) {
			booking_reportDAO.getInstance().insert(new booking_report(id_1, 0, 0, 0, 0, 0, 0));
			list.add(0);
		} else {
			list.add(br2.getBr_amount());
		}

		booking_report br3 = booking_reportDAO.getInstance().selectById(id_2);
		if (br3 == null) {
			booking_reportDAO.getInstance().insert(new booking_report(id_2, 0, 0, 0, 0, 0, 0));
			list.add(0);
		} else {
			list.add(br3.getBr_amount());
		}

		// customer
		customer_report cr1 = customer_reportDAO.getInstance().selectById(year);
		if (cr1 == null) {
			customer_reportDAO.getInstance().insert1(new customer_report(year, 0));
			list.add(0);
		} else {
			list.add(cr1.getCr_amount());
		}

		customer_report cr2 = customer_reportDAO.getInstance().selectById(id_1);
		if (cr2 == null) {
			customer_reportDAO.getInstance().insert1(new customer_report(id_1, 0));
			list.add(0);
		} else {
			list.add(cr2.getCr_amount());
		}

		customer_report cr3 = customer_reportDAO.getInstance().selectById(id_2);
		if (cr3 == null) {
			customer_reportDAO.getInstance().insert1(new customer_report(id_2, 0));
			list.add(0);
		} else {
			list.add(cr3.getCr_amount());
		}

		return list;
	}

	private ArrayList<Double> getRevList(int year, int id_1, int id_2) {
		// revenue
		ArrayList<Double> list1 = new ArrayList<>();

		revenue_report rr1 = revenue_reportDAO.getInstance().selectById(year);
		if (rr1 == null) {
			revenue_report rr_tmp_1 = new revenue_report();
			rr_tmp_1.setRr_id(year);
			revenue_reportDAO.getInstance().insert(rr_tmp_1);
			list1.add(0.0);
		} else {
			list1.add(rr1.getRr_amount());
		}

		revenue_report rr2 = revenue_reportDAO.getInstance().selectById(id_1);
		if (rr2 == null) {
			revenue_report rr_tmp_2 = new revenue_report();
			rr_tmp_2.setRr_id(id_1);
			revenue_reportDAO.getInstance().insert(rr_tmp_2);
			list1.add(0.0);
		} else {
			list1.add(rr2.getRr_amount());
		}

		revenue_report rr3 = revenue_reportDAO.getInstance().selectById(id_2);
		if (rr3 == null) {
			revenue_report rr_tmp_3 = new revenue_report();
			rr_tmp_3.setRr_id(id_2);
			revenue_reportDAO.getInstance().insert(rr_tmp_3);
			list1.add(0.0);
		} else {
			list1.add(rr3.getRr_amount());
		}

		return list1;
	}

}
