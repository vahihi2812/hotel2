package test;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;

import dao.booking_reportDAO;
import model.booking_report;

public class test2 {
	public static void main(String[] args) {
		LocalDate localDate = LocalDate.now();

		int day = localDate.getDayOfMonth();
		int month = localDate.getMonthValue();
		int year = localDate.getYear();
		
		int id_1 = year * 10000 + month * 100 + day;
		ArrayList<booking_report> list_tuan = new ArrayList<>();
		
		list_tuan = booking_reportDAO.getInstance().selectBetweenDescLIMIT(id_1 - 100, id_1, 7);
		Collections.reverse(list_tuan);
		
		for(int i = 0; i < list_tuan.size(); i++)
			System.out.println(list_tuan.get(i).getBr_id());
	}
}
