<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
		<title>Thu Cúc Hotel</title>
		<meta content="" name="description">
		<meta content="" name="keywords">
	
		<!-- Favicons -->
		<link href="adimg/favicon.png" rel="icon">
		<link href="adimg/apple-touch-icon.png" rel="apple-touch-icon">
		
		<!-- Google Fonts -->
		<link href="https://fonts.gstatic.com" rel="preconnect">
		<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
			rel="stylesheet">
	
		<!-- Vendor CSS Files -->
		<link href="advendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
		<link href="advendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
	
		<!-- Template Main CSS File -->
		<link href="adcss/style.css" rel="stylesheet">
		
		<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-growl/1.0.0/jquery.bootstrap-growl.min.js"></script>
	</head>
<body>
  	<%
		String message = request.getParameter("message");
		if (message != null) {
		%>
		<script>
			$(document).ready(function() {
		<%if ("success".equals(message)) {%>
			$.bootstrapGrowl("Thao tác thành công!", {
					type : "success",
					offset : {
						from : "top",
						amount : 50
					},
					align : "right",
					delay : 3000,
					allow_dismiss : true,
					stackup_spacing : 10
				});
		<%} else if ("fail".equals(message)) {%>
			$.bootstrapGrowl("Thao tác thất bại!", {
					type : "danger",
					offset : {
						from : "top",
						amount : 50
					},
					align : "right",
					delay : 3000,
					allow_dismiss : true,
					stackup_spacing : 10
				});
		<%}%>
 			});
		</script>
		<%
 		}
 		%>	 	
  <main>
    <div class="container">

      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
          <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

              <div class="d-flex justify-content-center py-4">
                <a href="index.html" class="logo d-flex align-items-center w-auto">
                  <img src="adimg/logo.png" alt="">
                  <span class="d-none d-lg-block">Khách hàng</span>
                </a>
              </div><!-- End Logo -->

              <div class="card mb-3">

                <div class="card-body">

                  <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4">Tạo tài khoản</h5>
                    <p class="text-center small">Trải nghiệm dịch vụ đặt phòng tiện nghi nhất</p>
                  </div>

                  <form class="row g-3 needs-validation" action="register" method="POST" novalidate>
                  	<input type="hidden" name="action" value="reg" />
                  	
                  	<c:if test="${not empty error}">
                      <div class="alert alert-danger text-center">${error}</div>
                    </c:if>
                    <c:if test="${not empty noti}">
                      <div class="alert alert-success text-center">${noti}</div>
                    </c:if>
                    
                    
                    <div class="col-12">
                      <label for="yourUsername" class="form-label">Tên đăng nhập</label>
                      <div class="input-group has-validation">
                        <span class="input-group-text" id="inputGroupPrepend">@</span>
                        <input type="text" name="username" class="form-control" id="yourUsername" required>
                        <div class="invalid-feedback">Hãy nhập tên đăng nhập hợp lệ</div>
                      </div>
                    </div>

                    <div class="col-12">
                      <label for="yourPassword" class="form-label">Mật khẩu</label>
                      <input type="password" name="password" class="form-control" id="yourPassword" required>
                      <div class="invalid-feedback">Hãy nhập mật khẩu hợp lệ</div>
                    </div>

                    <div class="col-12">
                      <div class="form-check">
                        <input class="form-check-input" name="terms" type="checkbox" value="" id="acceptTerms" required>
                        <label class="form-check-label" for="acceptTerms">Tôi đồng ý với<a href="https://byvn.net/897b"> điều khoản dịch vụ</a></label>
                        <div class="invalid-feedback">Bạn cần xác nhận đồng ý</div>
                      </div>
                    </div>
                    <div class="col-12">
                      <button class="btn btn-primary w-100" type="submit">Đăng kí</button>
                    </div>
                    <div class="col-12">
                      <p class="small mb-0">Đã có tài khoản? <a href="<%=request.getContextPath()%>/login">Đăng nhập</a></p>
                    </div>
                  </form>

                </div>
              </div>
            </div>
          </div>
        </div>

      </section>

    </div>
  </main><!-- End #main -->
</body>
	<!-- Vendor JS Files -->
	<script src="advendor/apexcharts/apexcharts.min.js"></script>
	<script src="advendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="advendor/chart.js/chart.umd.js"></script>
	<script src="advendor/echarts/echarts.min.js"></script>
	<script src="advendor/simple-datatables/simple-datatables.js"></script>
	<script src="advendor/tinymce/tinymce.min.js"></script>
	
	<!-- Template Main JS File -->
	<script src="adjs/main.js"></script>
	<script src="adjs/validate-register.js"></script>
</html>