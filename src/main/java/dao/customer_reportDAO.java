package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.customer_report;
import util.JDBCUtil;

public class customer_reportDAO implements daoInterface<customer_report> {

    public static customer_reportDAO getInstance() {
        return new customer_reportDAO();
    }

    @Override
    public int insert(customer_report t) {
        int result = 0;
        try {
            String sql = "INSERT INTO customer_report (cr_amount) VALUES (?)";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, t.getCr_amount());
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("insert customer_report error: " + e);
        }
        return result;
    }

    @Override
    public int update(customer_report t) {
        int result = 0;
        try {
            String sql = "UPDATE customer_report SET cr_amount = ? WHERE cr_id = ?";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, t.getCr_amount());
            ps.setInt(2, t.getCr_id());
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("update customer_report error: " + e);
        }
        return result;
    }

    @Override
    public int delete(customer_report t) {
        int result = 0;
        try {
            String sql = "DELETE FROM customer_report WHERE cr_id = ?";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, t.getCr_id());
            result = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("delete customer_report error: " + e);
        }
        return result;
    }

    @Override
    public ArrayList<customer_report> selectAll() {
        ArrayList<customer_report> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM customer_report";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                customer_report cr = new customer_report();
                cr.setCr_id(rs.getInt("cr_id"));
                cr.setCr_amount(rs.getInt("cr_amount"));
                list.add(cr);
            }
        } catch (Exception e) {
            System.out.println("selectAll customer_report error: " + e);
        }
        return list;
    }

    @Override
    public customer_report selectById(int id) {
        customer_report cr = null;
        try {
            String sql = "SELECT * FROM customer_report WHERE cr_id = ?";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                cr = new customer_report();
                cr.setCr_id(rs.getInt("cr_id"));
                cr.setCr_amount(rs.getInt("cr_amount"));
            }
        } catch (Exception e) {
            System.out.println("selectById customer_report error: " + e);
        }
        return cr;
    }

    @Override
    public ArrayList<customer_report> selectByCondition(String condition) {
        ArrayList<customer_report> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM customer_report WHERE " + condition;
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                customer_report cr = new customer_report();
                cr.setCr_id(rs.getInt("cr_id"));
                cr.setCr_amount(rs.getInt("cr_amount"));
                list.add(cr);
            }
        } catch (Exception e) {
            System.out.println("selectByCondition customer_report error: " + e);
        }
        return list;
    }
}
