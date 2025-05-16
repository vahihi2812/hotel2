package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.image;
import util.JDBCUtil;

public class imageDAO implements daoInterface<image> {

    public static imageDAO getIns() {
        return new imageDAO();
    }

    @Override
    public int insert(image t) {
        int kq = 0;
        String sql = "INSERT INTO image(image_url, rt_id) VALUES (?, ?)";
        try (Connection con = JDBCUtil.getConn();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, t.getImage_url());
            ps.setInt(2, t.getRt_id());
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("insert " + e);
        }
        return kq;
    }

    @Override
    public int update(image t) {
        int kq = 0;
        String sql = "UPDATE image SET image_url = ?, rt_id = ? WHERE image_id = ?";
        try (Connection con = JDBCUtil.getConn();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, t.getImage_url());
            ps.setInt(2, t.getRt_id());
            ps.setInt(3, t.getImage_id());
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("update " + e);
        }
        return kq;
    }

    @Override
    public int delete(image t) {
        int kq = 0;
        String sql = "DELETE FROM image WHERE image_id = ?";
        try (Connection con = JDBCUtil.getConn();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, t.getImage_id());
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("delete " + e);
        }
        return kq;
    }

    @Override
    public ArrayList<image> selectAll() {
        ArrayList<image> list = new ArrayList<>();
        String sql = "SELECT * FROM image";
        try (Connection con = JDBCUtil.getConn();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                image img = new image();
                img.setImage_id(rs.getInt("image_id"));
                img.setImage_url(rs.getString("image_url"));
                img.setRt_id(rs.getInt("rt_id"));
                list.add(img);
            }
        } catch (Exception e) {
            System.out.println("selectAll " + e);
        }
        return list;
    }

    @Override
    public image selectById(int id) {
        image img = null;
        String sql = "SELECT * FROM image WHERE image_id = ?";
        try (Connection con = JDBCUtil.getConn();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                img = new image();
                img.setImage_id(rs.getInt("image_id"));
                img.setImage_url(rs.getString("image_url"));
                img.setRt_id(rs.getInt("rt_id"));
            }
        } catch (Exception e) {
            System.out.println("selectById " + e);
        }
        return img;
    }

    @Override
    public ArrayList<image> selectByCondition(String condition) {
        ArrayList<image> list = new ArrayList<>();
        String sql = "SELECT * FROM image WHERE " + condition;
        try (Connection con = JDBCUtil.getConn();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                image img = new image();
                img.setImage_id(rs.getInt("image_id"));
                img.setImage_url(rs.getString("image_url"));
                img.setRt_id(rs.getInt("rt_id"));
                list.add(img);
            }
        } catch (Exception e) {
            System.out.println("selectByCondition " + e);
        }
        return list;
    }
}
