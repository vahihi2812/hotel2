package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // Tự động tạo getter, setter, toString, equals, hashCode
@NoArgsConstructor // Constructor không tham số
@AllArgsConstructor // Constructor đầy đủ tham số
public class customer {
	private int customer_id;
	private String customer_firstname;
	private String customer_lastname;
	private java.sql.Date customer_date_of_birth;
	private int customer_gender;
	private String customer_phone_number;
	private String customer_email;
	private String customer_address;
	private String customer_cccd;
	private int customer_booking_time;
	private int account_id;

}
