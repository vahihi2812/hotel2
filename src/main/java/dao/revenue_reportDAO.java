package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.revenue_report;
import util.JDBCUtil;

public class revenue_reportDAO implements daoInterface<revenue_report> {

    public static revenue_reportDAO getInstance() {
        return new revenue_reportDAO();
    }

    @Override
    public int insert(revenue_report t) {
        int kq = 0;
        try {
            String sql = "INSERT INTO revenue_report (rr_id, rr_amount) VALUES (?, ?)";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, t.getRr_id());
            ps.setBigDecimal(2, t.getRr_amount());

            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Insert revenue_report error: " + e);
        }
        return kq;
    }

    @Override
    public int update(revenue_report t) {
        int kq = 0;
        try {
            String sql = "UPDATE revenue_report SET rr_amount = ? WHERE rr_id = ?";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setBigDecimal(1, t.getRr_amount());
            ps.setInt(2, t.getRr_id());

            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Update revenue_report error: " + e);
        }
        return kq;
    }

    @Override
    public int delete(revenue_report t) {
        int kq = 0;
        try {
            String sql = "DELETE FROM revenue_report WHERE rr_id = ?";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, t.getRr_id());

            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Delete revenue_report error: " + e);
        }
        return kq;
    }

    @Override
    public ArrayList<revenue_report> selectAll() {
        ArrayList<revenue_report> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM revenue_report";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                revenue_report r = new revenue_report();
                r.setRr_id(rs.getInt("rr_id"));
                r.setRr_amount(rs.getBigDecimal("rr_amount"));
                list.add(r);
            }
        } catch (Exception e) {
            System.out.println("SelectAll revenue_report error: " + e);
        }
        return list;
    }

    @Override
    public revenue_report selectById(int id) {
        revenue_report r = null;
        try {
            String sql = "SELECT * FROM revenue_report WHERE rr_id = ?";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                r = new revenue_report();
                r.setRr_id(rs.getInt("rr_id"));
                r.setRr_amount(rs.getBigDecimal("rr_amount"));
            }
        } catch (Exception e) {
            System.out.println("SelectById revenue_report error: " + e);
        }
        return r;
    }

    @Override
    public ArrayList<revenue_report> selectByCondition(String condition) {
        ArrayList<revenue_report> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM revenue_report WHERE " + condition;
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                revenue_report r = new revenue_report();
                r.setRr_id(rs.getInt("rr_id"));
                r.setRr_amount(rs.getBigDecimal("rr_amount"));
                list.add(r);
            }
        } catch (Exception e) {
            System.out.println("SelectByCondition revenue_report error: " + e);
        }
        return list;
    }
}
