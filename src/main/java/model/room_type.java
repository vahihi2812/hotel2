package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // Tự động tạo getter, setter, toString, equals, hashCode
@NoArgsConstructor // Constructor không tham số
@AllArgsConstructor // Constructor đầy đủ tham số
public class room_type {
	private int rt_id;
	private String rt_name;
	private String rt_description;
	private java.math.BigDecimal rt_price;
	private int rt_max_occupancy;
	private int rt_is_smoking_allowed;

}
