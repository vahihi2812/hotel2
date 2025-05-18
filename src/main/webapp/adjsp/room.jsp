<%@page import="model.room"%>
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
	<%@include file="/adjsp/lib/header.jsp"%>
	<%@include file="/adjsp/lib/sidebar.jsp"%>
<body>
	<%
		ArrayList<room> list = (ArrayList<room>) request.getAttribute("list_room_all");
	%>
			
	<main id="main" class="main">
		
		<div class="pagetitle">
			<h1>Quản lý phòng</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/home">Trang chủ</a></li>
					<li class="breadcrumb-item active">Quản lý phòng</li>
				</ol>
			</nav>
		</div>

		<section class="section">
		    <div class="row">
		        <div class="col-lg-12">
		            <div class="card">
		                <div class="card-body">
		                	<div class="d-flex justify-content-between align-items-center mt-0">
		                        <div class="d-flex align-items-center gap-2">
		                            <h5 class="card-title mb-0">Danh sách phòng</h5>
		                        </div>
		                    </div>
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
		
		                    <!-- Table with stripped rows -->
		                    <table class="table datatable">
		                        <thead>
		                            <tr>
		                                <th><b>S</b>TT</th>
		                                <th>Phòng</th>
		                                <th>Tầng</th>
		                                <th>Loại phòng</th>
		                                <th>Trạng thái</th>
		                                <th>Chức năng</th>
		                            </tr>
		                        </thead>
		                        <tbody>
		                            <c:forEach var="r" items="${list_room_all}" varStatus="loop">
		                                <tr>
		                                    <td>${loop.index + 1}</td>
		                                    <td>${r.room_name}</td>
		                                    <td>${r.floor_id}</td>
		                                    <td>
		                                        <c:choose>
		                                            <c:when test="${r.rt_id == 1}">Bình dân</c:when>
		                                            <c:when test="${r.rt_id == 2}">Cao cấp</c:when>
		                                            <c:otherwise>Khác</c:otherwise>
		                                        </c:choose>
		                                    </td>
		                                    <td>
		                                        <c:choose>
		                                            <c:when test="${r.rs_id == 1}"><p class="text-success">Đang trống</p></c:when>
		                                            <c:when test="${r.rs_id == 2}"><p class="text-danger">Đang được đặt</p></c:when>
		                                            <c:when test="${r.rs_id == 3}"><p class="text-warning">Đang bảo trì</p></c:when>
		                                            <c:otherwise>Khác</c:otherwise>
		                                        </c:choose>
		                                    </td>
		                                    <td>
		                                        <button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#viewModal"
		                                            data-room-id="${r.room_id}"
		                                            data-room-name="${r.room_name}"
		                                            data-room-description="${r.room_description}"
		                                            data-room-booking-time="${r.room_booking_time}"
		                                            data-room-view="${r.room_view}"
		                                            data-room-floor-id="${r.floor_id}"
		                                            data-room-rt-id="${r.rt_id}"
		                                            data-room-rs-id="${r.rs_id}">
		                                            <i class="bi bi-eye"></i>
		                                        </button>
		
		                                        <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editModal"
		                                            data-room-id="${r.room_id}"
		                                            data-room-name="${r.room_name}"
		                                            data-room-description="${r.room_description}"
		                                            data-room-booking-time="${r.room_booking_time}"
		                                            data-room-view="${r.room_view}"
		                                            data-room-floor-id="${r.floor_id}"
		                                            data-room-rt-id="${r.rt_id}"
		                                            data-room-rs-id="${r.rs_id}">
		                                            <i class="bi bi-pencil"></i>
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

	<!-- View Modal -->
	<div class="modal fade" id="viewModal" tabindex="-1">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title">Chi tiết phòng</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	            </div>
	            <div class="modal-body">
	                <div class="mb-3">
	                    <strong>Tên phòng: </strong>
	                    <p class="room_name"></p>
	                </div>	                
	                <div class="mb-3">
	                    <strong>Mô tả: </strong>
	                    <p class="room_description"></p>
	                </div>
	                <div class="mb-3">
	                    <strong>Số lần đặt: </strong>
	                    <p class="room_booking_time"></p>
	                </div>
	                <div class="mb-3">
	                    <strong>View: </strong>
	                    <p class="room_view"></p>
	                </div>
	                <div class="mb-3">
	                    <strong>Tầng: </strong>
	                    <p class="room_floor_id"></p>
	                </div>
	                <div class="mb-3">
	                    <strong>Loại phòng: </strong>
	                    <p class="room_rt_id"></p>
	                </div>
	                <div class="mb-3">
	                    <strong>Trạng thái: </strong>
	                    <p class="room_rs_id"></p>
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
					<form id="editForm" action="rooms" method="post">
						<input type="hidden" name="room_id" />
						<input type="hidden" name="action" value="edit" />
	
						<div class="mb-3">
							<label class="form-label">Tên phòng</label>
							<input type="text" class="form-control" name="room_name" required disabled/>
						</div>
						
						<div class="mb-3">
							<label class="form-label">Mô tả</label>
							<textarea class="form-control" name="room_description" required></textarea>
						</div>
						
						<div class="mb-3">
							<label class="form-label">Số lần đặt</label>
							<input type="text" class="form-control" name="room_booking_time" required disabled/>
						</div>
						
						<div class="mb-3">
							<label class="form-label">View</label>
							<input type="text" class="form-control" name="room_view" required/>
						</div>
						
						<div class="mb-3">
							<label class="form-label">Tầng</label>
							<input type="text" class="form-control" name="floor_id" required disabled/>
						</div>
						
						<div class="mb-3">
							<label class="form-label">Loại phòng</label> <select
								class="form-select" name="rt_id" required>
								<option value="1">Bình dân</option>
								<option value="2">Cao cấp</option>
							</select>
						</div>
						
						<div class="mb-3">
							<label class="form-label">Trạng thái</label> <select
								class="form-select" name="rs_id" required>
								<option value="1">Đang trống</option>
								<option value="2">Đang được đặt</option>
								<option value="3">Đang bảo trì</option>
							</select>
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

	<script type="text/javascript">
		var editModal = document.getElementById('editModal');
		editModal.addEventListener('show.bs.modal', function(event) {
	    var button = event.relatedTarget;

	    var room_id = button.getAttribute('data-room-id');
	    var room_name = button.getAttribute('data-room-name');
	    var room_description = button.getAttribute('data-room-description');
	    var room_booking_time = button.getAttribute('data-room-booking-time');
	    var room_view = button.getAttribute('data-room-view');
	    var room_floor_id = button.getAttribute('data-room-floor-id');
	    var room_rt_id = button.getAttribute('data-room-rt-id');
	    var room_rs_id = button.getAttribute('data-room-rs-id');


	    var modal = this;
	    modal.querySelector('input[name="room_id"]').value = room_id;
	    modal.querySelector('input[name="room_name"]').value = room_name;
	    modal.querySelector('textarea[name="room_description"]').value = room_description;
	    modal.querySelector('input[name="room_booking_time"]').value = room_booking_time;
	    modal.querySelector('input[name="room_view"]').value = room_view;
	    modal.querySelector('input[name="floor_id"]').value = room_floor_id;
	    modal.querySelector('select[name="rt_id"]').value = room_rt_id;
	    modal.querySelector('select[name="rs_id"]').value = room_rs_id;
	});


		const viewModal = document.getElementById('viewModal');
		viewModal.addEventListener('show.bs.modal', function(event) {
		    const button = event.relatedTarget;

		    // Cập nhật thông tin cho các phần tử trong modal
		    viewModal.querySelector('.room_name').textContent = button.getAttribute('room_name');
		    viewModal.querySelector('.room_description').textContent = button.getAttribute('data-room-description');
		    viewModal.querySelector('.room_booking_time').textContent = button.getAttribute('data-room-booking-time');
		    viewModal.querySelector('.room_view').textContent = button.getAttribute('data-room-view');
		    viewModal.querySelector('.room_floor_id').textContent = button.getAttribute('data-room-floor-id');

		    const rtMap = {
		    	    '1': 'Bình dân',
		    	    '2': 'Cao cấp'
		    	};

		    	const rsMap = {
		    	    '1': 'Đang trống',
		    	    '2': 'Đang được đặt',
		    	    '3': 'Đang bảo trì'
		    	};

		    	const rtId = button.getAttribute('data-room-rt-id');
		    	const rsId = button.getAttribute('data-room-rs-id');

		    	viewModal.querySelector('.room_rt_id').textContent = rtMap[rtId] || 'Không xác định';
		    	viewModal.querySelector('.room_rs_id').textContent = rsMap[rsId] || 'Không xác định';
		    			    
			});
	</script>

</body>
<%@include file="/adjsp/lib/footer.jsp"%>
</html>
