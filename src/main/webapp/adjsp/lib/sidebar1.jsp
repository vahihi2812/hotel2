<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

  <!-- ======= Sidebar ======= -->
  <aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

      <li class="nav-item">
        <a class="nav-link " href="<%=request.getContextPath()%>/trangchu">
          <i class="bi bi-house"></i>
          <span>Trang chủ</span>
        </a>
      </li><!-- End Dashboard Nav -->
      
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/phong">
          <i class="bi bi-person-vcard"></i>
          <span>Đặt phòng</span>
        </a>
      </li>
      
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/baocaoloi">
          <i class="bi bi-envelope-arrow-up"></i>
          <span>Gửi báo cáo</span>
        </a>
      </li>

    </ul>

  </aside><!-- End Sidebar-->