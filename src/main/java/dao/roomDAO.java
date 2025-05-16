package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.room;
import util.JDBCUtil;

public class roomDAO implements daoInterface<room> {

    public static roomDAO getIns() {
        return new roomDAO();
    }

    @Override
    public int insert(room t) {
        int kq = 0;
        String sql = "INSERT INTO room(room_name, room_description, room_booking_time, room_view, floor_id, rt_id, rs_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = JDBCUtil.getConn();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, t.getRoom_name());
            ps.setString(2, t.getRoom_description());
            ps.setInt(3, t.getRoom_booking_time());
            ps.setString(4, t.getRoom_view());
            ps.setInt(5, t.getFloor_id());
            ps.setInt(6, t.getRt_id());
            ps.setInt(7, t.getRs_id());
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("insert " + e);
        }
        return kq;
    }

    @Override
    public int update(room t) {
        int kq = 0;
        String sql = "UPDATE room SET room_name = ?, room_description = ?, room_booking_time = ?, room_view = ?, floor_id = ?, rt_id = ?, rs_id = ? WHERE room_id = ?";
        try (Connection con = JDBCUtil.getConn();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, t.getRoom_name());
            ps.setString(2, t.getRoom_description());
            ps.setInt(3, t.getRoom_booking_time());
            ps.setString(4, t.getRoom_view());
            ps.setInt(5, t.getFloor_id());
            ps.setInt(6, t.getRt_id());
            ps.setInt(7, t.getRs_id());
            ps.setInt(8, t.getRoom_id());
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("update " + e);
        }
        return kq;
    }

    @Override
    public int delete(room t) {
        int kq = 0;
        String sql = "DELETE FROM room WHERE room_id = ?";
        try (Connection con = JDBCUtil.getConn();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, t.getRoom_id());
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("delete " + e);
        }
        return kq;
    }

    @Override
    public ArrayList<room> selectAll() {
        ArrayList<room> list = new ArrayList<>();
        String sql = "SELECT * FROM room";
        try (Connection con = JDBCUtil.getConn();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                room r = new room();
                r.setRoom_id(rs.getInt("room_id"));
                r.setRoom_name(rs.getString("room_name"));
                r.setRoom_description(rs.getString("room_description"));
                r.setRoom_booking_time(rs.getInt("room_booking_time"));
                r.setRoom_view(rs.getString("room_view"));
                r.setFloor_id(rs.getInt("floor_id"));
                r.setRt_id(rs.getInt("rt_id"));
                r.setRs_id(rs.getInt("rs_id"));
                list.add(r);
            }
        } catch (Exception e) {
            System.out.println("selectAll " + e);
        }
        return list;
    }

    @Override
    public room selectById(int id) {
        room r = null;
        String sql = "SELECT * FROM room WHERE room_id = ?";
        try (Connection con = JDBCUtil.getConn();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                r = new room();
                r.setRoom_id(rs.getInt("room_id"));
                r.setRoom_name(rs.getString("room_name"));
                r.setRoom_description(rs.getString("room_description"));
                r.setRoom_booking_time(rs.getInt("room_booking_time"));
                r.setRoom_view(rs.getString("room_view"));
                r.setFloor_id(rs.getInt("floor_id"));
                r.setRt_id(rs.getInt("rt_id"));
                r.setRs_id(rs.getInt("rs_id"));
            }
        } catch (Exception e) {
            System.out.println("selectById " + e);
        }
        return r;
    }

    @Override
    public ArrayList<room> selectByCondition(String condition) {
        ArrayList<room> list = new ArrayList<>();
        String sql = "SELECT * FROM room WHERE " + condition;
        try (Connection con = JDBCUtil.getConn();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                room r = new room();
                r.setRoom_id(rs.getInt("room_id"));
                r.setRoom_name(rs.getString("room_name"));
                r.setRoom_description(rs.getString("room_description"));
                r.setRoom_booking_time(rs.getInt("room_booking_time"));
                r.setRoom_view(rs.getString("room_view"));
                r.setFloor_id(rs.getInt("floor_id"));
                r.setRt_id(rs.getInt("rt_id"));
                r.setRs_id(rs.getInt("rs_id"));
                list.add(r);
            }
        } catch (Exception e) {
            System.out.println("selectByCondition " + e);
        }
        return list;
    }
}
