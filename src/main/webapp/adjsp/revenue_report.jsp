<%@page import="model.revenue_report"%>
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
	<%! 
		public String formatDateId(String id) {
		    if (id == null || id.length() < 4) return "ID không hợp lệ";
		
		    try {
		        if (id.length() == 4) {   //20250517
		            // Năm
		            return "Năm " + id;
		        } else if (id.length() == 6) {
		            // Tháng + Năm (yyyyMM)
		            String year = id.substring(0, 4);
		            String month = id.substring(4, 6);
		            return "Tháng " + Integer.parseInt(month) + "/" + year;
		        } else if (id.length() == 8) {
		            // Ngày + Tháng + Năm (yyyyMMdd)
		            String year = id.substring(0, 4);
		            String month = id.substring(4, 6);
		            String day = id.substring(6, 8);
		            return Integer.parseInt(day) + "/" + Integer.parseInt(month) + "/" + year;
		        } else {
		            return "Định dạng ID không hỗ trợ";
		        }
		    } catch (Exception e) {
		        return "Lỗi định dạng ID";
		    }
		}
	%>
		
	<%ArrayList<revenue_report> list = (ArrayList<revenue_report>)request.getAttribute("list");%>
		
	<main id="main" class="main">
		
		<div class="pagetitle">
			<h1>Thống kê doanh thu</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/home">Trang chủ</a></li>
					<li class="breadcrumb-item active">Thống kê doanh thu</li>
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
		                            <h5 class="card-title mb-0">Thống kê doanh thu</h5>
		                        </div>
		                    </div>
		                    
		                    <!-- Form lọc -->
								<form action="revenue_report" method="get" class="mb-4 p-3 border rounded shadow-sm bg-light">
									<input type="hidden" name="action" value="ana"/>
								    <div class="row g-4 align-items-end">
								        <!-- Thống kê theo -->
								        <div class="col-md-3">
								            <label class="form-label fw-semibold">
								                <i class="bi bi-filter-circle me-1"></i>Thống kê theo
								            </label>
								            <select name="d" class="form-select">
								                <option value="day">Ngày</option>
								                <option value="month">Tháng</option>
								                <option value="year">Năm</option>
								            </select>
								        </div>
								
								        <!-- Từ -->
								        <div class="col-md-3">
								            <label class="form-label fw-semibold">
								                <i class="bi bi-calendar-date me-1"></i>Từ ngày
								            </label>
								            <input type="date" name="s" class="form-control" />
								        </div>
								
								        <!-- Đến -->
								        <div class="col-md-3">
								            <label class="form-label fw-semibold">
								                <i class="bi bi-calendar2-check me-1"></i>Đến ngày
								            </label>
								            <input type="date" name="e" class="form-control" />
								        </div>
								
								        <!-- Nút thống kê -->
								        <div class="col-md-3 text-center">
								            <button type="submit" class="btn btn-primary w-100">
								                <i class="bi bi-graph-up-arrow me-1"></i>Thống kê
								            </button>
								        </div>
								    </div>
								</form>
								<!-- End form -->
		
		                    <!-- Table with stripped rows -->
		                    <table class="table datatable">
		                        <thead>
		                            <tr>
		                                <th><b>S</b>TT</th>
		                                <th>Thời gian</th>
		                                <th>Doanh thu</th>
		                            </tr>
		                        </thead>
		                        <tbody>
									<%
									    for (int i = 0; i < list.size(); i++) {
									       	revenue_report rr = list.get(i);  // Giả sử list là List<BookingReport>
									%>
									    <tr>
									        <td><%= i + 1 %></td>
									        <td><%= formatDateId(String.valueOf(rr.getRr_id()))%></td>
									        <td><%=rr.getRr_amount() %></td>
									    </tr>
									<%
									    }
									%>
		                        </tbody>
		                    </table>
		                    <!-- End Table with stripped rows -->

							<form action="revenue_report" method="post" class="mb-2 p-3">
								<input type="hidden" name="action" value="savepdf" />
								<div class="row">
									<div class="col-12 text-end">
										<button type="submit" class="btn btn-success">
											<i class="bi bi-file-earmark-arrow-down me-1"></i>Xuất báo
											cáo
										</button>
									</div>
								</div>
							</form>
							
						</div>
		            </div>
		        </div>
		    </div>
		</section>

	</main>
</body>
<script src="adjs/date-filter-validate.js"></script>
<%@include file="/adjsp/lib/footer.jsp"%>
</html>
