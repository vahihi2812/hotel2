<%@page import="model.customer"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
	<meta charset="utf-8">
</head>
	<%@include file="/adjsp/lib/header.jsp"%>
	<%@include file="/adjsp/lib/sidebar.jsp"%>
<body>
	<%
		ArrayList<customer> list = (ArrayList<customer>) request.getAttribute("list_all");
	%>
			
	<main id="main" class="main">
		
		<div class="pagetitle">
			<h1>Quản lý khách hàng</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/home">Trang chủ</a></li>
					<li class="breadcrumb-item active">Quản lý khách hàng</li>
				</ol>
			</nav>
		</div>

		<section class="section">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<div class="d-flex justify-content-between align-items-center">
							    <div class="d-flex align-items-center gap-2">
							        <h5 class="card-title mb-0">Danh sách khách hàng</h5>
							        
							        <!-- Form với select để tự động submit khi thay đổi -->
<!-- 							        <form id="filterForm" method="GET" action=""> -->
<!-- 							            <select name="filter" class="form-select form-select-sm" onchange="this.form.submit()"> -->
<!-- 							                <option value="loc">Lọc</option> -->
<!-- 							                <option value="all">Tất cả</option> -->
<!-- 							                <option value="admin">Admin</option> -->
<!-- 							                <option value="cus">Người dùng</option> -->
<!-- 							                Thêm các option khác nếu cần -->
<!-- 							            </select> -->
<!-- 							        </form> -->
							    </div>
							
							    <button type="button" class="btn btn-primary"
							        data-bs-toggle="modal" data-bs-target="#addModal">
							        <i class="bi bi-plus-circle"></i> Thêm khách hàng mới
							    </button>
							</div>

							<!-- Table with stripped rows -->
							<table class="table datatable">
								<thead>
									<tr>
										<th><b>S</b>TT</th>
										<th>Mã khách hàng</th>
										<th>Họ</th>
										<th>Tên</th>
										<th>Giới tính</th>
										<th>Chức năng</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="cus" items="${list_all}" varStatus="loop">
								        <tr>
								            <td>${loop.index + 1}</td>
								            <td>${cus.customer_id}</td>
								            <td>${cus.customer_firstname}</td>
								            <td>${cus.customer_lastname}</td>
								            <td>
								                <c:choose>
								                    <c:when test="${cus.customer_gender == 0}">Nam</c:when>
								                    <c:otherwise>Nữ </c:otherwise>
								                </c:choose>
								            </td>
								            <td>
												<button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#viewModal"
												        data-customer-id="${cus.customer_id}" 
												        data-customer-firstname="${cus.customer_firstname}"
												        data-customer-lastname="${cus.customer_lastname}"
												        data-customer-date-of-birth="${cus.customer_date_of_birth}"
												        data-customer-gender="${cus.customer_gender}"
												        data-customer-phone-number="${cus.customer_phone_number}"
												        data-customer-email="${cus.customer_email}"
												        data-customer-address="${cus.customer_address}"
												        data-customer-cccd="${cus.customer_cccd}"
												        data-customer-booking-time="${cus.customer_booking_time}"
												        data-customer-account-id="${cus.account_id}">
												    	Xem
												</button>
												
								                <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editModal"
								                    	data-customer-id="${cus.customer_id}" 
												        data-customer-firstname="${cus.customer_firstname}"
												        data-customer-lastname="${cus.customer_lastname}"
												        data-customer-date-of-birth="${cus.customer_date_of_birth}"
												        data-customer-gender="${cus.customer_gender}"
												        data-customer-phone-number="${cus.customer_phone_number}"
												        data-customer-email="${cus.customer_email}"
												        data-customer-address="${cus.customer_address}"
												        data-customer-cccd="${cus.customer_cccd}"
												        data-customer-booking-time="${cus.customer_booking_time}"
												        data-customer-account-id="${cus.account_id}">
												    	Sửa
								                </button>
								                <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal"
								                    data-customer-id="${cus.customer_id}">
								                    Xóa
								                </button>
								            </td>
								        </tr>
								    </c:forEach>
								</tbody>
							</table>
							<!-- End Table with stripped rows -->

						</div>
					</div>

				</div>
			</div>
		</section>
	</main>

	<!-- Add Modal -->
	<div class="modal fade" id="addModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Thêm khách hàng mới</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<form id="addForm" action="customers" method="post">
						<input type="hidden" name="action" value="add" />
					
						<div class="mb-3">
							<label class="form-label">Họ đệm</label>
							<input type="text" class="form-control" name="customer_firstname" required>
						</div>
					
						<div class="mb-3">
							<label class="form-label">Tên</label>
							<input type="text" class="form-control" name="customer_lastname" required>
						</div>
					
						<div class="mb-3">
							<label class="form-label">Ngày sinh</label>
							<input type="date" class="form-control" name="customer_date_of_birth" required>
						</div>
					
						<div class="mb-3">
							<label class="form-label">Giới tính</label>
							<select class="form-select" name="customer_gender" required>
								<option value="0">Nam</option>
								<option value="1">Nữ</option>
							</select>
						</div>
					
						<div class="mb-3">
							<label class="form-label">Số điện thoại</label>
							<input type="text" class="form-control" name="customer_phone_number" required>
						</div>
					
						<div class="mb-3">
							<label class="form-label">Email</label>
							<input type="email" class="form-control" name="customer_email" required>
						</div>
					
						<div class="mb-3">
							<label class="form-label">Địa chỉ</label>
							<input type="text" class="form-control" name="customer_address" required>
						</div>
					
						<div class="mb-3">
							<label class="form-label">CCCD</label>
							<input type="text" class="form-control" name="customer_cccd" required>
						</div>
					
						<div class="mb-3">
							<label class="form-label">ID tài khoản - Nhập 0 với khách hàng offline</label>
							<input type="number" class="form-control" name="account_id" required>
						</div>
					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Đóng</button>
					<button type="submit" form="addForm" class="btn btn-primary">Lưu</button>
				</div>
			</div>
		</div>
	</div>

	<!-- View Modal -->
	<div class="modal fade" id="viewModal" tabindex="-1">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title">Chi tiết khách hàng</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	            </div>
	            <div class="modal-body">
	                <div class="mb-3">
	                    <strong>ID Khách hàng: </strong>
	                    <p class="customer_id"></p>
	                </div>
	                <div class="mb-3">
	                    <strong>Họ: </strong>
	                    <p class="customer_firstname"></p>
	                </div>
	                <div class="mb-3">
	                    <strong>Tên: </strong>
	                    <p class="customer_lastname"></p>
	                </div>
	                <div class="mb-3">
	                    <strong>Ngày sinh: </strong>
	                    <p class="customer_date_of_birth"></p>
	                </div>
	                <div class="mb-3">
	                    <strong>Giới tính: </strong>
	                    <p class="customer_gender"></p>
	                </div>
	                <div class="mb-3">
	                    <strong>Số điện thoại: </strong>
	                    <p class="customer_phone_number"></p>
	                </div>
	                <div class="mb-3">
	                    <strong>Email: </strong>
	                    <p class="customer_email"></p>
	                </div>
	                <div class="mb-3">
	                    <strong>Địa chỉ: </strong>
	                    <p class="customer_address"></p>
	                </div>
	                <div class="mb-3">
	                    <strong>CCCD: </strong>
	                    <p class="customer_cccd"></p>
	                </div>
	                <div class="mb-3">
	                    <strong>Số lần đặt tour: </strong>
	                    <p class="customer_booking_time"></p>
	                </div>
	                <div class="mb-3">
	                    <strong>ID Tài khoản:</strong>
	                    <p class="customer_account_id"></p>
	                </div>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
	            </div>
	        </div>
	    </div>
	</div>



	<!-- Edit Customer Modal -->
	<div class="modal fade" id="editModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Chỉnh sửa khách hàng</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<form id="editForm" action="customers" method="post">
						<input type="hidden" name="customer_id" />
						<input type="hidden" name="account_id" />
						<input type="hidden" name="action" value="edit" />
	
						<div class="mb-3">
							<label class="form-label">Họ</label>
							<input type="text" class="form-control" name="customer_firstname" required />
						</div>
						<div class="mb-3">
							<label class="form-label">Tên</label>
							<input type="text" class="form-control" name="customer_lastname" required />
						</div>
						<div class="mb-3">
							<label class="form-label">Ngày sinh</label>
							<input type="date" class="form-control" name="customer_date_of_birth"/>
						</div>
						<div class="mb-3">
							<label class="form-label">Giới tính</label>
							<select class="form-select" name="customer_gender">
								<option value="0">Nam</option>
								<option value="1">Nữ</option>
								<option value="2">Khác</option>
							</select>
						</div>
						<div class="mb-3">
							<label class="form-label">Số điện thoại</label>
							<input type="text" class="form-control" name="customer_phone_number"/>
						</div>
						<div class="mb-3">
							<label class="form-label">Email</label>
							<input type="email" class="form-control" name="customer_email"/>
						</div>
						<div class="mb-3">
							<label class="form-label">Địa chỉ</label>
							<input type="text" class="form-control" name="customer_address"/>
						</div>
						<div class="mb-3">
							<label class="form-label">CCCD</label>
							<input type="text" class="form-control" name="customer_cccd"/>
						</div>
						<div class="mb-3">
							<label class="form-label">Số lần đặt tour</label>
							<input type="text" class="form-control" name="customer_booking_time" required disabled/>
						</div>
						<div class="mb-3">
							<label class="form-label">Mã tài khoản</label>
							<input type="text" class="form-control" name="customer_account_id" disabled/>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
					<button type="submit" form="editForm" class="btn btn-primary">Lưu thay đổi</button>
				</div>
			</div>
		</div>
	</div>


	<!-- Delete Modal -->
	<div class="modal fade" id="deleteModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<form id="deleteForm" action="customers" method="post">
					<!-- Hidden field để truyền hoặc id -->
					<input type="hidden" name="customer_id" id="customer_id" /> <input type="hidden"
						name="action" value="delete" />
					<div class="modal-header">
						<h5 class="modal-title">Xác nhận xóa khách hàng</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<p>Bạn có chắc chắn muốn xóa khách hàng này?</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Hủy</button>
						<button type="submit" class="btn btn-danger">Xóa</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		var editModal = document.getElementById('editModal');
		editModal.addEventListener('show.bs.modal', function(event) {
	    var button = event.relatedTarget;

	    var customer_id = button.getAttribute('data-customer-id');
	    var customer_firstname = button.getAttribute('data-customer-firstname');
	    var customer_lastname = button.getAttribute('data-customer-lastname');
	    var customer_dob = button.getAttribute('data-customer-date-of-birth');
	    var customer_gender = button.getAttribute('data-customer-gender');
	    var customer_phone = button.getAttribute('data-customer-phone-number');
	    var customer_email = button.getAttribute('data-customer-email');
	    var customer_address = button.getAttribute('data-customer-address');
	    var customer_cccd = button.getAttribute('data-customer-cccd');
	    var customer_booking_time = button.getAttribute('data-customer-booking-time');
	    var customer_account_id = button.getAttribute('data-customer-account-id');

	    var modal = this;
	    modal.querySelector('input[name="customer_id"]').value = customer_id;
	    modal.querySelector('input[name="customer_firstname"]').value = customer_firstname;
	    modal.querySelector('input[name="customer_lastname"]').value = customer_lastname;
	    modal.querySelector('input[name="customer_date_of_birth"]').value = customer_dob;
	    modal.querySelector('select[name="customer_gender"]').value = customer_gender;
	    modal.querySelector('input[name="customer_phone_number"]').value = customer_phone;
	    modal.querySelector('input[name="customer_email"]').value = customer_email;
	    modal.querySelector('input[name="customer_address"]').value = customer_address;
	    modal.querySelector('input[name="customer_cccd"]').value = customer_cccd;
	    modal.querySelector('input[name="customer_booking_time"]').value = customer_booking_time;
	    modal.querySelector('input[name="customer_account_id"]').value = customer_account_id;
	});


		const viewModal = document.getElementById('viewModal');
		viewModal.addEventListener('show.bs.modal', function(event) {
		    const button = event.relatedTarget;

		    // Cập nhật thông tin cho các phần tử trong modal
		    viewModal.querySelector('.customer_id').textContent = button.getAttribute('data-customer-id');
		    viewModal.querySelector('.customer_firstname').textContent = button.getAttribute('data-customer-firstname');
		    viewModal.querySelector('.customer_lastname').textContent = button.getAttribute('data-customer-lastname');
		    viewModal.querySelector('.customer_date_of_birth').textContent = button.getAttribute('data-customer-date-of-birth');
		    viewModal.querySelector('.customer_gender').textContent = button.getAttribute('data-customer-gender');
		    viewModal.querySelector('.customer_phone_number').textContent = button.getAttribute('data-customer-phone-number');
		    viewModal.querySelector('.customer_email').textContent = button.getAttribute('data-customer-email');
		    viewModal.querySelector('.customer_address').textContent = button.getAttribute('data-customer-address');
		    viewModal.querySelector('.customer_cccd').textContent = button.getAttribute('data-customer-cccd');
		    viewModal.querySelector('.customer_booking_time').textContent = button.getAttribute('data-customer-booking-time');
		    viewModal.querySelector('.customer_account_id').textContent = button.getAttribute('data-customer-account-id');
		});


		var delModal = document.getElementById('deleteModal');
		delModal.addEventListener('show.bs.modal', function(event) {
			var button = event.relatedTarget;
			var customer_id = button.getAttribute('data-customer-id');

			var modal = this;
			modal.querySelector('input[name="customer_id"]').value = customer_id;
		});
	</script>

</body>
<%@include file="/adjsp/lib/footer.jsp"%>
<script src="adjs/customer-validate.js"></script>
</html>
