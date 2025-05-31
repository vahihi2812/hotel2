package test;

import java.util.ArrayList;

import dao.accountDAO;
import model.account;

public class test1 {
	public static void main(String[] args) {
		account acc1 = new account();
		acc1.setAccount_username("toitest1");
		acc1.setAccount_password("toitest1");
		acc1.setRole_id(2);
		
		account acc2 = new account();
		acc2.setAccount_username("toitest2");
		acc2.setAccount_password("toitest2");
		acc2.setRole_id(2);
	
		ArrayList<account> list = new ArrayList<>();
		list.add(acc1);
		list.add(acc2);
		
		//System.out.println(list.get(0).getAccount_username());
		
		System.out.println(accountDAO.getIns().insertIgnore(list));
	}
}
