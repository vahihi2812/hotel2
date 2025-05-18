<%@page import="model.room"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
	<html lang="en">
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="/adjsp/lib/header.jsp"%>
<%@include file="/adjsp/lib/sidebar.jsp"%>
<body>			
		<%
		    String[] rooms = new String[50];
		    for (int i = 0; i < 50; i++) {
		        int floor = i / 10 + 1;
		        int num = i % 10 + 1;
		        rooms[i] = "Phòng " + floor + String.format("%02d", num);
		    }
		    request.setAttribute("rooms", rooms);
		%>
	<main id="main" class="main">
		
		<div class="pagetitle">
			<h1>Quản lý đặt phòng</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="<%=request.getContextPath() %>/home">Trang chủ</a></li>
					<li class="breadcrumb-item active">Quản lý đặt phòng</li>
				</ol>
			</nav>
		</div>

		<section class="section">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-3">
							
							  <!-- Nhóm bên trái: tiêu đề, lọc và upload -->
							  <div class="d-flex flex-wrap align-items-center gap-3">
							
							    <!-- Tiêu đề -->
							    <h5 class="card-title mb-0">Danh sách đặt phòng</h5>
							
							    <!-- Form lọc danh sách phòng -->
			                    <form action="rooms" method="get" class="mb-3">
			                        <div class="row g-3 align-items-end">
			                            <!-- Loại phòng -->
			                            <div class="col-md-3">
			                                <label class="form-label">Loại phòng</label>
			                                <select name="rt_id" class="form-select">
			                                    <option value="all">Tất cả</option>
			                                    <option value="1" ${param.rt_id == '1' ? 'selected' : ''}>Bình dân</option>
			                                    <option value="2" ${param.rt_id == '2' ? 'selected' : ''}>Cao cấp</option>
			                                </select>
			                            </div>
			
			                            <!-- Trạng thái -->
			                            <div class="col-md-3">
			                                <label class="form-label">Trạng thái</label>
			                                <select name="rs_id" class="form-select">
			                                    <option value="all">Tất cả</option>
			                                    <option value="1" ${param.rs_id == '1' ? 'selected' : ''}>Đang trống</option>
			                                    <option value="2" ${param.rs_id == '2' ? 'selected' : ''}>Đang được đặt</option>
			                                    <option value="3" ${param.rs_id == '3' ? 'selected' : ''}>Đang bảo trì</option>
			                                </select>
			                            </div>
			
			                            <!-- Tầng -->
			                            <div class="col-md-3">
			                                <label class="form-label">Tầng</label>
			                                <select name="floor_id" class="form-select">
			                                    <option value="all">Tất cả</option>
			                                    <option value="1">1</option>
			                                    <option value="2">2</option>
			                                    <option value="3">3</option>
			                                    <option value="4">4</option>
			                                    <option value="5">5</option>
			                                </select>
			                            </div>
			
			                            <!-- Nút lọc -->
			                            <div class="col-md-3">
			                                <button type="submit" class="btn btn-primary">Lọc</button>
			                            </div>
			                        </div>
			                    </form>
			                    <!-- Kết thúc Form lọc -->
							
							  </div>
							</div>

							<!-- Table with stripped rows -->
							<table class="table datatable">
								<thead>
									<tr>
										<th><b>S</b>TT</th>
										<th>Phòng</th>
										<th>Ngày bắt đầu</th>
										<th>Ngày kết thúc</th>
										<th>Tổng chi phí</th>
										<th>Trạng thái</th>										
										<th>Chức năng</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="bk" items="${listbk}" varStatus="loop">
								        <tr>
								            <td>${loop.index + 1}</td>
								            <td>${rooms[bk.room_id]}</td>
								            <td>${bk.booking_start_date}</td>
								            <td>${bk.booking_end_date}</td>
								            <td>${bk.booking_total_cost}</td>
								            <td>
								                <c:choose>
								                    <c:when test="${bk.bs_id == 1}">Đang đặt</c:when>
								                    <c:otherwise>Đã thanh toán</c:otherwise>
								                </c:choose>
								            </td>
								            <td>
								                <button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#viewModal"
								                    >
								                    <i class="bi bi-eye"></i>
								                </button>
								                <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editModal"
								                    >
								                    <i class="bi bi-trash"></i>
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
  </body>

	<!-- View Modal -->
	<div class="modal fade" id="viewModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Chi tiết tài khoản</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <strong>Tên đăng nhập: </strong>
                    <p class="account_username"></p> <!-- Tên cột trong DB -->
                </div>
                <div class="mb-3">
                    <strong>Mật khẩu: </strong>
                    <p class="account_password"></p> <!-- Tên cột trong DB -->
                </div>
                <div class="mb-3">
                    <strong>Vai trò: </strong>
                    <p class="role_id"></p> <!-- Tên cột trong DB -->
                </div>
                <div class="mb-3">
                    <strong>Ngày tạo: </strong>
                    <p class="account_created_at"></p> <!-- Tên cột trong DB -->
                </div>
                <div class="mb-3">
                    <strong>Ngày cập nhật: </strong>
                    <p class="account_updated_at"></p> <!-- Tên cột trong DB -->
                </div>
                <div class="mb-3">
                    <strong>Số lần đăng nhập: </strong>
                    <p class="account_login_time"></p> <!-- Tên cột trong DB -->
                </div>
                <div class="mb-3">
                    <strong>Trạng thái: </strong>
                    <p class="account_status"></p> <!-- Tên cột trong DB -->
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>


	<!-- Edit Modal -->
	<div class="modal fade" id="editModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Chỉnh sửa tài khoản</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<form id="editForm" action="accounts" method="post">
						<input type="hidden" name="account_id" id="account_id" /> 
						<input type="hidden" name="action" value="edit" />
						<div class="mb-3">
							<label class="form-label">Tên đăng nhập</label> <input
								type="text" class="form-control" name="account_username" required
								disabled>
						</div>
						<div class="mb-3">
							<label class="form-label">Mật khẩu</label> <input type="password"
								class="form-control" name="account_password" required>
						</div>
						<div class="mb-3">
							<label class="form-label">Vai trò</label> <select
								class="form-select" name="role_id" required disabled>
								<option value="1">Admin</option>
								<option value="2">Khách hàng</option>
							</select>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Đóng</button>
					<button type="submit" form="editForm" class="btn btn-primary">Lưu
						thay đổi</button>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		var editModal = document.getElementById('editModal');
		editModal.addEventListener('show.bs.modal', function(event) {
			var button = event.relatedTarget;
			var account_username = button.getAttribute('data-account-username');
			var account_password = button.getAttribute('data-account-password');
			var role_id = button.getAttribute('data-role-id');
			var account_id = button.getAttribute('data-account-id');

			var modal = this;
			modal.querySelector('input[name="account_username"]').value = account_username;
			modal.querySelector('input[name="account_password"]').value = account_password;
			modal.querySelector('select[name="role_id"]').value = role_id;
			modal.querySelector('input[name="account_id"]').value = account_id;
		});

		const viewModal = document.getElementById('viewModal');
		viewModal.addEventListener('show.bs.modal', function(event) {
			const button = event.relatedTarget;
			 // Cập nhật thông tin cho các phần tử trong modal
		    viewModal.querySelector('.account_username').textContent = button.getAttribute('data-account-username');
		    viewModal.querySelector('.account_password').textContent = button.getAttribute('data-account-password');
		    viewModal.querySelector('.role_id').textContent = button.getAttribute('data-role-id');
		    viewModal.querySelector('.account_created_at').textContent = button.getAttribute('data-account-created-at');
		    viewModal.querySelector('.account_updated_at').textContent = button.getAttribute('data-account-updated-at');
		    viewModal.querySelector('.account_login_time').textContent = button.getAttribute('data-account-login-time');
		    viewModal.querySelector('.account_status').textContent = button.getAttribute('data-account-status');
		});

		var delModal = document.getElementById('deleteModal');
		delModal.addEventListener('show.bs.modal', function(event) {
			var button = event.relatedTarget;
			var account_id = button.getAttribute('data-account-id');

			var modal = this;
			modal.querySelector('input[name="account_id"]').value = account_id;
		});
	</script>
<%@include file="/adjsp/lib/footer.jsp"%>
</html>

