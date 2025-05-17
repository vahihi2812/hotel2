package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.booking_report;
import util.JDBCUtil;

public class booking_reportDAO implements daoInterface<booking_report> {

    public static booking_reportDAO getInstance() {
        return new booking_reportDAO();
    }

    @Override
    public int insert(booking_report t) {
        int kq = 0;
        try {
            String sql = "INSERT INTO booking_report (br_id, br_amount) VALUES (?, ?)";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, t.getBr_id());
            ps.setInt(2, t.getBr_amount());
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("insert booking_report " + e);
        }
        return kq;
    }

    @Override
    public int update(booking_report t) {
        int kq = 0;
        try {
            String sql = "UPDATE booking_report SET br_amount = ? WHERE br_id = ?";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, t.getBr_amount());
            ps.setInt(2, t.getBr_id());
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("update booking_report " + e);
        }
        return kq;
    }

    @Override
    public int delete(booking_report t) {
        int kq = 0;
        try {
            String sql = "DELETE FROM booking_report WHERE br_id = ?";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, t.getBr_id());
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("delete booking_report " + e);
        }
        return kq;
    }

    @Override
    public ArrayList<booking_report> selectAll() {
        ArrayList<booking_report> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM booking_report";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                booking_report br = new booking_report();
                br.setBr_id(rs.getInt("br_id"));
                br.setBr_amount(rs.getInt("br_amount"));
                list.add(br);
            }
        } catch (Exception e) {
            System.out.println("selectAll booking_report " + e);
        }
        return list;
    }

    @Override
    public booking_report selectById(int id) {
        booking_report br = null;
        try {
            String sql = "SELECT * FROM booking_report WHERE br_id = ?";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                br = new booking_report();
                br.setBr_id(rs.getInt("br_id"));
                br.setBr_amount(rs.getInt("br_amount"));
            }
        } catch (Exception e) {
            System.out.println("selectById booking_report " + e);
        }
        return br;
    }

    @Override
    public ArrayList<booking_report> selectByCondition(String condition) {
        ArrayList<booking_report> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM booking_report WHERE " + condition;
            Connection con = JDBCUtil.getConn();
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
        }
        return list;
    }
}
