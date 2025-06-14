package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.customer;
import util.ConnectionPoolImpl;

public class customerDAO implements daoInterface<customer> {

	private Connection con;

	public customerDAO() {
		try {
			this.con = ConnectionPoolImpl.getInstance().getConnection("customer");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static customerDAO getIns() {
		return new customerDAO();
	}

	@Override
	public int insert(customer t) {
		int kq = 0;
		String sql = "INSERT INTO customer(customer_firstname, customer_lastname, customer_date_of_birth, customer_gender, customer_phone_number, customer_email, customer_address, customer_cccd, account_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, t.getCustomer_firstname());
			ps.setString(2, t.getCustomer_lastname());
			ps.setDate(3, t.getCustomer_date_of_birth());
			ps.setInt(4, t.getCustomer_gender());
			ps.setString(5, t.getCustomer_phone_number());
			ps.setString(6, t.getCustomer_email());
			ps.setString(7, t.getCustomer_address());
			ps.setString(8, t.getCustomer_cccd());
			ps.setInt(9, t.getAccount_id());

			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("insert " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "customer");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	public int insertIgnore(ArrayList<customer> list) {
		int kq = 0;
		int l = list.size();

		if (l == 0)
			return kq;

		StringBuilder bsql = new StringBuilder("INSERT IGNORE INTO customer(customer_firstname, "
				+ "customer_lastname, customer_date_of_birth, customer_gender, customer_phone_number, "
				+ "customer_email, customer_address, customer_cccd, account_id) VALUES ");

		for (int i = 0; i < l - 1; i++) {
			bsql.append("(?, ?, ?, ?, ?, ?, ?, ?, ?),");
		}
		bsql.append("(?, ?, ?, ?, ?, ?, ?, ?, ?);");

		String sql = bsql.toString();

		try {
			PreparedStatement ps = con.prepareStatement(sql);

			for (int i = 0; i < l; i++) {
				customer t = list.get(i);

				ps.setString(9 * i + 1, t.getCustomer_firstname());
				ps.setString(9 * i + 2, t.getCustomer_lastname());
				ps.setDate(9 * i + 3, t.getCustomer_date_of_birth());
				ps.setInt(9 * i + 4, t.getCustomer_gender());
				ps.setString(9 * i + 5, t.getCustomer_phone_number());
				ps.setString(9 * i + 6, t.getCustomer_email());
				ps.setString(9 * i + 7, t.getCustomer_address());
				ps.setString(9 * i + 8, t.getCustomer_cccd());
				ps.setInt(9 * i + 9, t.getAccount_id());

			}
			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("Insert customer ignore " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "customer");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return kq;
	}

	@Override
	public int update(customer t) {
		int kq = 0;
		String sql = "UPDATE customer SET customer_firstname = ?, customer_lastname = ?, customer_date_of_birth = ?, customer_gender = ?, customer_phone_number = ?, customer_email = ?, customer_address = ?, customer_cccd = ?, customer_booking_time = ?, account_id = ? WHERE customer_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, t.getCustomer_firstname());
			ps.setString(2, t.getCustomer_lastname());
			ps.setDate(3, t.getCustomer_date_of_birth());
			ps.setInt(4, t.getCustomer_gender());
			ps.setString(5, t.getCustomer_phone_number());
			ps.setString(6, t.getCustomer_email());
			ps.setString(7, t.getCustomer_address());
			ps.setString(8, t.getCustomer_cccd());
			ps.setInt(9, t.getCustomer_booking_time());
			ps.setInt(10, t.getAccount_id());
			ps.setInt(11, t.getCustomer_id());

			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("update " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "customer");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public int delete(customer t) {
		int kq = 0;
		String sql = "DELETE FROM customer WHERE customer_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, t.getCustomer_id());
			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("delete " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "customer");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public ArrayList<customer> selectAll() {
		ArrayList<customer> list = new ArrayList<>();
		String sql = "SELECT * FROM customer";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				customer c = new customer();
				c.setCustomer_id(rs.getInt("customer_id"));
				c.setCustomer_firstname(rs.getString("customer_firstname"));
				c.setCustomer_lastname(rs.getString("customer_lastname"));
				c.setCustomer_date_of_birth(rs.getDate("customer_date_of_birth"));
				c.setCustomer_gender(rs.getInt("customer_gender"));
				c.setCustomer_phone_number(rs.getString("customer_phone_number"));
				c.setCustomer_email(rs.getString("customer_email"));
				c.setCustomer_address(rs.getString("customer_address"));
				c.setCustomer_cccd(rs.getString("customer_cccd"));
				c.setCustomer_booking_time(rs.getInt("customer_booking_time"));
				c.setAccount_id(rs.getInt("account_id"));
				list.add(c);
			}
		} catch (Exception e) {
			System.out.println("selectAll " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "customer");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}

	@Override
	public customer selectById(int id) {
		customer c = null;
		String sql = "SELECT * FROM customer WHERE customer_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				c = new customer();
				c.setCustomer_id(rs.getInt("customer_id"));
				c.setCustomer_firstname(rs.getString("customer_firstname"));
				c.setCustomer_lastname(rs.getString("customer_lastname"));
				c.setCustomer_date_of_birth(rs.getDate("customer_date_of_birth"));
				c.setCustomer_gender(rs.getInt("customer_gender"));
				c.setCustomer_phone_number(rs.getString("customer_phone_number"));
				c.setCustomer_email(rs.getString("customer_email"));
				c.setCustomer_address(rs.getString("customer_address"));
				c.setCustomer_cccd(rs.getString("customer_cccd"));
				c.setCustomer_booking_time(rs.getInt("customer_booking_time"));
				c.setAccount_id(rs.getInt("account_id"));
			}
		} catch (Exception e) {
			System.out.println("selectById " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "customer");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return c;
	}

	@Override
	public ArrayList<customer> selectByCondition(String condition) {
		ArrayList<customer> list = new ArrayList<>();
		String sql = "SELECT * FROM customer WHERE " + condition;
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				customer c = new customer();
				c.setCustomer_id(rs.getInt("customer_id"));
				c.setCustomer_firstname(rs.getString("customer_firstname"));
				c.setCustomer_lastname(rs.getString("customer_lastname"));
				c.setCustomer_date_of_birth(rs.getDate("customer_date_of_birth"));
				c.setCustomer_gender(rs.getInt("customer_gender"));
				c.setCustomer_phone_number(rs.getString("customer_phone_number"));
				c.setCustomer_email(rs.getString("customer_email"));
				c.setCustomer_address(rs.getString("customer_address"));
				c.setCustomer_cccd(rs.getString("customer_cccd"));
				c.setCustomer_booking_time(rs.getInt("customer_booking_time"));
				c.setAccount_id(rs.getInt("account_id"));
				list.add(c);
			}
		} catch (Exception e) {
			System.out.println("selectByCondition " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "customer");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}
	
	public customer getCustomerByAccountId(int id) {
		customer c = null;
		String sql = "SELECT * FROM customer WHERE account_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				c = new customer();
				c.setCustomer_id(rs.getInt("customer_id"));
				c.setCustomer_firstname(rs.getString("customer_firstname"));
				c.setCustomer_lastname(rs.getString("customer_lastname"));
				c.setCustomer_date_of_birth(rs.getDate("customer_date_of_birth"));
				c.setCustomer_gender(rs.getInt("customer_gender"));
				c.setCustomer_phone_number(rs.getString("customer_phone_number"));
				c.setCustomer_email(rs.getString("customer_email"));
				c.setCustomer_address(rs.getString("customer_address"));
				c.setCustomer_cccd(rs.getString("customer_cccd"));
				c.setCustomer_booking_time(rs.getInt("customer_booking_time"));
				c.setAccount_id(rs.getInt("account_id"));
			}
		} catch (Exception e) {
			System.out.println("get Customer By Account ID " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "customer");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return c;
	}
}
