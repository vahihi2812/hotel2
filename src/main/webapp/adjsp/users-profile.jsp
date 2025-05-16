<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<!DOCTYPE html>
<html lang="vi">
<head>
	<meta charset="utf-8">
</head> 	
	<%@include file="/adjsp/lib/header.jsp"%>
	<%@include file="/adjsp/lib/sidebar.jsp"%>
<body>

  <main id="main" class="main">
  
    <div class="pagetitle">
      <h1>Profile</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">Home</a></li>
          <li class="breadcrumb-item">Users</li>
          <li class="breadcrumb-item active">Profile</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section profile">
      <div class="row">
        <div class="col-xl-12">

          <div class="card">
            <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">

              <img src="adimg/profile-img.jpg" alt="Profile" class="rounded-circle">
              <h2><%=u.getUser_fullname()%></h2>
              <h3>Người quản trị</h3>
            </div>
          </div>

          <div class="card">
            <div class="card-body pt-3">
              <!-- Bordered Tabs -->
              <ul class="nav nav-tabs nav-tabs-bordered">

                <li class="nav-item">
                  <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#profile-overview">Tổng quan</button>
                </li>

                <li class="nav-item">
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">Cập nhật thông tin</button>
                </li>

                <li class="nav-item">
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password">Đổi mật khẩu</button>
                </li>

              </ul>
              <div class="tab-content pt-2">

                <div class="tab-pane fade show active profile-overview" id="profile-overview">
	                  <h5 class="card-title">Mô tả</h5>
	                  <p class="small fst-italic">Người quản trị hệ thống Webiste thucuchotel.com. Quản lý hoạt động kinh doanh của khách sạn Thu Cúc toàn diện</p>
	
	                  <h5 class="card-title">Thông tin chi tiết</h5>
	
							<div class="row">
							  <div class="col-lg-3 col-md-4 label">Họ tên</div>
							  <div class="col-lg-9 col-md-8"><%= u.getUser_fullname() %></div>
							</div>
							
							<%
							  String birthValue = "Trống";
							  if (u.getUser_date_of_birth() != null) {
							    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd-MM-yyyy");
							    birthValue = sdf.format(u.getUser_date_of_birth());
							  }
							%>
							<div class="row">
							  <div class="col-lg-3 col-md-4 label">Ngày sinh</div>
							  <div class="col-lg-9 col-md-8"><%= birthValue %></div>
							</div>
							
							<%
							  String genderStr = "Không xác định";
							  if (u.getUser_gender() == 0) {
							    genderStr = "Nam";
							  } else if (u.getUser_gender() == 1) {
							    genderStr = "Nữ";
							  }
							%>
							<div class="row">
							  <div class="col-lg-3 col-md-4 label">Giới tính</div>
							  <div class="col-lg-9 col-md-8"><%= genderStr %></div>
							</div>
							
							<div class="row">
							  <div class="col-lg-3 col-md-4 label">Số điện thoại</div>
							  <div class="col-lg-9 col-md-8"><%= u.getUser_phone_number() %></div>
							</div>
							
							<div class="row">
							  <div class="col-lg-3 col-md-4 label">Email</div>
							  <div class="col-lg-9 col-md-8"><%= u.getUser_email() %></div>
							</div>
							
							<div class="row">
							  <div class="col-lg-3 col-md-4 label">Địa chỉ</div>
							  <div class="col-lg-9 col-md-8"><%= u.getUser_address() %></div>
							</div>

                </div>

                <div class="tab-pane fade profile-edit pt-3" id="profile-edit">

                  <!-- Profile Edit Form -->
                  <form action="profile" method="post">                  	
                  	<input type="hidden" name="action" value="u_inf"/>
                  	
                    <div class="row mb-3">
                      <label for="profileImage" class="col-md-4 col-lg-3 col-form-label">Ảnh</label>
                      <div class="col-md-8 col-lg-9">
                        <img src="adimg/profile-img.jpg" alt="Profile">
                        <div class="pt-2">
                          <a href="#" class="btn btn-primary btn-sm" title="Upload new profile image"><i class="bi bi-upload"></i></a>
                          <a href="#" class="btn btn-danger btn-sm" title="Remove my profile image"><i class="bi bi-trash"></i></a>
                        </div>
                      </div>
                    </div>

                    <div class="row mb-3">
					  <label for="user_fullname" class="col-md-4 col-lg-3 col-form-label">Họ tên</label>
					  <div class="col-md-8 col-lg-9">
					    <input name="user_fullname" type="text" class="form-control" id="user_fullname" value="<%= u.getUser_fullname() %>">
					  </div>
					</div>
					
					<%
					  String birthValue1 = "";
					  if (u.getUser_date_of_birth() != null) {
					    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
					    birthValue1 = sdf.format(u.getUser_date_of_birth());
					  }
					%>
					<div class="row mb-3">
					  <label for="user_date_of_birth" class="col-md-4 col-lg-3 col-form-label">Ngày sinh</label>
					  <div class="col-md-8 col-lg-9">
					    <input name="user_date_of_birth" type="date" class="form-control" id="user_date_of_birth" value="<%= birthValue1 %>">
					  </div>
					</div>
					
					<div class="row mb-3">
					  <label for="user_address" class="col-md-4 col-lg-3 col-form-label">Địa chỉ</label>
					  <div class="col-md-8 col-lg-9">
					    <input name="user_address" type="text" class="form-control" id="user_address" value="<%= u.getUser_address() %>">
					  </div>
					</div>
					
					<div class="row mb-3">
					  <label for="user_gender" class="col-md-4 col-lg-3 col-form-label">Giới tính</label>
					  <div class="col-md-8 col-lg-9">
					    <select name="user_gender" class="form-control" id="user_gender">
					      <option value="0" <%= (u.getUser_gender() == 0) ? "selected" : "" %>>Nam</option>
					      <option value="1" <%= (u.getUser_gender() == 1) ? "selected" : "" %>>Nữ</option>
					    </select>
					  </div>
					</div>
					
					<div class="row mb-3">
					  <label for="user_phone_number" class="col-md-4 col-lg-3 col-form-label">SĐT</label>
					  <div class="col-md-8 col-lg-9">
					    <input name="user_phone_number" type="text" class="form-control" id="user_phone_number" value="<%= u.getUser_phone_number() %>">
					  </div>
					</div>
					
					<div class="row mb-3">
					  <label for="user_email" class="col-md-4 col-lg-3 col-form-label">Email</label>
					  <div class="col-md-8 col-lg-9">
					    <input name="user_email" type="email" class="form-control" id="user_email" value="<%= u.getUser_email() %>">
					  </div>
					</div>


                    <div class="text-center">
                      <button type="submit" class="btn btn-primary">Lưu</button>
                    </div>
                  </form><!-- End Profile Edit Form -->

                </div>

                <div class="tab-pane fade pt-3" id="profile-change-password">
                  <!-- Change Password Form -->
                  <form action="profile" method="post">
					<input type="hidden" name="action" value="u_pw" />
                    
                    <div class="row mb-3">
                      <label for="currentPassword" class="col-md-4 col-lg-3 col-form-label">Mật khẩu cũ</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="password" type="password" class="form-control" id="currentPassword">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="newPassword" class="col-md-4 col-lg-3 col-form-label">Mật khẩu mới</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="newPassword" type="password" class="form-control" id="newPassword">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="renewPassword" class="col-md-4 col-lg-3 col-form-label">Nhập lại mật khẩu</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="renewPassword" type="password" class="form-control" id="renewPassword">
                      </div>
                    </div>

                    <div class="text-center">
                      <button type="submit" class="btn btn-primary">Thay đổi</button>
                    </div>
                  </form><!-- End Change Password Form -->

                </div>

              </div><!-- End Bordered Tabs -->

            </div>
          </div>

        </div>
      </div>
    </section>

  </main><!-- End #main -->

<%@include file="/adjsp/lib/footer.jsp"%>
<script src="adjs/validate-profile.js"></script>
</body>

</html>