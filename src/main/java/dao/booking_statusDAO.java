package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.booking_status;
import util.ConnectionPoolImpl;

public class booking_statusDAO implements daoInterface<booking_status> {

	private Connection con;
	
	public booking_statusDAO(){
		try {
			this.con = ConnectionPoolImpl.getInstance().getConnection("booking_status");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
    public static booking_statusDAO getIns() {
        return new booking_statusDAO();
    }

    @Override
    public int insert(booking_status t) {
        int kq = 0;
        String sql = "INSERT INTO booking_status(bs_name) VALUES (?)";
        try (//Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, t.getBs_name());
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("insert " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "booking_status");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return kq;
    }

    @Override
    public int update(booking_status t) {
        int kq = 0;
        String sql = "UPDATE booking_status SET bs_name = ? WHERE bs_id = ?";
        try (//Connection con = JDBCUtil.getConn();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, t.getBs_name());
            ps.setInt(2, t.getBs_id());
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("update " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "booking_status");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return kq;
    }

    @Override
    public int delete(booking_status t) {
        int kq = 0;
        String sql = "DELETE FROM booking_status WHERE bs_id = ?";
        try (//Connection con = JDBCUtil.getConn();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, t.getBs_id());
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("delete " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "booking_status");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return kq;
    }

    @Override
    public ArrayList<booking_status> selectAll() {
        ArrayList<booking_status> list = new ArrayList<>();
        String sql = "SELECT * FROM booking_status";
        try (//Connection con = JDBCUtil.getConn();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                booking_status bs = new booking_status();
                bs.setBs_id(rs.getInt("bs_id"));
                bs.setBs_name(rs.getString("bs_name"));
                list.add(bs);
            }
        } catch (Exception e) {
            System.out.println("selectAll " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "booking_status");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return list;
    }

    @Override
    public booking_status selectById(int id) {
        booking_status bs = null;
        String sql = "SELECT * FROM booking_status WHERE bs_id = ?";
        try (//Connection con = JDBCUtil.getConn();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                bs = new booking_status();
                bs.setBs_id(rs.getInt("bs_id"));
                bs.setBs_name(rs.getString("bs_name"));
            }
        } catch (Exception e) {
            System.out.println("selectById " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "booking_status");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return bs;
    }

    @Override
    public ArrayList<booking_status> selectByCondition(String condition) {
        ArrayList<booking_status> list = new ArrayList<>();
        String sql = "SELECT * FROM booking_status WHERE " + condition;
        try (//Connection con = JDBCUtil.getConn();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                booking_status bs = new booking_status();
                bs.setBs_id(rs.getInt("bs_id"));
                bs.setBs_name(rs.getString("bs_name"));
                list.add(bs);
            }
        } catch (Exception e) {
            System.out.println("selectByCondition " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "booking_status");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return list;
    }
}
