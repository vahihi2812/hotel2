package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class JDBCUtil {
	public static Connection getConn() {
		Connection c = null;
		try {
			DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
			
			String url = "jdbc:mysql://localhost:3306/hotel01";
			String u = "root";
			String p = "root";
			
			c = DriverManager.getConnection(url, u, p);
		} catch (Exception e) {
			System.out.println("loi sql");
		}
		return c;
	}
	
	public static void closeConn(Connection c) {
		try {
			if(c != null)
				c.close();
		} catch (Exception e) {
			System.out.println("Khong the dong ket noi");
		}
	}
}
