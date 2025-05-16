package dao;

import java.util.ArrayList;

import model.*;

public class testdao {
	public static void main(String[] args) {
		ArrayList<account> list = accountDAO.getIns().selectAll();
		account a1 = list.get(0);
		int kq = accountDAO.getIns().updateLastLogin(a1);
		System.out.println(kq);
	}
}
