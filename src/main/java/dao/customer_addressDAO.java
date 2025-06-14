package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.customer_address;
import util.ConnectionPoolImpl;

public class customer_addressDAO implements daoInterface<customer_address>{
	
	private Connection con;
	
	public customer_addressDAO() {
		try {
			this.con = ConnectionPoolImpl.getInstance().getConnection("custome_address");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
    public static customer_addressDAO getIns(){
        return new customer_addressDAO();
    }

	@Override
	public int insert(customer_address t) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int update(customer_address t) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(customer_address t) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
    public ArrayList<customer_address> selectAll() {
        ArrayList<customer_address> list = null;
        try {
        	list = new ArrayList<>();
            String sql = "SELECT * FROM customer_address";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
            	int ca_id = rs.getInt("ca_id");
            	String ca_name = rs.getString("ca_name");
            	int ca_amount = rs.getInt("ca_amount");
            	customer_address ca = new customer_address(ca_id, ca_name, ca_amount);
            	list.add(ca);
            }
        } catch (Exception e) {
            System.out.println("selectAll customer_address " + e);
        }finally {
        	try {
				ConnectionPoolImpl.getInstance().releaseConnection(this.con, "customer address");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
        return list;
    }

	@Override
	public customer_address selectById(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<customer_address> selectByCondition(String condition) {
		// TODO Auto-generated method stub
		return null;
	}

}
