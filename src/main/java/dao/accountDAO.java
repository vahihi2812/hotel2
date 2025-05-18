package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.account;
import model.customer;
import model.user;
import util.ConnectionPoolImpl;
import util.JDBCUtil;

public class accountDAO implements daoInterface<account> {

	private Connection con;
	
	public accountDAO() {
		try {
			this.con = ConnectionPoolImpl.getInstance().getConnection("account");
			
			// Chấm dứt chế độ thực thi tự động của kết nối
			//if(this.con.getAutoCommit() == true)
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
    public static accountDAO getIns(){
        return new accountDAO();
    }

    @Override
    public int insert(account t) {
        int kq = 0;
        try {
            String sql = "INSERT INTO account (account_username, account_password, account_status, role_id) VALUES (?, ?, ?, ?)";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, t.getAccount_username());
            ps.setString(2, t.getAccount_password());
            ps.setInt(3, t.getAccount_status());
            ps.setInt(4, t.getRole_id());
            
            kq = ps.executeUpdate();
            int account_id = accountDAO.getIns().findByUsername(t.getAccount_username());
            
            if(kq == 1) {
            	if(t.getRole_id() == 1) {
            		user u = new user(0, t.getAccount_username(), null, "", 0, "", "", account_id);
            		
            		kq = userDAO.getInstance().insert(u);
            	}else if(t.getRole_id() == 2) {
            		customer cus = new customer(0, t.getAccount_username(), t.getAccount_username(), null, 0, "", "", "", "", 0, account_id);
            		
            		kq = customerDAO.getIns().insert(cus);
            	}
            }
        } catch (Exception e) {
            System.out.println("insert account " + e);
        }
        return kq;
    }

    @Override
    public int update(account t) {
        int kq = 0;
        try {
            String sql = "UPDATE account SET account_username = ?, account_password = ?, account_status = ?, role_id = ?, "
            		+ "account_last_login_at = ? "
            		+ "WHERE account_id = ?";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, t.getAccount_username());
            ps.setString(2, t.getAccount_password());
            ps.setInt(3, t.getAccount_status());
            ps.setInt(4, t.getRole_id());
            ps.setTimestamp(5, t.getAccount_last_login_at());
            ps.setInt(6, t.getAccount_id());
            
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("update account " + e);
        }
        return kq;
    }

    @Override
    public int delete(account t) {
        int kq = 0;
        try {
            String sql = "DELETE FROM account WHERE account_id = ?";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, t.getAccount_id());
            
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("delete account " + e);
        }
        return kq;
    }

    @Override
    public ArrayList<account> selectAll() {
        ArrayList<account> accounts = new ArrayList<>();
        try {
            String sql = "SELECT * FROM account";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                account acc = new account();
                acc.setAccount_id(rs.getInt("account_id"));
                acc.setAccount_username(rs.getString("account_username"));
                acc.setAccount_password(rs.getString("account_password"));
                acc.setAccount_status(rs.getInt("account_status"));
                acc.setAccount_created_at(rs.getTimestamp("account_created_at"));
                acc.setAccount_updated_at(rs.getTimestamp("account_updated_at"));
                acc.setAccount_last_login_at(rs.getTimestamp("account_last_login_at"));
                acc.setAccount_login_time(rs.getInt("account_login_time"));
                acc.setRole_id(rs.getInt("role_id"));
                accounts.add(acc);
            }
        } catch (Exception e) {
            System.out.println("selectAll account " + e);
        }
        return accounts;
    }

    @Override
    public account selectById(int id) {
        account acc = null;
        try {
            String sql = "SELECT * FROM account WHERE account_id = ?";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                acc = new account();
                acc.setAccount_id(rs.getInt("account_id"));
                acc.setAccount_username(rs.getString("account_username"));
                acc.setAccount_password(rs.getString("account_password"));
                acc.setAccount_status(rs.getInt("account_status"));
                acc.setAccount_created_at(rs.getTimestamp("account_created_at"));
                acc.setAccount_updated_at(rs.getTimestamp("account_updated_at"));
                acc.setAccount_last_login_at(rs.getTimestamp("account_last_login_at"));
                acc.setAccount_login_time(rs.getInt("account_login_time"));
                acc.setRole_id(rs.getInt("role_id"));
            }
        } catch (Exception e) {
            System.out.println("selectById account " + e);
        }
        return acc;
    }

    @Override
    public ArrayList<account> selectByCondition(String condition) {
        ArrayList<account> accounts = new ArrayList<>();
        try {
            String sql = "SELECT * FROM account WHERE " + condition;
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                account acc = new account();
                acc.setAccount_id(rs.getInt("account_id"));
                acc.setAccount_username(rs.getString("account_username"));
                acc.setAccount_password(rs.getString("account_password"));
                acc.setAccount_status(rs.getInt("account_status"));
                acc.setAccount_created_at(rs.getTimestamp("account_created_at"));
                acc.setAccount_updated_at(rs.getTimestamp("account_updated_at"));
                acc.setAccount_last_login_at(rs.getTimestamp("account_last_login_at"));
                acc.setAccount_login_time(rs.getInt("account_login_time"));
                acc.setRole_id(rs.getInt("role_id"));
                accounts.add(acc);
            }
        } catch (Exception e) {
            System.out.println("selectByCondition account " + e);
        }
        return accounts;
    }

    // Cập nhật thời gian đăng nhập khi người dùng đăng nhập
    public int updateLastLogin(account t) {
        int kq = 0;
        try {
            String sql = "UPDATE account SET account_updated_at = ?, account_login_time = ? WHERE account_id = ?";
            Connection con = JDBCUtil.getConn();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setTimestamp(1, t.getAccount_updated_at());
            ps.setInt(2, t.getAccount_login_time() + 1);
            ps.setInt(3, t.getAccount_id()); // Sử dụng account_id để xác định người dùng
            kq = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("updateLastLogin account " + e);
        }
        return kq;
    }
    
    public account findByUsernameAndPassword(String username, String password) {
        account acc = null;
        String sql = "SELECT * FROM account WHERE account_username = ? AND account_password = ?";
        try (Connection con = JDBCUtil.getConn();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                acc = new account(
                    rs.getInt("account_id"),
                    rs.getString("account_username"),
                    rs.getString("account_password"),
                    rs.getInt("account_status"),
                    rs.getTimestamp("account_created_at"),
                    rs.getTimestamp("account_updated_at"),
                    rs.getTimestamp("account_last_login_at"),
                    rs.getInt("account_login_time"),
                    rs.getInt("role_id")
                );
            }
        } catch (Exception e) {
            System.out.println("findByUsernameAndPassword: " + e.getMessage());
        }
        return acc;
    }
    
    public int findByUsername(String username) {
        int accountId = 0; 
        String sql = "SELECT account_id FROM account WHERE account_username = ?";
        try (Connection con = JDBCUtil.getConn();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                accountId = rs.getInt("account_id");
            }
        } catch (Exception e) {
            System.out.println("findByUsername " + e);
        }
        return accountId;
    }


}
