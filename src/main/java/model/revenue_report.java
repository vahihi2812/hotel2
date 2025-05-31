package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // Tự động tạo getter, setter, toString, equals, hashCode
@NoArgsConstructor // Constructor không tham số
@AllArgsConstructor // Constructor đầy đủ tham số
public class revenue_report {
	private int rr_id;
	private double rr_amount;
	private double rr_room;
	private double rr_service;
	private double rr_spa;
	private double rr_sport;
	private double rr_food;
}
