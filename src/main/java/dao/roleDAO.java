package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.role;
import util.JDBCUtil;

public class roleDAO implements daoInterface<role> {

    public static roleDAO getIns() {
        return new roleDAO();
    }

    @Override
    public int insert(role t) {
        int kq = 0;
        try {
            String sql = "INSERT INTO role(role_name, role_description) VALUES (?, ?)";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, t.getRole_name());
            ps.setString(2, t.getRole_description());
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("insert " + e);
        }
        return kq;
    }

    @Override
    public int update(role t) {
        int kq = 0;
        try {
            String sql = "UPDATE role SET role_name = ?, role_description = ? WHERE role_id = ?";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, t.getRole_name());
            ps.setString(2, t.getRole_description());
            ps.setInt(3, t.getRole_id());
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("update " + e);
        }
        return kq;
    }

    @Override
    public int delete(role t) {
        int kq = 0;
        try {
            String sql = "DELETE FROM role WHERE role_id = ?";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, t.getRole_id());
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("delete " + e);
        }
        return kq;
    }

    @Override
    public ArrayList<role> selectAll() {
        ArrayList<role> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM role";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                role r = new role();
                r.setRole_id(rs.getInt("role_id"));
                r.setRole_name(rs.getString("role_name"));
                r.setRole_description(rs.getString("role_description"));
                list.add(r);
            }
        } catch (Exception e) {
            System.out.println("selectAll " + e);
        }
        return list;
    }

    @Override
    public role selectById(int id) {
        role r = null;
        try {
            String sql = "SELECT * FROM role WHERE role_id = ?";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                r = new role();
                r.setRole_id(rs.getInt("role_id"));
                r.setRole_name(rs.getString("role_name"));
                r.setRole_description(rs.getString("role_description"));
            }
        } catch (Exception e) {
            System.out.println("selectById " + e);
        }
        return r;
    }

    @Override
    public ArrayList<role> selectByCondition(String condition) {
        ArrayList<role> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM role WHERE " + condition;
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                role r = new role();
                r.setRole_id(rs.getInt("role_id"));
                r.setRole_name(rs.getString("role_name"));
                r.setRole_description(rs.getString("role_description"));
                list.add(r);
            }
        } catch (Exception e) {
            System.out.println("selectByCondition " + e);
        }
        return list;
    }
}
