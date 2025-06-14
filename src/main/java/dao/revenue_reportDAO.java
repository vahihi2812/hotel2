package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.revenue_report;
import util.ConnectionPoolImpl;


public class revenue_reportDAO implements daoInterface<revenue_report> {

	private Connection con;
	
	public revenue_reportDAO() {
		try {
			this.con = ConnectionPoolImpl.getInstance().getConnection("revenue_report");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
    public static revenue_reportDAO getInstance() {
        return new revenue_reportDAO();
    }

    @Override
    public int insert(revenue_report t) {
        int kq = 0;
        try {
            String sql = "INSERT INTO revenue_report (rr_id, rr_amount) VALUES (?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, t.getRr_id());
            ps.setDouble(2, t.getRr_amount());

            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Insert revenue_report error: " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "revenue_report");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return kq;
    }
    
    public int insertdaydu(revenue_report t) {
        int kq = 0;
        try {
            String sql = "INSERT INTO revenue_report (rr_id, rr_amount, rr_room, rr_spa, rr_sport, rr_service, rr_food) VALUES (?,?,?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, t.getRr_id());
            ps.setDouble(2, t.getRr_amount());
            ps.setDouble(3, t.getRr_room());
            ps.setDouble(4, t.getRr_spa());
            ps.setDouble(5, t.getRr_sport());
            ps.setDouble(6, t.getRr_service());
            ps.setDouble(7, t.getRr_food());

            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Insert revenue_report error: " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "revenue_report");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return kq;
    }

    @Override
    public int update(revenue_report t) {
        int kq = 0;
        try {
            String sql = "UPDATE revenue_report SET rr_amount = ? WHERE rr_id = ?";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setDouble(1, t.getRr_amount());
            ps.setInt(2, t.getRr_id());

            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Update revenue_report error: " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "revenue_report");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return kq;
    }

    @Override
    public int delete(revenue_report t) {
        int kq = 0;
        try {
            String sql = "DELETE FROM revenue_report WHERE rr_id = ?";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, t.getRr_id());

            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Delete revenue_report error: " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "revenue_report");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return kq;
    }

    @Override
    public ArrayList<revenue_report> selectAll() {
        ArrayList<revenue_report> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM revenue_report";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                revenue_report rr = new revenue_report();
                rr.setRr_id(rs.getInt("rr_id"));
                rr.setRr_amount(rs.getDouble("rr_amount"));
                rr.setRr_food(rs.getDouble("rr_food"));
                rr.setRr_room(rs.getDouble("rr_room"));
                rr.setRr_spa(rs.getDouble("rr_spa"));
                rr.setRr_sport(rs.getDouble("rr_sport"));
                rr.setRr_service(rs.getDouble("rr_service"));
                list.add(rr);
            }
        } catch (Exception e) {
            System.out.println("SelectAll revenue_report error: " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "revenue_report");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return list;
    }

    @Override
    public revenue_report selectById(int id) {
        revenue_report rr = null;
        try {
            String sql = "SELECT * FROM revenue_report WHERE rr_id = ?";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                rr = new revenue_report();
                rr.setRr_id(rs.getInt("rr_id"));
                rr.setRr_amount(rs.getDouble("rr_amount"));
                rr.setRr_food(rs.getDouble("rr_food"));
                rr.setRr_room(rs.getDouble("rr_room"));
                rr.setRr_spa(rs.getDouble("rr_spa"));
                rr.setRr_sport(rs.getDouble("rr_sport"));
                rr.setRr_service(rs.getDouble("rr_service"));
            }
        } catch (Exception e) {
            System.out.println("SelectById revenue_report error: " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "revenue_report");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return rr;
    }

    @Override
    public ArrayList<revenue_report> selectByCondition(String condition) {
        ArrayList<revenue_report> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM revenue_report WHERE " + condition;
            
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                revenue_report rr = new revenue_report();
                rr.setRr_id(rs.getInt("rr_id"));
                rr.setRr_amount(rs.getDouble("rr_amount"));
                rr.setRr_food(rs.getDouble("rr_food"));
                rr.setRr_room(rs.getDouble("rr_room"));
                rr.setRr_spa(rs.getDouble("rr_spa"));
                rr.setRr_sport(rs.getDouble("rr_sport"));
                rr.setRr_service(rs.getDouble("rr_service"));
                list.add(rr);
            }
        } catch (Exception e) {
            System.out.println("SelectByCondition revenue_report error: " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "revenue_report");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return list;
    }
    
    public ArrayList<revenue_report> selectBetween(int s, int e) {
        ArrayList<revenue_report> list = null;
        try {
        	list = new ArrayList<>();
            String sql = "SELECT * FROM revenue_report WHERE rr_id between ? and ?"; 
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, s);
            ps.setInt(2, e);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                revenue_report rr = new revenue_report();
                rr.setRr_id(rs.getInt("rr_id"));
                rr.setRr_amount(rs.getDouble("rr_amount"));
                rr.setRr_food(rs.getDouble("rr_food"));
                rr.setRr_room(rs.getDouble("rr_room"));
                rr.setRr_spa(rs.getDouble("rr_spa"));
                rr.setRr_sport(rs.getDouble("rr_sport"));
                rr.setRr_service(rs.getDouble("rr_service"));
                list.add(rr);
            }
        } catch (Exception ex) {
            System.out.println("selectBetween revenue_report " + ex);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "revenue_report");
			} catch (SQLException ex) {
				// TODO Auto-generated catch block
				ex.printStackTrace();
			}
		}
        return list;
    }
    
    public int updateAfterBookig(double r_cost, int rr_id) {
        int kq = 0;
        try {
            String sql = "UPDATE revenue_report SET rr_amount = rr_amount + ? WHERE rr_id = ?";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setDouble(1, r_cost);
            ps.setInt(2, rr_id);

            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Update revenue_report error: " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "revenue_report");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return kq;
    }
}
