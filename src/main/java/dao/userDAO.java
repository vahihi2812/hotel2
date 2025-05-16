package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.user;
import util.JDBCUtil;

public class userDAO implements daoInterface<user> {

    public static userDAO getInstance() {
        return new userDAO();
    }

    @Override
    public int insert(user t) {
        int kq = 0;
        try {
            String sql = "INSERT INTO user (user_fullname, user_date_of_birth, user_address, user_gender, user_phone_number, user_email, account_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, t.getUser_fullname());
            ps.setDate(2, t.getUser_date_of_birth());
            ps.setString(3, t.getUser_address());
            ps.setInt(4, t.getUser_gender());
            ps.setString(5, t.getUser_phone_number());
            ps.setString(6, t.getUser_email());
            ps.setInt(7, t.getAccount_id());

            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("insert user " + e);
        }
        return kq;
    }

    @Override
    public int update(user t) {
        int kq = 0;
        try {
            String sql = "UPDATE user SET user_fullname = ?, user_date_of_birth = ?, user_address = ?, user_gender = ?, user_phone_number = ?, user_email = ?, account_id = ? WHERE user_id = ?";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, t.getUser_fullname());
            ps.setDate(2, t.getUser_date_of_birth());
            ps.setString(3, t.getUser_address());
            ps.setInt(4, t.getUser_gender());
            ps.setString(5, t.getUser_phone_number());
            ps.setString(6, t.getUser_email());
            ps.setInt(7, t.getAccount_id());
            ps.setInt(8, t.getUser_id());

            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("update user " + e);
        }
        return kq;
    }

    @Override
    public int delete(user t) {
        int kq = 0;
        try {
            String sql = "DELETE FROM user WHERE user_id = ?";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, t.getUser_id());

            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("delete user " + e);
        }
        return kq;
    }

    @Override
    public ArrayList<user> selectAll() {
        ArrayList<user> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM user";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                user u = new user();
                u.setUser_id(rs.getInt("user_id"));
                u.setUser_fullname(rs.getString("user_fullname"));
                u.setUser_date_of_birth(rs.getDate("user_date_of_birth"));
                u.setUser_address(rs.getString("user_address"));
                u.setUser_gender(rs.getInt("user_gender"));
                u.setUser_phone_number(rs.getString("user_phone_number"));
                u.setUser_email(rs.getString("user_email"));
                u.setAccount_id(rs.getInt("account_id"));
                list.add(u);
            }

        } catch (Exception e) {
            System.out.println("selectAll user " + e);
        }
        return list;
    }

    @Override
    public user selectById(int id) {
        user u = null;
        try {
            String sql = "SELECT * FROM user WHERE user_id = ?";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                u = new user();
                u.setUser_id(rs.getInt("user_id"));
                u.setUser_fullname(rs.getString("user_fullname"));
                u.setUser_date_of_birth(rs.getDate("user_date_of_birth"));
                u.setUser_address(rs.getString("user_address"));
                u.setUser_gender(rs.getInt("user_gender"));
                u.setUser_phone_number(rs.getString("user_phone_number"));
                u.setUser_email(rs.getString("user_email"));
                u.setAccount_id(rs.getInt("account_id"));
            }

        } catch (Exception e) {
            System.out.println("selectById user " + e);
        }
        return u;
    }

    @Override
    public ArrayList<user> selectByCondition(String condition) {
        ArrayList<user> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM user WHERE " + condition;
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                user u = new user();
                u.setUser_id(rs.getInt("user_id"));
                u.setUser_fullname(rs.getString("user_fullname"));
                u.setUser_date_of_birth(rs.getDate("user_date_of_birth"));
                u.setUser_address(rs.getString("user_address"));
                u.setUser_gender(rs.getInt("user_gender"));
                u.setUser_phone_number(rs.getString("user_phone_number"));
                u.setUser_email(rs.getString("user_email"));
                u.setAccount_id(rs.getInt("account_id"));
                list.add(u);
            }

        } catch (Exception e) {
            System.out.println("selectByCondition user " + e);
        }
        return list;
    }
    
    public user getUserByAccountId(int accountId) {
        user u = null;
        try {
            String sql = "SELECT * FROM user WHERE account_id = ?";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                u = new user();
                u.setUser_id(rs.getInt("user_id"));
                u.setUser_fullname(rs.getString("user_fullname"));
                u.setUser_date_of_birth(rs.getDate("user_date_of_birth"));
                u.setUser_address(rs.getString("user_address"));
                u.setUser_gender(rs.getInt("user_gender"));
                u.setUser_phone_number(rs.getString("user_phone_number"));
                u.setUser_email(rs.getString("user_email"));
                u.setAccount_id(rs.getInt("account_id"));
            }

        } catch (Exception e) {
            System.out.println("getUserByAccountId error: " + e);
        }
        return u;
    }

}
