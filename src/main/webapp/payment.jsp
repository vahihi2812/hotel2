<%@page import="dao.roomDAO"%>
<%@page import="model.room"%>
<%@page import="model.customer"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
	<%@include file="/adjsp/lib/header1.jsp"%>
	<%@include file="/adjsp/lib/sidebar1.jsp"%>

	<body>
		<main id="main" class="main">
			<div class="pagetitle">
				<h1>Chi tiết đặt phòng</h1>
				<nav>
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="<%= request.getContextPath() %>/trangchu">Trang chủ</a></li>
						<li class="breadcrumb-item active">Chi tiết đặt phòng</li>
					</ol>
				</nav>
			</div>

			<!-- Bảng chi tiết đặt phòng -->
			<div class="card shadow p-3">
				<table class="table table-bordered">
					<tbody>
						<tr>
							<th scope="row">Tên khách hàng</th>
							<td><%=cus.getCustomer_firstname() + " " + cus.getCustomer_lastname() %></td>
						</tr>
						<tr>
							<%String room_id = request.getParameter("room_id");
							  room r = roomDAO.getIns().selectById(Integer.parseInt(room_id));
							  String room_name = r.getRoom_name();
							  String room_price = r.getRt_id() == 1 ? "600000" : "1200000";
							%>
							<th scope="row">Phòng</th>
							<td><%=room_name %></td>
						</tr>
						<tr>
							<th scope="row">Giá</th>
							<td><%=room_price %> VNĐ/ngày</td>
						</tr>
						<tr>
							<th scope="row">Số ngày thuê</th>
							<td>
								<input type="number" id="rent" name="rent">
							</td>
						</tr>
					</tbody>
					<tfoot>
						<tr class="table-success">
							<th colspan="1">Tổng tiền</th>
							<td><strong></strong></td>
						</tr>
					</tfoot>
				</table>

				<!-- Form đặt phòng -->
				<form action="payment" method="post">
					<input type="hidden" name="totalBill" id="totalBill" value="600000">
					<input type="hidden" name="r_id" id="r_id" value="">
					<input type="hidden" name="re" id="re" value="">
					<button type="submit" class="btn btn-primary">
						<i class="bi bi-check-circle"></i> Xác nhận đặt phòng
					</button>
				</form>
			</div>
		</main>

		<%@include file="/adjsp/lib/footer.jsp"%>
	</body>
	
	<script>
	  document.addEventListener("DOMContentLoaded", function () {
	    const price = <%=room_price%>; // Lấy từ server
	    const rentInput = document.getElementById("rent");
	    const totalInput = document.getElementById("totalBill");
	    const totalDisplay = document.querySelector("tfoot td strong");
	    const re = document.getElementById("re");
	    const r_id = document.getElementById("r_id");
	
	    function updateTotal() {
	      const days = parseInt(rentInput.value || "1");
	      const total = days * price;
	
	      totalInput.value = total; // Gán vào hidden input để gửi đi
	      re.value = days;
	      r_id.value = <%=room_id%>;
	      totalDisplay.textContent = total.toLocaleString("vi-VN") + " VNĐ";
	    }
	
	    rentInput.addEventListener("input", updateTotal);
	    updateTotal(); // gọi ban đầu
	  });
	</script>

</html>