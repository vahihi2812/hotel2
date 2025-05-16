package model;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // Tự động tạo getter, setter, toString, equals, hashCode
@NoArgsConstructor // Constructor không tham số
@AllArgsConstructor // Constructor đầy đủ tham số
public class user {
	private int user_id;
    private String user_fullname;
    private Date user_date_of_birth;
    private String user_address;
    private int user_gender;
    private String user_phone_number;
    private String user_email;
    private int account_id;
}
