package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.booking_report;
import util.ConnectionPoolImpl;

public class booking_reportDAO implements daoInterface<booking_report> {

	private Connection con;
	
	public booking_reportDAO(){
		try {
			this.con = ConnectionPoolImpl.getInstance().getConnection("booking_report");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
    public static booking_reportDAO getInstance() {
        return new booking_reportDAO();
    }

    @Override
    public int insert(booking_report t) {
        int kq = 0;
        try {
            String sql = "INSERT INTO booking_report (br_id, br_amount) VALUES (?, ?)";
            //Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, t.getBr_id());
            ps.setInt(2, t.getBr_amount());
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("insert booking_report " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "booking_report");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
        return kq;
    }

    @Override
    public int update(booking_report t) {
        int kq = 0;
        try {
            String sql = "UPDATE booking_report SET br_amount = ? WHERE br_id = ?";
            //Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, t.getBr_amount());
            ps.setInt(2, t.getBr_id());
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("update booking_report " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "booking_report");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return kq;
    }

    @Override
    public int delete(booking_report t) {
        int kq = 0;
        try {
            String sql = "DELETE FROM booking_report WHERE br_id = ?";
            //Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, t.getBr_id());
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("delete booking_report " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "booking_report");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return kq;
    }

    @Override
    public ArrayList<booking_report> selectAll() {
        ArrayList<booking_report> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM booking_report";
            //Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                booking_report br = new booking_report();
                br.setBr_id(rs.getInt("br_id"));
                br.setBr_amount(rs.getInt("br_amount"));
                br.setBr_floor_1(rs.getInt("br_floor_1"));
                br.setBr_floor_2(rs.getInt("br_floor_2"));
                br.setBr_floor_3(rs.getInt("br_floor_3"));
                br.setBr_floor_4(rs.getInt("br_floor_4"));
                br.setBr_floor_5(rs.getInt("br_floor_5"));
                list.add(br);
            }
        } catch (Exception e) {
            System.out.println("selectAll booking_report " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "booking_report");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return list;
    }

    @Override
    public booking_report selectById(int id) {
        booking_report br = null;
        try {
            String sql = "SELECT * FROM booking_report WHERE br_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                br = new booking_report();
                br.setBr_id(rs.getInt("br_id"));
                br.setBr_amount(rs.getInt("br_amount"));
                br.setBr_floor_1(rs.getInt("br_floor_1"));
                br.setBr_floor_2(rs.getInt("br_floor_2"));
                br.setBr_floor_3(rs.getInt("br_floor_3"));
                br.setBr_floor_4(rs.getInt("br_floor_4"));
                br.setBr_floor_5(rs.getInt("br_floor_5"));
            }
        } catch (Exception e) {
            System.out.println("selectById booking_report " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "booking_report");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return br;
    }

    @Override
    public ArrayList<booking_report> selectByCondition(String condition) {
        ArrayList<booking_report> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM booking_report WHERE " + condition;
            //Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                booking_report br = new booking_report();
                br.setBr_id(rs.getInt("br_id"));
                br.setBr_amount(rs.getInt("br_amount"));
                list.add(br);
            }
        } catch (Exception e) {
            System.out.println("selectByCondition booking_report " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "booking_report");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return list;
    }
    
    public ArrayList<booking_report> selectBetween(int s, int e) {
        ArrayList<booking_report> list = null;
        try {
        	list = new ArrayList<>();
            String sql = "SELECT * FROM booking_report WHERE br_id between ? and ?"; 
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, s);
            ps.setInt(2, e);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                booking_report br = new booking_report();
                br.setBr_id(rs.getInt("br_id"));
                br.setBr_amount(rs.getInt("br_amount"));
                br.setBr_floor_1(rs.getInt("br_floor_1"));
                br.setBr_floor_2(rs.getInt("br_floor_2"));
                br.setBr_floor_3(rs.getInt("br_floor_3"));
                br.setBr_floor_4(rs.getInt("br_floor_4"));
                br.setBr_floor_5(rs.getInt("br_floor_5"));
                list.add(br);
            }
        } catch (Exception ex) {
            System.out.println("select Between booking_report " + ex);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "booking_report");
			} catch (SQLException ex) {
				// TODO Auto-generated catch block
				ex.printStackTrace();
			}
		}
        return list;
    }
}
