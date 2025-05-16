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
          <i class="bi bi-layout-text-window-reverse"></i><span>Cơ sở vật chất</span><i class="bi bi-chevron-down ms-auto"></i>
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
		          <i class="bi bi-building"></i>
		          <span>Quản lý loại phòng</span>
		        </a>
		      </li>
		      
		      <li class="nav-item">
		        <a class="nav-link" href="<%=request.getContextPath()%>/rooms">
		          <i class="bi bi-building"></i>
		          <span>Quản lý phòng</span>
		        </a>
		      </li>
        </ul>
      </li><!-- End Tables Nav -->

      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/customers">
          <i class="bi bi-table"></i>
          <span>Quản lý đặt phòng</span>
        </a>
      </li>

    </ul>

  </aside><!-- End Sidebar-->