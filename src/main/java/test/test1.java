package test;

import java.time.LocalDate;
import java.util.ArrayList;

import dao.booking_reportDAO;
import model.booking_report;

public class test1 {
	public static void main(String[] args) {
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
//        list.add(booking_reportDAO.getInstance().selectById(year).getBr_amount());
//        list.add(booking_reportDAO.getInstance().selectById(br_id_1).getBr_amount());
//        list.add(booking_reportDAO.getInstance().selectById(br_id_2).getBr_amount());
        
        System.out.println(br_id_1);
        booking_report br = booking_reportDAO.getInstance().selectById(20255);
        System.out.println(br.getBr_amount());
	}
}
