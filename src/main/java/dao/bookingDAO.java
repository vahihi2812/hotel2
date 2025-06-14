package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.booking;
import util.ConnectionPoolImpl;

public class bookingDAO implements daoInterface<booking> {

	private Connection con;

	public bookingDAO() {
		try {
			this.con = ConnectionPoolImpl.getInstance().getConnection("booking");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static bookingDAO getIns() {
		return new bookingDAO();
	}

	@Override
	public int insert(booking t) {
		int kq = 0;
		try {
			String sql = "INSERT INTO booking(booking_start_date, booking_end_date, booking_room_cost, booking_total_cost, customer_id, room_id) " 
					+ "VALUES (?, ?, ?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setDate(1, t.getBooking_start_date());
			ps.setDate(2, t.getBooking_end_date());
			ps.setDouble(3, t.getBooking_room_cost());
			ps.setDouble(4, t.getBooking_total_cost());
			ps.setInt(5, t.getCustomer_id());
			ps.setInt(6, t.getRoom_id());

			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("insert: " + e);
		}
//		finally {
//        	try {
//				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "booking");
//			} catch (SQLException e) {
//				System.out.println("insert booking " + e);
//			}
//		}
		return kq;
	}

	@Override
	public int update(booking t) {
		int kq = 0;
		String sql = "UPDATE booking SET booking_time=?, booking_start_date=?, booking_end_date=?, "
				+ "booking_service_cost=?, booking_room_cost=?, booking_total_cost=?, "
				+ "customer_id=?, room_id=?, payment_id=?, bs_id=? " + "WHERE booking_id=?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setTimestamp(1, t.getBooking_time());
			ps.setDate(2, t.getBooking_start_date());
			ps.setDate(3, t.getBooking_end_date());
			ps.setDouble(4, t.getBooking_service_cost());
			ps.setDouble(5, t.getBooking_room_cost());
			ps.setDouble(6, t.getBooking_total_cost());
			ps.setInt(7, t.getCustomer_id());
			ps.setInt(8, t.getRoom_id());
			ps.setInt(9, t.getPayment_id());
			ps.setInt(10, t.getBs_id());
			ps.setInt(11, t.getBooking_id());

			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("update: " + e.getMessage());
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "booking");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public int delete(booking t) {
		int kq = 0;
		String sql = "DELETE FROM booking WHERE booking_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, t.getBooking_id());
			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("delete: " + e.getMessage());
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "booking");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public ArrayList<booking> selectAll() {
		ArrayList<booking> list = new ArrayList<>();
		String sql = "SELECT * FROM booking order by booking_time desc";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				booking b = new booking(rs.getInt("booking_id"), rs.getTimestamp("booking_time"),
						rs.getDate("booking_start_date"), rs.getDate("booking_end_date"),
						rs.getDouble("booking_service_cost"), rs.getDouble("booking_room_cost"),
						rs.getDouble("booking_total_cost"), rs.getInt("customer_id"), rs.getInt("room_id"),
						rs.getInt("payment_id"), rs.getInt("bs_id"));
				list.add(b);
			}
		} catch (Exception e) {
			System.out.println("selectAll: " + e.getMessage());
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "booking");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}

	@Override
	public booking selectById(int id) {
		booking b = null;
		String sql = "SELECT * FROM booking WHERE booking_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				b = new booking(rs.getInt("booking_id"), rs.getTimestamp("booking_time"),
						rs.getDate("booking_start_date"), rs.getDate("booking_end_date"),
						rs.getDouble("booking_service_cost"), rs.getDouble("booking_room_cost"),
						rs.getDouble("booking_total_cost"), rs.getInt("customer_id"), rs.getInt("room_id"),
						rs.getInt("payment_id"), rs.getInt("bs_id"));
			}
		} catch (Exception e) {
			System.out.println("selectById: " + e.getMessage());
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "booking");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return b;
	}

	@Override
	public ArrayList<booking> selectByCondition(String condition) {
		ArrayList<booking> list = new ArrayList<>();
		String sql = "SELECT * FROM booking WHERE " + condition;
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				booking b = new booking(rs.getInt("booking_id"), rs.getTimestamp("booking_time"),
						rs.getDate("booking_start_date"), rs.getDate("booking_end_date"),
						rs.getDouble("booking_service_cost"), rs.getDouble("booking_room_cost"),
						rs.getDouble("booking_total_cost"), rs.getInt("customer_id"), rs.getInt("room_id"),
						rs.getInt("payment_id"), rs.getInt("bs_id"));
				list.add(b);
			}
		} catch (Exception e) {
			System.out.println("selectByCondition: " + e.getMessage());
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "booking");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}
}
