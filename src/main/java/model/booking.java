package model;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // Tự động tạo getter, setter, toString, equals, hashCode
@NoArgsConstructor // Constructor không tham số
@AllArgsConstructor // Constructor đầy đủ tham số
public class booking {
	private int booking_id;
	private Timestamp booking_time;
	private Date booking_start_date;
	private Date booking_end_date;
	private double booking_service_cost;
	private double booking_room_cost;
	private double booking_total_cost;
	private int customer_id;
	private int room_id;
	private int payment_id;
	private int bs_id;

}
