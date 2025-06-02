<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

  <!-- ======= Sidebar ======= -->
  <aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

      <li class="nav-item">
        <a class="nav-link " href="<%=request.getContextPath()%>/home">
          <i class="bi bi-house"></i>
          <span>Trang chủ</span>
        </a>
      </li><!-- End Dashboard Nav -->

      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/accounts">
          <i class="bi bi-person-vcard"></i>
          <span>Quản lý tài khoản</span>
        </a>
      </li>
      
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/customers">
          <i class="bi bi-people"></i>
          <span>Quản lý khách hàng</span>
        </a>
      </li>

      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#tables-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-tools"></i><span>Cơ sở vật chất</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="tables-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
        
              <li class="nav-item">
		        <a class="nav-link" href="<%=request.getContextPath()%>/floors">
		          <i class="bi bi-building"></i>
		          <span>Quản lý tầng</span>
		        </a>
		      </li>
		      
		      <li class="nav-item">
		        <a class="nav-link" href="<%=request.getContextPath()%>/room_type">
		          <i class="bi bi-building-gear"></i>
		          <span>Quản lý loại phòng</span>
		        </a>
		      </li>
		      
		      <li class="nav-item">
		        <a class="nav-link" href="<%=request.getContextPath()%>/rooms">
		          <i class="bi bi-wrench"></i>
		          <span>Quản lý phòng</span>
		        </a>
		      </li>
        </ul>
      </li><!-- End Tables Nav -->
      
      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#tke-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-bar-chart"></i><span>Thống kê</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="tke-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
        
              <li class="nav-item">
		        <a class="nav-link" href="<%=request.getContextPath()%>/booking_report">
		          <i class="bi bi-bell"></i>
		          <span>Lượt đặt phòng</span>
		        </a>
		      </li>
		      
		      <li class="nav-item">
		        <a class="nav-link" href="<%=request.getContextPath()%>/customer_report">
		          <i class="bi bi-people-fill"></i>
		          <span>Khách hàng</span>
		        </a>
		      </li>
		      
		      <li class="nav-item">
		        <a class="nav-link" href="<%=request.getContextPath()%>/revenue_report">
		          <i class="bi bi-currency-dollar"></i>
		          <span>Doanh thu</span>
		        </a>
		      </li>
        </ul>
      </li><!-- End Tables Nav -->

      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/booking">
          <i class="bi bi-table"></i>
          <span>Quản lý đặt phòng</span>
        </a>
      </li>
      
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/rpform">
          <i class="bi bi-envelope-arrow-up"></i>
          <span>Gửi báo cáo</span>
        </a>
      </li>

    </ul>

  </aside><!-- End Sidebar-->