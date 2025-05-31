package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // Tự động tạo getter, setter, toString, equals, hashCode
@NoArgsConstructor // Constructor không tham số
@AllArgsConstructor // Constructor đầy đủ tham số
public class booking_report {
	private int br_id;
	private int br_amount;
	private int br_floor_1;
	private int br_floor_2;
	private int br_floor_3;
	private int br_floor_4;
	private int br_floor_5;
}
