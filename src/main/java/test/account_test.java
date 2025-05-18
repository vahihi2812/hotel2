package test;

import java.sql.Connection;
import java.sql.PreparedStatement;

import util.ConnectionPoolImpl;

public class account_test {
	// ket noi lam viec
	private Connection con;
	
	public account_test() {
		try {
			this.con = ConnectionPoolImpl.getInstance().getConnection("account");
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}
	
	private boolean exe(PreparedStatement pre) {
		if(pre != null) {
			try {
				int result = pre.executeUpdate();
				
				if(result == 0) {
					this.con.rollback();
				}
			} catch (Exception e) {
				// TODO: handle exception
			}
		}
		return true;
	}
}
