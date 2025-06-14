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
							    <form id="filterForm" class="d-flex align-items-center gap-2">
							      <select name="filter" id="filterSelect" class="form-select form-select-sm" onchange="filterByRole()">
									  <option value="all" ${filter == 'all' ? 'selected' : ''}>Tất cả</option>
									  <option value="admin" ${filter == 'admin' ? 'selected' : ''}>Admin</option>
									  <option value="cus" ${filter == 'cus' ? 'selected' : ''}>Khách hàng</option>
									  <option value="tam" ${filter == 'tam' ? 'selected' : ''}>Bị ẩn</option>
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
			
							<div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-3">
							    <form action="accounts" method="post" class="d-flex align-items-center gap-2 flex-grow-1">
							        <input type="hidden" name="action" value="addbysheet"/>
							        <label for="linkInput" class="form-label mb-0 flex-shrink-0">Thêm bằng link Sheet:</label>
							        <input type="text" id="linkInput" name="linksheet" placeholder="https://docs.google.com/spreadsheets/d/e/xxx/pub?output=csv" 
							        class="form-control form-control-sm flex-grow-1" style="min-width: 200px;" />
							        <button type="submit" class="btn btn-sm btn-primary">Thêm</button>
							    </form>
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
								                    <i class="bi bi-eye"></i>
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
								                    <i class="bi bi-pencil"></i>
								                </button>
								            	<c:choose>
								                    <c:when test="${acc.account_status == 1}">
										                <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModalTam"
										                    data-account-id="${acc.account_id}"
										                    data-account-username="${acc.account_username}">
										                    <i class="bi bi-trash"></i>
										                </button>
								                    </c:when>
								                    <c:when test="${acc.account_status == 0}">
								                    	<button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal"
										                    data-account-id="${acc.account_id}"
										                    data-account-username="${acc.account_username}">
										                    <i class="bi bi-exclamation-triangle-fill"></i>
										                </button>
										                <button class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModalKP"
										                    data-account-id="${acc.account_id}"
										                    data-account-username="${acc.account_username}">
										                    <i class="bi bi-arrow-counterclockwise"></i>
										                </button>
								                    </c:when>
								                </c:choose>
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

	<!-- Delete vinh vien Modal -->
	<div class="modal fade" id="deleteModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<form id="deleteForm3" action="accounts" method="post">
					<!-- Hidden field để truyền username hoặc id -->
					<input type="hidden" name="account_id" id="account_id_delete" /> <input type="hidden"
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
	
	<!-- Delete tam Modal -->
	<div class="modal fade" id="deleteModalTam" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<form id="deleteForm1" action="accounts" method="post">
					<!-- Hidden field để truyền username hoặc id -->
					<input type="hidden" name="account_id" id="account_id_tam" /> <input type="hidden"
						name="action" value="delete_tam" />
					<div class="modal-header">
						<h5 class="modal-title">Xác nhận xóa tạm thời tài khoản</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<p>Bạn có chắc chắn muốn xóa tạm thời tài khoản này?</p>
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
	
	<!-- Khoi phuc Modal -->
	<div class="modal fade" id="deleteModalKP" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<form id="deleteForm2" action="accounts" method="post">
					<!-- Hidden field để truyền username hoặc id -->
					<input type="hidden" name="account_id" id="account_id_kp" /> <input type="hidden"
						name="action" value="khoiphuc" />
					<div class="modal-header">
						<h5 class="modal-title">Xác nhận khôi phục tài khoản</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<p>Bạn có chắc chắn muốn khôi phục tài khoản này?</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Hủy</button>
						<button type="submit" class="btn btn-danger">Khôi phục</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<script>
		function filterByRole() {
			  const filterValue = document.getElementById("filterSelect").value;
	
			  fetch("accounts?filter=" + filterValue)
			    .then(response => response.text())
			    .then(html => {
			      document.open();
			      document.write(html);
			      document.close();
			    })
			    .catch(err => console.error(err));
			  document.getElementById("filterSelect").value = filterValue;
			}
	</script>

	<script type="text/javascript">
		document.addEventListener('DOMContentLoaded', function () {
		    // Modal Edit
		    document.getElementById('editModal')?.addEventListener('show.bs.modal', function (event) {
		        let button = event.relatedTarget;
		        this.querySelector('input[name="account_username"]').value = button.getAttribute('data-account-username');
		        this.querySelector('input[name="account_password"]').value = button.getAttribute('data-account-password');
		        this.querySelector('select[name="role_id"]').value = button.getAttribute('data-role-id');
		        this.querySelector('input[name="account_id"]').value = button.getAttribute('data-account-id');
		    });
	
		    // Modal View
		    document.getElementById('viewModal')?.addEventListener('show.bs.modal', function (event) {
		        let button = event.relatedTarget;
		        this.querySelector('.account_username').textContent = button.getAttribute('data-account-username');
		        this.querySelector('.account_password').textContent = button.getAttribute('data-account-password');
		        this.querySelector('.role_id').textContent = button.getAttribute('data-role-id');
		        this.querySelector('.account_created_at').textContent = button.getAttribute('data-account-created-at');
		        this.querySelector('.account_updated_at').textContent = button.getAttribute('data-account-updated-at');
		        this.querySelector('.account_login_time').textContent = button.getAttribute('data-account-login-time');
		        this.querySelector('.account_status').textContent = button.getAttribute('data-account-status');
		    });
	
		    // Xóa vĩnh viễn
		    document.getElementById('deleteModal')?.addEventListener('show.bs.modal', function (event) {
		        this.querySelector('#account_id_delete').value = event.relatedTarget.getAttribute('data-account-id');
		    });
	
		    // Xóa tạm thời
		    document.getElementById('deleteModalTam')?.addEventListener('show.bs.modal', function (event) {
		        this.querySelector('#account_id_tam').value = event.relatedTarget.getAttribute('data-account-id');
		    });
	
		    // Khôi phục
		    document.getElementById('deleteModalKP')?.addEventListener('show.bs.modal', function (event) {
		        this.querySelector('#account_id_kp').value = event.relatedTarget.getAttribute('data-account-id');
		    });
		});			
	</script>
<%@include file="/adjsp/lib/footer.jsp"%>
</html>

