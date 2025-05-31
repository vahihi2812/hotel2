package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.room_status;
import util.ConnectionPoolImpl;

public class room_statusDAO implements daoInterface<room_status> {

	private Connection con;

	public room_statusDAO() {
		try {
			this.con = ConnectionPoolImpl.getInstance().getConnection("room_status");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static room_statusDAO getIns() {
		return new room_statusDAO();
	}

	@Override
	public int insert(room_status t) {
		int kq = 0;
		String sql = "INSERT INTO room_status(rs_name, rs_description) VALUES (?, ?)";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, t.getRs_name());
			ps.setString(2, t.getRs_description());
			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("insert " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "room_status");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public int update(room_status t) {
		int kq = 0;
		String sql = "UPDATE room_status SET rs_name = ?, rs_description = ? WHERE rs_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, t.getRs_name());
			ps.setString(2, t.getRs_description());
			ps.setInt(3, t.getRs_id());
			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("update " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "room_status");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public int delete(room_status t) {
		int kq = 0;
		String sql = "DELETE FROM room_status WHERE rs_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, t.getRs_id());
			kq = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("delete " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "room_status");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return kq;
	}

	@Override
	public ArrayList<room_status> selectAll() {
		ArrayList<room_status> list = new ArrayList<>();
		String sql = "SELECT * FROM room_status";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				room_status r = new room_status();
				r.setRs_id(rs.getInt("rs_id"));
				r.setRs_name(rs.getString("rs_name"));
				r.setRs_description(rs.getString("rs_description"));
				list.add(r);
			}
		} catch (Exception e) {
			System.out.println("selectAll " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "room_status");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}

	@Override
	public room_status selectById(int id) {
		room_status rs = null;
		String sql = "SELECT * FROM room_status WHERE rs_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet resultSet = ps.executeQuery();
			if (resultSet.next()) {
				rs = new room_status();
				rs.setRs_id(resultSet.getInt("rs_id"));
				rs.setRs_name(resultSet.getString("rs_name"));
				rs.setRs_description(resultSet.getString("rs_description"));
			}
		} catch (Exception e) {
			System.out.println("selectById " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "room_status");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return rs;
	}

	@Override
	public ArrayList<room_status> selectByCondition(String condition) {
		ArrayList<room_status> list = new ArrayList<>();
		String sql = "SELECT * FROM room_status WHERE " + condition;
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				room_status rsObj = new room_status();
				rsObj.setRs_id(rs.getInt("rs_id"));
				rsObj.setRs_name(rs.getString("rs_name"));
				rsObj.setRs_description(rs.getString("rs_description"));
				list.add(rsObj);
			}
		} catch (Exception e) {
			System.out.println("selectByCondition " + e);
		}finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "room_status");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}
}
