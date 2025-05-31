package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.payment;
import util.ConnectionPoolImpl;

public class paymentDAO implements daoInterface<payment> {

	private Connection con;

	public paymentDAO() {
		try {
			this.con = ConnectionPoolImpl.getInstance().getConnection("payment");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static paymentDAO getIns() {
		return new paymentDAO();
	}

	@Override
	public int insert(payment t) {
		int kq = 0;
		String sql = "INSERT INTO payment(payment_name) VALUES (?)";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, t.getPayment_name());
			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("insert " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "payment");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public int update(payment t) {
		int kq = 0;
		String sql = "UPDATE payment SET payment_name = ? WHERE payment_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, t.getPayment_name());
			ps.setInt(2, t.getPayment_id());
			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("update " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "payment");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public int delete(payment t) {
		int kq = 0;
		String sql = "DELETE FROM payment WHERE payment_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, t.getPayment_id());
			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("delete " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "payment");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public ArrayList<payment> selectAll() {
		ArrayList<payment> list = new ArrayList<>();
		String sql = "SELECT * FROM payment";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				payment p = new payment();
				p.setPayment_id(rs.getInt("payment_id"));
				p.setPayment_name(rs.getString("payment_name"));
				list.add(p);
			}
		} catch (Exception e) {
			System.out.println("selectAll " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "payment");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}

	@Override
	public payment selectById(int id) {
		payment p = null;
		String sql = "SELECT * FROM payment WHERE payment_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				p = new payment();
				p.setPayment_id(rs.getInt("payment_id"));
				p.setPayment_name(rs.getString("payment_name"));
			}
		} catch (Exception e) {
			System.out.println("selectById " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "payment");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return p;
	}

	@Override
	public ArrayList<payment> selectByCondition(String condition) {
		ArrayList<payment> list = new ArrayList<>();
		String sql = "SELECT * FROM payment WHERE " + condition;
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				payment p = new payment();
				p.setPayment_id(rs.getInt("payment_id"));
				p.setPayment_name(rs.getString("payment_name"));
				list.add(p);
			}
		} catch (Exception e) {
			System.out.println("selectByCondition " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "payment");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}
}
