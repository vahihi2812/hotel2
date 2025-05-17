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
	<main id="main" class="main">
		
		<div class="pagetitle">
			<h1>Quản lý tài khoản</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="<%=request.getContextPath() %>/home">Trang chủ</a></li>
					<li class="breadcrumb-item active">Quản lý tài khoản</li>
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
							    <h5 class="card-title mb-0">Danh sách tài khoản</h5>
							
							    <!-- Form lọc tài khoản -->
							    <form id="filterForm" method="GET" action="" class="d-flex align-items-center gap-2">
							      <label class="form-label mb-0 me-1" for="filterSelect">Lọc:</label>
							      <select name="filter" id="filterSelect" class="form-select form-select-sm" onchange="this.form.submit()">
							        <option value="loc">Lọc</option>
							        <option value="all">Tất cả</option>
							        <option value="admin">Admin</option>
							        <option value="cus">Khách hàng</option>
							      </select>
							    </form>
							
							    <!-- Form upload Excel -->
							    <form action="accounts" method="post" enctype="multipart/form-data" class="d-flex align-items-center gap-2">
							    	<input type="hidden" name="action" value="addbyexcel"/>
							     	 <label for="excelFile" class="form-label mb-0">Thêm bằng file Excel:</label>
							      		<input type="file" name="file" id="excelFile" class="form-control form-control-sm" accept=".xlsx" />
							      	<button type="submit" class="btn btn-sm btn-primary">Thêm</button>
							    </form>
							
							  </div>
							
							  <!-- Nút thêm tài khoản mới -->
							  <button type="button" class="btn btn-primary d-flex align-items-center gap-1"
							    data-bs-toggle="modal" data-bs-target="#addModal">
							    <i class="bi bi-plus-circle"></i>
							    <span>Thêm tài khoản mới</span>
							  </button>
							</div>

							<!-- Table with stripped rows -->
							<table class="table datatable">
								<thead>
									<tr>
										<th><b>S</b>TT</th>
										<th>Tên đăng nhập</th>
										<th>Vai trò</th>
										<th>Chức năng</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="acc" items="${list_acc}" varStatus="loop">
								        <tr>
								            <td>${loop.index + 1}</td>
								            <td>${acc.account_username}</td>
								            <td>
								                <c:choose>
								                    <c:when test="${acc.role_id == 1}">Admin</c:when>
								                    <c:otherwise>Khách hàng</c:otherwise>
								                </c:choose>
								            </td>
								            <td>
								                <button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#viewModal"
								                    data-account-id="${acc.account_id}"
								                    data-account-username="${acc.account_username}"
								                    data-account-password="${acc.account_password}"
								                    data-account-status="${acc.account_status}"
								                    data-account-created-at="${acc.account_created_at}"
								                    data-account-updated-at="${acc.account_updated_at}"
								                    data-account-last-login-at="${acc.account_last_login_at}"
								                    data-account-login-time="${acc.account_login_time}"
								                    data-role-id="${acc.role_id}">
								                    Xem
								                </button>
								                <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editModal"
								                    data-account-id="${acc.account_id}"
								                    data-account-username="${acc.account_username}"
								                    data-account-password="${acc.account_password}"
								                    data-account-status="${acc.account_status}"
								                    data-account-created-at="${acc.account_created_at}"
								                    data-account-updated-at="${acc.account_updated_at}"
								                    data-account-last-login-at="${acc.account_last_login_at}"
								                    data-account-login-time="${acc.account_login_time}"
								                    data-role-id="${acc.role_id}">
								                    Sửa
								                </button>
								                <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal"
								                    data-account-id="${acc.account_id}"
								                    data-account-username="${acc.account_username}">
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
  </body>

	<!-- Add Modal -->
	<div class="modal fade" id="addModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Thêm tài khoản mới</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<form id="addForm" action="accounts" method="post">
						<input type="hidden" name="action" value="add" />
						<div class="mb-3">
							<label class="form-label">Tên đăng nhập</label> <input
								type="text" class="form-control" name="account_username" required>
						</div>
						<div class="mb-3">
							<label class="form-label">Mật khẩu</label> <input type="password"
								class="form-control" name="account_password" required>
						</div>
						<div class="mb-3">
							<label class="form-label">Vai trò</label> <select
								class="form-select" name="role_id" required>
								<option value="1">Admin</option>
								<option value="2">Khách hàng</option>
							</select>
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

	<!-- Delete Modal -->
	<div class="modal fade" id="deleteModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<form id="deleteForm" action="accounts" method="post">
					<!-- Hidden field để truyền username hoặc id -->
					<input type="hidden" name="account_id" id="account_id" /> <input type="hidden"
						name="action" value="delete" />
					<div class="modal-header">
						<h5 class="modal-title">Xác nhận xóa tài khoản</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<p>Bạn có chắc chắn muốn xóa tài khoản này?</p>
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

