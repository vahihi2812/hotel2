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
			
	<main id="main" class="main">
		
		<div class="pagetitle">
			<h1>Quản lý loại phòng</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/home">Trang chủ</a></li>
					<li class="breadcrumb-item active">Quản lý loại phòng</li>
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
		                            <h5 class="card-title mb-0">Danh sách loại phòng</h5>
		                        </div>
		                    </div>
		                    <!-- Table with stripped rows -->
		                    <table class="table datatable">
		                        <thead>
		                            <tr>
		                                <th><b>S</b>TT</th>
		                                <th>Loại phòng</th>
		                                <th>Giá</th>
		                                <th>Số lượng người</th>
		                                <th>Mô tả</th>
		                                <th>Chức năng</th>
		                            </tr>
		                        </thead>
		                        <tbody>
		                            <c:forEach var="rt" items="${list_room_type_all}" varStatus="loop">
		                                <tr>
		                                    <td>${loop.index + 1}</td>
		                                    <td>${rt.rt_name}</td>
		                                    <td>${rt.rt_price}</td>
		                                    <td>${rt.rt_max_occupancy}</td>
		                                    <td>${rt.rt_description}</td>
		                                    <td>
		                                        <button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#viewModal"
		                                            data-rt-id="${rt.rt_id}"
		                                            data-rt-name="${rt.rt_name}"
		                                            data-rt-description="${rt.rt_description}"
		                                            data-rt-price="${rt.rt_price}"
		                                            data-rt-max-occupancy="${rt.rt_max_occupancy}"
		                                            data-rt-is-smoking-allowed="${rt.rt_is_smoking_allowed}">
		                                            Xem
		                                        </button>
		
		                                        <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editModal"
		                                          	data-rt-id="${rt.rt_id}"
		                                            data-rt-name="${rt.rt_name}"
		                                            data-rt-description="${rt.rt_description}"
		                                            data-rt-price="${rt.rt_price}"
		                                            data-rt-max-occupancy="${rt.rt_max_occupancy}"
		                                            data-rt-is-smoking-allowed="${rt.rt_is_smoking_allowed}">
		                                            Sửa
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
	                <h5 class="modal-title">Chi tiết loại phòng</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	            </div>
	            <div class="modal-body">
	                <div class="mb-3">
	                    <strong>Tên loại: </strong>
	                    <p class="rt_name"></p>
	                </div>	                
	                <div class="mb-3">
	                    <strong>Mô tả: </strong>
	                    <p class="rt_description"></p>
	                </div>
	                <div class="mb-3">
	                    <strong>Giá: </strong>
	                    <p class="rt_price"></p>
	                </div>
	                <div class="mb-3">
	                    <strong>Số lượng: </strong>
	                    <p class="rt_max_occupancy"></p>
	                </div>
	                <div class="mb-3">
	                    <strong>Cho phép hút thuốc:</strong>
	                    <p class="rt_is_smoking_allowed"></p>
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
					<h5 class="modal-title">Chỉnh sửa loại phòng</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<form id="editForm" action="room_type" method="post">
						<input type="hidden" name="rt_id" />
						<input type="hidden" name="action" value="edit" />
	
						<div class="mb-3">
							<label class="form-label">Tên loại phòng</label>
							<input type="text" class="form-control" name="rt_name" required/>
						</div>
						
						<div class="mb-3">
							<label class="form-label">Mô tả</label>
							<textarea class="form-control" name="rt_description" required></textarea>
						</div>	
						
						<div class="mb-3">
							<label class="form-label">Giá</label>
							<input type="text" class="form-control" name="rt_price" required/>
						</div>
						
						<div class="mb-3">
							<label class="form-label">Số lượng</label>
							<input type="text" class="form-control" name="rt_max_occupancy" required/>
						</div>
						
						<div class="mb-3">
							<label class="form-label">Cho phép hút thuốc?</label>
							<select class="form-select" name="rt_is_smoking_allowed">
								<option value="0">Không</option>
								<option value="1">Có</option>
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

	    var rt_id = button.getAttribute('data-rt-id');
	    var rt_name = button.getAttribute('data-rt-name');
	    var rt_description = button.getAttribute('data-rt-description');
	    var rt_price = button.getAttribute('data-rt-price');
	    var rt_max_occupancy = button.getAttribute('data-rt-max-occupancy');
	    var rt_is_smoking_allowed = button.getAttribute('data-rt-is-smoking-allowed');


	    var modal = this;
	    modal.querySelector('input[name="rt_id"]').value = rt_id;
	    modal.querySelector('input[name="rt_name"]').value = rt_name;
	    modal.querySelector('textarea[name="rt_description"]').value = rt_description;
	    modal.querySelector('input[name="rt_price"]').value = rt_price;
	    modal.querySelector('input[name="rt_max_occupancy"]').value = rt_max_occupancy;
	    modal.querySelector('select[name="rt_is_smoking_allowed"]').value = rt_is_smoking_allowed;
	});


		const viewModal = document.getElementById('viewModal');
		viewModal.addEventListener('show.bs.modal', function(event) {
		    const button = event.relatedTarget;

		    // Cập nhật thông tin cho các phần tử trong modal
		    viewModal.querySelector('.rt_name').textContent = button.getAttribute('data-rt-name');
		    viewModal.querySelector('.rt_description').textContent = button.getAttribute('data-rt-description');
		    viewModal.querySelector('.rt_price').textContent = button.getAttribute('data-rt-price');	
		    viewModal.querySelector('.rt_max_occupancy').textContent = button.getAttribute('data-rt-max-occupancy');
		    const smk = {
		    	    '0': 'Không',
		    	    '1': 'Có'
		    	};

		    	const smk_id = button.getAttribute('data-rt-is-smoking-allowed');

		    	viewModal.querySelector('.rt_is_smoking_allowed').textContent = smk[smk_id] || 'Không xác định';
		    			    
			});			    			    
			});
	</script>

</body>
<%@include file="/adjsp/lib/footer.jsp"%>
</html>
