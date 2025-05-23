<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Pages / Not Found 404</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="adimg/favicon.png" rel="icon">
  <link href="adimg/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="advendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="advendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="advendor/boxicons/css/boxicons.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="adcss/style.css" rel="stylesheet">

</head>

<body>

  <main>
    <div class="container">

      <section class="section error-404 min-vh-100 d-flex flex-column align-items-center justify-content-center">
        <h1>404</h1>
        <h2>Trang bạn đang tìm kiếm không tồn tại</h2>
        <a class="btn" href="<%=request.getContextPath()%>/login">Quay lại trang chủ</a>
        <img src="adimg/not-found.svg" class="img-fluid py-5" alt="Page Not Found">
        <div class="credits">
        </div>
      </section>

    </div>
  </main><!-- End #main -->

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="advendor/apexcharts/apexcharts.min.js"></script>
  <script src="advendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="advendor/chart.js/chart.umd.js"></script>
  <script src="advendor/echarts/echarts.min.js"></script>

  <!-- Template Main JS File -->
  <script src="adjs/main.js"></script>

</body>

</html>