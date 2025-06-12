<%@page import="model.account"%>
<%@page import="dao.userDAO"%>
<%@page import="model.user"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

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
		<link
			href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
			rel="stylesheet">
		
		<!-- Vendor CSS Files -->
		<link href="advendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
		<link href="advendor/bootstrap-icons/bootstrap-icons.css"
			rel="stylesheet">
		<link href="advendor/simple-datatables/style.css" rel="stylesheet">
		
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-growl/1.0.0/jquery.bootstrap-growl.min.js"></script>
		
		<!-- Template Main CSS File -->
		<link href="adcss/style.css" rel="stylesheet">
	
	</head>

<body>
	<%@include file="/adjsp/chat.jsp"%>	
		<%
		user u = (user) session.getAttribute("user");
		account acc = (account) session.getAttribute("account");
		
		if (acc == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		if (acc.getRole_id() != 1) {
			response.sendRedirect(request.getContextPath() + "/trangchu");
			return;
		}
		%>
		
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
			
		<!-- ======= Header ======= -->
		<header id="header" class="header fixed-top d-flex align-items-center">
	
			<div class="d-flex align-items-center justify-content-between">
				<a href="<%=request.getContextPath()%>/home"
					class="logo d-flex align-items-center"> <img
					src="adimg/logo.png" alt=""> <span class="d-none d-lg-block">Quản lý</span>
				</a> <i class="bi bi-list toggle-sidebar-btn"></i>
			</div>
			<!-- End Logo -->
	
			<nav class="header-nav ms-auto">
				<ul class="d-flex align-items-center">
	
					<!-- Profile Dropdown -->
					<li class="nav-item dropdown pe-3"><a
						class="nav-link nav-profile d-flex align-items-center pe-0"
						href="#" data-bs-toggle="dropdown"> <img
							src="adimg/profile-img.jpg" alt="Profile" class="rounded-circle">
							<span class="d-none d-md-block dropdown-toggle ps-2">Chào, <%=u.getUser_fullname()%></span>
					</a>
	
						<ul
							class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
							<li class="dropdown-header">
								<h6>Người quản trị</h6>
							</li>
							<li><hr class="dropdown-divider"></li>
	
							<li><a class="dropdown-item d-flex align-items-center"
								href="<%=request.getContextPath()%>/profile"> <i
									class="bi bi-person"></i> <span>Thông tin cá nhân</span>
							</a></li>
	
							<li><hr class="dropdown-divider"></li>
	
							<li><a class="dropdown-item d-flex align-items-center"
								href="<%=request.getContextPath()%>/profile"> <i
									class="bi bi-gear"></i> <span>Cài đặt tài khoản</span>
							</a></li>
	
							<li><hr class="dropdown-divider"></li>
	
							<li><a class="dropdown-item d-flex align-items-center"
								href="logout"> <i class="bi bi-box-arrow-right"></i> <span>Đăng xuất</span>
							</a></li>
						</ul> <!-- End Profile Dropdown Items --></li>
					<!-- End Profile Nav -->
	
				</ul>
			</nav>
			<!-- End Icons Navigation -->
	
		</header>
		<!-- End Header -->

<!-- </html> -->
