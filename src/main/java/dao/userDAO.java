package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.user;
import util.ConnectionPoolImpl;

public class userDAO implements daoInterface<user> {

	private Connection con;
	
	public userDAO() {
		try {
			this.con = ConnectionPoolImpl.getInstance().getConnection("user");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static userDAO getInstance() {
		return new userDAO();
	}

	@Override
	public int insert(user t) {
		int kq = 0;
		try {
			String sql = "INSERT INTO user (user_fullname, user_date_of_birth, user_address, user_gender, user_phone_number, user_email, account_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, t.getUser_fullname());
			ps.setDate(2, t.getUser_date_of_birth());
			ps.setString(3, t.getUser_address());
			ps.setInt(4, t.getUser_gender());
			ps.setString(5, t.getUser_phone_number());
			ps.setString(6, t.getUser_email());
			ps.setInt(7, t.getAccount_id());

			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("insert user " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "user");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	public int insertIgnore(ArrayList<user> list) {
		int kq = 0;
		int l = list.size();
		
		if(l == 0)
			return kq;

		StringBuilder bsql = new StringBuilder(
				"INSERT IGNORE INTO user (user_fullname, user_date_of_birth, user_address, user_gender, user_phone_number, user_email, account_id) VALUES ");
		for (int i = 0; i < l - 1; i++) {
			bsql.append("(?, ?, ?, ?, ?, ?, ?),");
		}
		bsql.append("(?, ?, ?, ?, ?, ?, ?);");
		String sql = bsql.toString();

		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			for (int i = 0; i < l; i++) {
				user t = list.get(i);
				
				ps.setString(7 * i + 1, t.getUser_fullname());
				ps.setDate(7 * i + 2, t.getUser_date_of_birth());
				ps.setString(7 * i + 3, t.getUser_address());
				ps.setInt(7 * i + 4, t.getUser_gender());
				ps.setString(7 * i + 5, t.getUser_phone_number());
				ps.setString(7 * i + 6, t.getUser_email());
				ps.setInt(7 * i + 7, t.getAccount_id());
			}

			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("insert ignore user " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "user");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public int update(user t) {
		int kq = 0;
		try {
			String sql = "UPDATE user SET user_fullname = ?, user_date_of_birth = ?, user_address = ?, user_gender = ?, user_phone_number = ?, user_email = ?, account_id = ? WHERE user_id = ?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, t.getUser_fullname());
			ps.setDate(2, t.getUser_date_of_birth());
			ps.setString(3, t.getUser_address());
			ps.setInt(4, t.getUser_gender());
			ps.setString(5, t.getUser_phone_number());
			ps.setString(6, t.getUser_email());
			ps.setInt(7, t.getAccount_id());
			ps.setInt(8, t.getUser_id());

			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("update user " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "user");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public int delete(user t) {
		int kq = 0;
		try {
			String sql = "DELETE FROM user WHERE user_id = ?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, t.getUser_id());

			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("delete user " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "user");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public ArrayList<user> selectAll() {
		ArrayList<user> list = new ArrayList<>();
		try {
			String sql = "SELECT * FROM user";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				user u = new user();
				u.setUser_id(rs.getInt("user_id"));
				u.setUser_fullname(rs.getString("user_fullname"));
				u.setUser_date_of_birth(rs.getDate("user_date_of_birth"));
				u.setUser_address(rs.getString("user_address"));
				u.setUser_gender(rs.getInt("user_gender"));
				u.setUser_phone_number(rs.getString("user_phone_number"));
				u.setUser_email(rs.getString("user_email"));
				u.setAccount_id(rs.getInt("account_id"));
				list.add(u);
			}

		} catch (Exception e) {
			System.out.println("selectAll user " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "user");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}

	@Override
	public user selectById(int id) {
		user u = null;
		try {
			String sql = "SELECT * FROM user WHERE user_id = ?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				u = new user();
				u.setUser_id(rs.getInt("user_id"));
				u.setUser_fullname(rs.getString("user_fullname"));
				u.setUser_date_of_birth(rs.getDate("user_date_of_birth"));
				u.setUser_address(rs.getString("user_address"));
				u.setUser_gender(rs.getInt("user_gender"));
				u.setUser_phone_number(rs.getString("user_phone_number"));
				u.setUser_email(rs.getString("user_email"));
				u.setAccount_id(rs.getInt("account_id"));
			}

		} catch (Exception e) {
			System.out.println("selectById user " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "user");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return u;
	}

	@Override
	public ArrayList<user> selectByCondition(String condition) {
		ArrayList<user> list = new ArrayList<>();
		try {
			String sql = "SELECT * FROM user WHERE " + condition;
			
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				user u = new user();
				u.setUser_id(rs.getInt("user_id"));
				u.setUser_fullname(rs.getString("user_fullname"));
				u.setUser_date_of_birth(rs.getDate("user_date_of_birth"));
				u.setUser_address(rs.getString("user_address"));
				u.setUser_gender(rs.getInt("user_gender"));
				u.setUser_phone_number(rs.getString("user_phone_number"));
				u.setUser_email(rs.getString("user_email"));
				u.setAccount_id(rs.getInt("account_id"));
				list.add(u);
			}

		} catch (Exception e) {
			System.out.println("selectByCondition user " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "user");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}

	public user getUserByAccountId(int accountId) {
		user u = null;
		try {
			String sql = "SELECT * FROM user WHERE account_id = ?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, accountId);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				u = new user();
				u.setUser_id(rs.getInt("user_id"));
				u.setUser_fullname(rs.getString("user_fullname"));
				u.setUser_date_of_birth(rs.getDate("user_date_of_birth"));
				u.setUser_address(rs.getString("user_address"));
				u.setUser_gender(rs.getInt("user_gender"));
				u.setUser_phone_number(rs.getString("user_phone_number"));
				u.setUser_email(rs.getString("user_email"));
				u.setAccount_id(rs.getInt("account_id"));
			}

		} catch (Exception e) {
			System.out.println("getUserByAccountId error: " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "user");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return u;
	}

}
