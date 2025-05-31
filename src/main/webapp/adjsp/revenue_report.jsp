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
	<%ArrayList<Integer> list_ty_le = (ArrayList<Integer>) request.getAttribute("list_tong_cong"); %>
		
	<main id="main" class="main">
	
	    <!-- Tiêu đề trang -->
	    <div class="pagetitle">
	        <h1>Thống kê doanh thu</h1>
	        <nav>
	            <ol class="breadcrumb">
	                <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/home">Trang chủ</a></li>
	                <li class="breadcrumb-item active">Thống kê doanh thu</li>
	            </ol>
	        </nav>
	    </div>
	
	    <!-- Nội dung chính -->
	    <section class="section">
	        <div class="row">
	            <div class="col-lg-12">
	
	                <div class="card">
	                    <div class="card-body p-4">
	
	                        <!-- Tiêu đề phụ -->
	                        <div class="d-flex justify-content-between align-items-center mb-3">
	                            <h5 class="card-title mb-0">
	                                <i class="bi bi-graph-up-arrow me-2"></i>Thống kê doanh thu
	                            </h5>
	                        </div>
	
	                        <!-- Form lọc thống kê -->
	                        <form action="revenue_report" method="get" class="p-3 border rounded shadow-sm bg-light">
	                            <input type="hidden" name="action" value="ana" />
	                            <div class="row g-4 align-items-end">
	
	                                <div class="col-md-3">
	                                    <label class="form-label fw-semibold">
	                                        <i class="bi bi-filter-circle me-1"></i>Thống kê theo
	                                    </label>
	                                    <select name="d" class="form-select">
	                                        <option value="day" ${d == 'day' ? 'selected' : ''}>Ngày</option>
	                                        <option value="month" ${d == 'month' ? 'selected' : ''}>Tháng</option>
	                                        <option value="year" ${d == 'year' ? 'selected' : ''}>Năm</option>
	                                    </select>
	                                </div>
	
	                                <div class="col-md-3">
	                                    <label class="form-label fw-semibold">
	                                        <i class="bi bi-calendar-date me-1"></i>Từ ngày
	                                    </label>
	                                    <input type="date" name="s" class="form-control" value="${s}"/>
	                                </div>
	
	                                <div class="col-md-3">
	                                    <label class="form-label fw-semibold">
	                                        <i class="bi bi-calendar2-check me-1"></i>Đến ngày
	                                    </label>
	                                    <input type="date" name="e" class="form-control" value="${e}"/>
	                                </div>
	
	                                <div class="col-md-3">
	                                    <button type="submit" class="btn btn-primary w-100">
	                                        <i class="bi bi-search me-1"></i>Thống kê
	                                    </button>
	                                </div>
	                            </div>
	                        </form>
	
	                        <script>
	                            const today = new Date().toISOString().split('T')[0];
	                            document.querySelectorAll('input[type="date"]').forEach(function(input) {
	                                input.max = today;
	                            });
	                        </script>
	
	                        <!-- Biểu đồ thống kê -->
	                        <h5 class="card-title">Biểu đồ doanh thu</h5>
	                        <canvas id="reportsChart" style="max-height: 400px;"></canvas>
	                        <h5 class="card-title">Tỉ lệ doanh thu</h5>
	                        <div id="trafficChart" style="min-height: 400px;" class="echart"></div>
	
	                        <!-- Bảng thống kê -->
	                        <div>
	                            <h5 class="card-title">Chi tiết theo thời gian</h5>
	                            <table class="table table-striped datatable">
	                                <thead>
	                                    <tr>
	                                        <th>STT</th>
	                                        <th>Thời gian</th>
	                                        <th>Phòng</th>
	                                        <th>Làm đẹp</th>
	                                        <th>Thể thao</th>
	                                        <th>Dịch vụ</th>
	                                        <th>Ăn uống</th>
	                                        <th>Tổng</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                    <%
	                                        for (int i = 0; i < list.size(); i++) {
	                                            revenue_report rr = list.get(i);
	                                    %>
	                                        <tr>
	                                            <td><%= i + 1 %></td>
	                                            <td><%= formatDateId(String.valueOf(rr.getRr_id())) %></td>
	                                            <td><%= rr.getRr_room() %></td>
	                                            <td><%= rr.getRr_spa() %></td>
	                                            <td><%= rr.getRr_sport() %></td>
	                                            <td><%= rr.getRr_service() %></td>
	                                            <td><%= rr.getRr_food() %></td>
	                                            <td><%= rr.getRr_amount() %></td>
	                                        </tr>
	                                    <%
	                                        }
	                                    %>
	                                </tbody>
	                            </table>
	                        </div>
	
	                        <!-- Nút hành động -->
	                        <div class="d-flex justify-content-between align-items-center mt-4">	
								<button onclick="savetopdf()" class="btn btn-success">
	                                    <i class="bi bi-file-earmark-arrow-down me-1"></i>Xuất báo cáo
	                            </button>
	
	                            <button onclick="sendChartImage()" class="btn btn-warning">
	                                <i class="bi bi-image me-1"></i>Lưu biểu đồ
	                            </button>
	                        </div>
	
	                    </div>
	                </div>
	
	            </div>
	        </div>
	    </section>
	</main>

