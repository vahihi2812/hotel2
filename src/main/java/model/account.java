package model;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // Tự động tạo getter, setter, toString, equals, hashCode
@NoArgsConstructor // Constructor không tham số
@AllArgsConstructor // Constructor đầy đủ tham số
public class account {
	private int account_id;
    private String account_username;
    private String account_password;
    private int account_status;
    private Timestamp account_created_at;
    private Timestamp account_updated_at;
    private Timestamp account_last_login_at;
    private int account_login_time;
    private int role_id;
}
