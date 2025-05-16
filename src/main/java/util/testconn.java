package util;

import java.sql.Connection;

public class testconn {
	public static void main(String[] args) {
		Connection c = JDBCUtil.getConn();
		System.out.println(c);
		JDBCUtil.closeConn(c);
	}
}