</body>
	<!-- Script -->
	<script>
	  document.addEventListener("DOMContentLoaded", () => {
		  <%
			  StringBuilder labelsBuilder = new StringBuilder();
			  StringBuilder dataBkBuilder = new StringBuilder();
			  for (int i = 0; i < list.size(); i++) {
			    revenue_report rr = list.get(i);
			    String label = formatDateId(String.valueOf(rr.getRr_id()));
			    labelsBuilder.append("\"").append(label).append("\"");
			    dataBkBuilder.append(rr.getRr_amount());
			    if (i < list.size() - 1) {
			      labelsBuilder.append(",");
			      dataBkBuilder.append(",");
			    }
			  }
		%>
		
		const labels = [<%= labelsBuilder.toString() %>];
		const data_bk = [<%= dataBkBuilder.toString() %>];
	
	    const data = {
	      labels: labels,
	      datasets: [{
	        label: 'Doanh thu',
	        data: data_bk,
	        backgroundColor: [
	        	  'rgba(255, 99, 132, 0.2)',    // red
	        	  'rgba(255, 159, 64, 0.2)',    // orange
	        	  'rgba(255, 205, 86, 0.2)',    // yellow
	        	  'rgba(75, 192, 192, 0.2)',    // teal
	        	  'rgba(54, 162, 235, 0.2)',    // blue
	        	  'rgba(153, 102, 255, 0.2)',   // purple
	        	  'rgba(201, 203, 207, 0.2)',   // grey
	        	  'rgba(255, 99, 255, 0.2)',    // pink
	        	  'rgba(0, 255, 127, 0.2)',     // spring green
	        	  'rgba(255, 140, 0, 0.2)',     // dark orange
	        	  'rgba(64, 224, 208, 0.2)',    // turquoise
	        	  'rgba(128, 0, 128, 0.2)',     // indigo
	        	  'rgba(210, 105, 30, 0.2)',    // chocolate
	        	  'rgba(70, 130, 180, 0.2)',    // steel blue
	        	  'rgba(46, 139, 87, 0.2)',     // sea green
	        	  'rgba(255, 20, 147, 0.2)',    // deep pink
	        	  'rgba(255, 215, 0, 0.2)',     // gold
	        	  'rgba(123, 104, 238, 0.2)',   // medium slate blue
	        	  'rgba(0, 191, 255, 0.2)',     // deep sky blue
	        	  'rgba(244, 164, 96, 0.2)'     // sandy brown
	        	],
	        	borderColor: [
	        	  'rgb(255, 99, 132)',
	        	  'rgb(255, 159, 64)',
	        	  'rgb(255, 205, 86)',
	        	  'rgb(75, 192, 192)',
	        	  'rgb(54, 162, 235)',
	        	  'rgb(153, 102, 255)',
	        	  'rgb(201, 203, 207)',
	        	  'rgb(255, 99, 255)',
	        	  'rgb(0, 255, 127)',
	        	  'rgb(255, 140, 0)',
	        	  'rgb(64, 224, 208)',
	        	  'rgb(128, 0, 128)',
	        	  'rgb(210, 105, 30)',
	        	  'rgb(70, 130, 180)',
	        	  'rgb(46, 139, 87)',
	        	  'rgb(255, 20, 147)',
	        	  'rgb(255, 215, 0)',
	        	  'rgb(123, 104, 238)',
	        	  'rgb(0, 191, 255)',
	        	  'rgb(244, 164, 96)'
	        	],
	        borderWidth: 1
	      }]
	    };
	
	    const config = {
	      type: 'bar',
	      data: data,
	      options: {
	        responsive: true,
	        maintainAspectRatio: false,
	        scales: {
	          y: {
	            beginAtZero: true
	          }
	        }
	      }
	    };
	
	    const ctx = document.getElementById("reportsChart").getContext("2d");
	    new Chart(ctx, config);
	  });
	</script>
	
	<script>
		function sendChartImage() {
		    const canvas = document.getElementById("reportsChart");
		    const imageBase64 = canvas.toDataURL("image/png");
		
		    fetch("revenue_report", {
		        method: "POST",
		        headers: {
		            "Content-Type": "application/x-www-form-urlencoded"
		        },
		        body: "imageData=" + encodeURIComponent(imageBase64)
		    })
		    .then(response => response.text())
		    .then(data => alert("Lưu biểu đồ thành công!"))
		    .catch(error => console.error("Lỗi lưu biểu đồ!"));
		}
	</script>
	
	<script>
		function savetopdf() {	
		    fetch("revenue_report", {
		        method: "POST",
		        headers: {
		            "Content-Type": "application/x-www-form-urlencoded"
		        },
		        body: "action=savepdf"
		    })
		    .then(response => response.text())
		    .then(data => alert("Báo cáo đã được lưu vào ổ E! Nếu không có ảnh, hãy lưu ấn lưu biểu đồ lần nữa <3"))
		    .catch(error => console.error("Lỗi lưu báo cáo!"));
		}
	</script>
	
	<script>
                document.addEventListener("DOMContentLoaded", () => {
                  echarts.init(document.querySelector("#trafficChart")).setOption({
                    tooltip: {
                      trigger: 'item'
                    },
                    legend: {
                      top: '5%',
                      left: 'center'
                    },
                    series: [{
                      name: 'lượt',
                      type: 'pie',
                      radius: ['40%', '70%'],
                      avoidLabelOverlap: false,
                      label: {
                        show: false,
                        position: 'center'
                      },
                      emphasis: {
                        label: {
                          show: true,
                          fontSize: '18',
                          fontWeight: 'bold'
                        }
                      },
                      labelLine: {
                        show: false
                      },
                      data: [{
                        value: <%= list_ty_le.get(0) %>,
                        name: 'Phòng'
                      },
                      {
                        value: <%= list_ty_le.get(1) %>,
                        name: 'Làm đẹp'
                      },
                      {
                        value: <%= list_ty_le.get(2) %>,
                        name: 'Thể thao'
                      },
                      {
                        value: <%= list_ty_le.get(3) %>,
                        name: 'Dịch vụ'
                      },
                      {
                          value: <%= list_ty_le.get(4) %>,
                          name: 'Ăn uống'
                       }
                      ]
                    }]
                  });
                });
     </script>

<script src="adjs/date-filter-validate.js"></script>
<%@include file="/adjsp/lib/footer.jsp"%>
</html>
