<%@page import="model.booking_report"%>
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
	<link href="adcss/style_high_chart.css" rel="stylesheet">
	<link href="adcss/hc2.css" rel="stylesheet">
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
	
	<%ArrayList<booking_report> list = (ArrayList<booking_report>)request.getAttribute("list");%>
	<%ArrayList<Integer> list_ty_le = (ArrayList<Integer>) request.getAttribute("list_tong_cong"); %>
		
	<main id="main" class="main">
	
	    <!-- Tiêu đề trang -->
	    <div class="pagetitle">
	        <h1>Thống kê lượt đặt phòng</h1>
	        <nav>
	            <ol class="breadcrumb">
	                <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/home">Trang chủ</a></li>
	                <li class="breadcrumb-item active">Thống kê lượt đặt phòng</li>
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
	                                <i class="bi bi-graph-up-arrow me-2"></i>Thống kê lượt đặt phòng
	                            </h5>
	                        </div>
	
	                        <!-- Form lọc thống kê -->
	                        <form action="booking_report" method="get" class="p-3 border rounded shadow-sm bg-light">
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
	
	                        <!-- Biểu đồ thống kê -->
	                        <h5 class="card-title">Biểu đồ số lượt đặt phòng</h5>
	                        <canvas id="reportsChart" style="max-height: 400px;"></canvas>
	                        <h5 class="card-title">Tỉ lệ đặt phòng</h5>
	                        <div id="trafficChart" style="min-height: 400px;" class="echart"></div>
	                        <figure class="highcharts-figure">
						        <div id="container1"></div>
						    </figure>
	
	                        <!-- Bảng thống kê -->
	                        <div>
	                            <h5 class="card-title">Chi tiết theo thời gian</h5>
	                            <table class="table table-striped datatable">
	                                <thead>
	                                    <tr>
	                                        <th>STT</th>
	                                        <th>Thời gian</th>
	                                        <th>Tầng 1</th>
	                                        <th>Tầng 2</th>
	                                        <th>Tầng 3</th>
	                                        <th>Tầng 4</th>
	                                        <th>Tầng 5</th>
	                                        <th>Tổng</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                    <%
	                                        for (int i = 0; i < list.size(); i++) {
	                                            booking_report br = list.get(i);
	                                    %>
	                                        <tr>
	                                            <td><%= i + 1 %></td>
	                                            <td><%= formatDateId(String.valueOf(br.getBr_id())) %></td>
	                                            <td><%= br.getBr_floor_1() %></td>
	                                            <td><%= br.getBr_floor_2() %></td>
	                                            <td><%= br.getBr_floor_3() %></td>
	                                            <td><%= br.getBr_floor_4() %></td>
	                                            <td><%= br.getBr_floor_5() %></td>
	                                            <td><%= br.getBr_amount() %></td>
	                                        </tr>
	                                    <%
	                                        }
	                                    %>
	                                        <tr>
	                                            <td></td>
	                                            <td>Tổng cộng</td>
	                                            <td><%= list_ty_le.get(0)%></td>
	                                            <td><%= list_ty_le.get(1)%></td>
	                                            <td><%= list_ty_le.get(2)%></td>
	                                            <td><%= list_ty_le.get(3)%></td>
	                                            <td><%= list_ty_le.get(4)%></td>
	                                            <td><%= list_ty_le.get(5)%></td>
	                                        </tr>
	                                </tbody>
	                            </table>
	                        </div>
	
	                        <!-- Nút hành động -->
	                        <div class="d-flex justify-content-between align-items-center mt-4">	
								<button onclick="savetopdf()" class="btn btn-danger">
	                                    <i class="bi bi-file-earmark-arrow-down me-1"></i>Xuất PDF
	                            </button>
	                            
	                            <button onclick="savetocsv()" class="btn btn-primary">
	                                    <i class="bi bi-file-earmark-arrow-down me-1"></i>Xuất CSV
	                            </button>
	                            
	                            <button onclick="savetoxlsx()" class="btn btn-success">
	                                    <i class="bi bi-file-earmark-arrow-down me-1"></i>Xuất Excel
	                            </button>
	
	                            <button onclick="sendChartImage()" class="btn btn-warning">
	                                <i class="bi bi-image me-1"></i>Lưu biểu đồ
	                            </button>
	                        </div>
	                        
							<div class="card mt-4 border rounded shadow-sm bg-light"> 
							    <div class="card-body">
							        <h5 class="card-title mb-3">
							            <i class="bi bi-qr-code-scan me-2"></i>Tải báo cáo bằng mã QR
							        </h5>
							
							        <div class="row g-3 align-items-end">
							            <div class="col-md-4">
							                <label for="type_file" class="form-label fw-semibold">
							                    <i class="bi bi-filetype-pdf me-1"></i>Chọn định dạng
							                </label>
							                <select class="form-select" id="type_file">
							                    <option value="ft_pdf">PDF (.pdf)</option>
							                    <option value="ft_xlsx">Excel (.xlsx)</option>
							                    <option value="ft_csv">CSV (.csv)</option>
							                    <option value="ft_png">Ảnh (.png)</option>
							                </select>
							            </div>
							            <div class="col-md-3">
							                <button onclick="gen_qr()" type="button" class="btn btn-danger w-100">
							                    <i class="bi bi-qr-code me-1"></i>Hiện mã QR
							                </button>
							            </div>
							            <div class="col-md-5 text-center">
							                <div id="qr_container">
							                    <img id="qr_img" src="" style="height: 200px;">
							                </div>
							            </div>
							        </div>
							    </div>
							</div>
							
							<div class="card mt-4 border rounded shadow-sm bg-light">
							    <div class="card-body">
							        <h5 class="card-title mb-3 d-flex align-items-center">
							            <i class="bi bi-envelope-arrow-up-fill me-2 text-primary fs-5"></i> Gửi báo cáo qua Gmail
							        </h5>
							
							        <div class="row g-3 align-items-end">
							            <!-- Chọn định dạng -->
							            <div class="col-md-4">
							                <label for="type_file" class="form-label fw-semibold">
							                    <i class="bi bi-filetype-pdf me-1"></i> Chọn định dạng
							                </label>
							                <select class="form-select" id="type_file1">
							                    <option value="ft_pdf">PDF (.pdf)</option>
							                    <option value="ft_xlsx">Excel (.xlsx)</option>
							                    <option value="ft_csv">CSV (.csv)</option>
							                    <option value="ft_png">Ảnh (.png)</option>
							                </select>
							            </div>
							
							            <!-- Nhập email -->
							            <div class="col-md-5">
							                <label for="e_add" class="form-label fw-semibold">
							                    <i class="bi bi-envelope-at me-1"></i> Email người nhận
							                </label>
							                <input type="email" name="recipientEmail" id="recipientEmail" class="form-control" placeholder="abc@gmail.com" required>
							            </div>
							
							            <!-- Nút gửi -->
							            <div class="col-md-3">
							                <label class="form-label invisible">Gửi</label>
							                <button onclick="sendEM()" type="button" class="btn btn-success w-100 d-flex align-items-center justify-content-center gap-2" title="Gửi báo cáo">
							                    <i class="bi bi-send-check-fill"></i> Gửi
							                </button>
							            </div>
							        </div>
							    </div>
							</div>
							
							<!-- Tiêu đề phụ dự đoán -->
	                        <div class="d-flex justify-content-between align-items-center mb-3">
	                            <h5 class="card-title mb-0">
	                                <i class="bi bi-robot me-2"></i>Dự đoán bằng AI
	                            </h5>
	                        </div>
							
							 <!-- Form dự đoán -->
	                        <form id="forecast-form" class="p-3 border rounded shadow-sm bg-light">
	                            <input type="hidden" name="action" value="forecast" />
	                            <div class="row g-4 align-items-end">
	
	                                <div class="col-md-3">
	                                    <label class="form-label fw-semibold">
	                                        <i class="bi bi-filter-circle me-1"></i>Dự đoán theo
	                                    </label>
	                                    <select name="f" class="form-select">
	                                        <option value="day" ${f == 'day' ? 'selected' : ''}>Ngày</option>
	                                        <option value="month" ${f == 'month' ? 'selected' : ''}>Tháng</option>
	                                        <option value="year" ${f == 'year' ? 'selected' : ''}>Năm</option>
	                                    </select>
	                                </div>
	
	                                <div class="col-md-3">
	                                    <label class="form-label fw-semibold">
	                                        <i class="bi bi-calendar-date me-1"></i>Từ
	                                    </label>
	                                    <input type="date" name="d" class="form-control" value="${d}"/>
	                                </div>
	                                
	                                <div class="col-md-3">
	                                    <label class="form-label fw-semibold">
	                                        <i class="bi bi-calendar-date me-1"></i>Số lượng
	                                    </label>
	                                    <input type="number" name="n" class="form-control" value="${n}"/>
	                                </div>
	
	                                <div class="col-md-3">
	                                    <button type="button" class="btn btn-primary w-100" onclick="forecast()">
										    <i class="bi bi-search me-1"></i>Dự đoán
										</button>
	                                </div>
	                            </div>
	                        </form>
	                        
	                        <table class="table table-striped datatable">
							    <thead>
							        <tr>
							            <th>STT</th>
							            <th>Thời gian</th>
							            <th>Số lượng</th>
							        </tr>
							    </thead>
							    <tbody id="forecast-body">
							    	<tr>
							            <td>0</td>
							            <td>(Tùy chỉnh)</td>
							            <td>(lượt)</td>
							        </tr>
							    </tbody>
							</table>
							
							<figure class="highcharts-figure">
							    <div id="container"></div>
							    <div id="sliders">
							        <table>
							            <tr>
							                <td><label for="alpha">Góc X</label></td>
							                <td><input id="alpha" type="range" min="0" max="45" value="15"/> <span id="alpha-value" class="value"></span></td>
							            </tr>
							            <tr>
							                <td><label for="beta">Góc Y</label></td>
							                <td><input id="beta" type="range" min="-45" max="45" value="15"/> <span id="beta-value" class="value"></span></td>
							            </tr>
							            <tr>
							                <td><label for="depth">Góc Z</label></td>
							                <td><input id="depth" type="range" min="20" max="100" value="50"/> <span id="depth-value" class="value"></span></td>
							            </tr>
							        </table>
							    </div>
							</figure>
							
	                    </div>
	                </div>	
	            </div>
	        </div>
	    </section>
	</main>

</body>

	<script>
		// Set up the chart
		const chartForecast = new Highcharts.Chart({
		    chart: {
		        renderTo: 'container',
		        type: 'column',
		        options3d: {
		            enabled: true,
		            alpha: 15,
		            beta: 15,
		            depth: 50,
		            viewDistance: 25
		        }
		    },
		    xAxis: {
		        type: 'category'
		    },
		    yAxis: {
		        title: {
		            enabled: false
		        }
		    },
		    tooltip: {
		        headerFormat: '<b>{point.key}</b><br>',
		        pointFormat: 'Số lượt đặt phòng: {point.y}'
		    },
		    title: {
		        text: 'Biểu đồ đặt phòng'
		    },
		    subtitle: {
		        text: 'Đơn vị: lượt'
		    },
		    legend: {
		        enabled: false
		    },
		    plotOptions: {
		        column: {
		            depth: 25
		        }
		    },
		    series: [{
		        data: [
		        	['A', 10],
		            ['B', 20],
		            ['C', 15]
				],
		        colorByPoint: true
		    }]
		});
	
		function showValues() {
		    document.getElementById('alpha-value').innerText = chartForecast.options.chart.options3d.alpha;
		    document.getElementById('beta-value').innerText = chartForecast.options.chart.options3d.beta;
		    document.getElementById('depth-value').innerText = chartForecast.options.chart.options3d.depth;
		}

		document.querySelectorAll('#sliders input').forEach(input =>
		    input.addEventListener('input', e => {
		        chartForecast.options.chart.options3d[e.target.id] = parseFloat(e.target.value);
		        chartForecast.redraw(false);
		        showValues();
		    })
		);

		showValues();		
	</script>

	<!-- FORECAST -->
	<script>
	function forecast() {
	    const form = document.getElementById('forecast-form');
	    const formData = new FormData(form);
	
	    const dateValue = formData.get('d')?.trim();
	    const numberValue = formData.get('n')?.trim();
	    const number = parseInt(numberValue, 10);
	
	    // ✅ VALIDATE TRƯỚC KHI GỬI
	    if (!dateValue) {
	        alert("Vui lòng chọn ngày bắt đầu.");
	        form.querySelector('input[name="d"]').focus();
	        return;
	    }
	
	    if (!numberValue || isNaN(number) || number <= 0) {
	        alert("Vui lòng nhập số lượng là số nguyên dương.");
	        form.querySelector('input[name="n"]').focus();
	        return;
	    }
	
	    // ✅ GỬI FETCH NẾU HỢP LỆ
	    fetch('booking_report?action=forecast', {
	        method: 'POST',
	        body: new URLSearchParams(formData)
	    })
	    .then(response => {
	        if (!response.ok) {
	            throw new Error('HTTP status ' + response.status);
	        }
	        return response.json();
	    })
	    .then(data => {
	        console.log("Forecast data:", data);
	        const tbodyList = document.querySelectorAll('tbody');
	        const tbody = tbodyList[1]; // Đảm bảo tbody[1] đúng là chỗ bạn muốn render
	
	        tbody.innerHTML = "";
	
	        if (data.error) {
	            alert("Lỗi từ server: " + data.error);
	            return;
	        }
	
	        let index = 1;
	        for (const [date, value] of Object.entries(data)) {
	            const tr = document.createElement('tr');
	
	            const tdIndex = document.createElement('td');
	            tdIndex.innerText = index;
	
	            const tdDate = document.createElement('td');
	            tdDate.innerText = date;
	
	            const tdValue = document.createElement('td');
	            tdValue.innerText = value;
	
	            tr.appendChild(tdIndex);
	            tr.appendChild(tdDate);
	            tr.appendChild(tdValue);
	
	            tbody.appendChild(tr);
	            index++;
	        }

	     	// Sau khi render bảng, cập nhật biểu đồ
	        const chartData = Object.entries(data).map(([date, value]) => [date, value]);
	        chartForecast.series[0].setData(chartData);
	    })
	    .catch(err => {
	        console.error('Lỗi dự đoán:', err);
	        alert("Không thể lấy dữ liệu dự đoán.");
	    });
	}
	</script>
	<!-- END FORECAST -->

	<!-- QR -->
	<script>
		function gen_qr() {
 			const text = document.getElementById("type_file").value;
			const qrUrl = "qr?text=" + encodeURIComponent(text);
			document.getElementById("qr_img").src = qrUrl + "&t=" + new Date().getTime(); // tránh cache
		}
	 </script>
	 <!-- END QR -->	
	
	<!-- Script -->
	<script>
	  document.addEventListener("DOMContentLoaded", () => {
		  <%
			  StringBuilder labelsBuilder = new StringBuilder();
			  StringBuilder dataBkBuilder = new StringBuilder();
			  for (int i = 0; i < list.size(); i++) {
			    booking_report br = list.get(i);
			    String label = formatDateId(String.valueOf(br.getBr_id()));
			    labelsBuilder.append("\"").append(label).append("\"");
			    dataBkBuilder.append(br.getBr_amount());
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
	        label: 'Số lượt đặt phòng',
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
		
		    fetch("booking_report", {
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
	    function sendEM() {
	        const recipientEmail = document.getElementById("recipientEmail").value.trim();
	        const format = document.getElementById("type_file1").value;
	
	        if (!recipientEmail) {
	            alert("Vui lòng nhập địa chỉ email!");
	            return;
	        }
	
	        fetch("booking_report", {
	            method: "POST",
	            headers: {
	                "Content-Type": "application/x-www-form-urlencoded"
	            },
	            body: "action=send_em" +
	                  "&recipientEmail=" + encodeURIComponent(recipientEmail) +
	                  "&format=" + encodeURIComponent(format)
	        })
	        .then(response => response.text())
	        .then(data => {
	            alert("✅ Gửi mail thành công đến: " + recipientEmail);
	        })
	        .catch(error => {
	            console.error("Lỗi gửi mail:", error);
	            alert("❌ Gửi mail thất bại! Vui lòng kiểm tra lại.");
	        });
	    }
	</script>

	<script>
		function savetopdf() {	
		    fetch("booking_report", {
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
		function savetocsv() {	
		    fetch("booking_report", {
		        method: "POST",
		        headers: {
		            "Content-Type": "application/x-www-form-urlencoded"
		        },
		        body: "action=savecsv"
		    })
		    .then(response => response.text())
		    .then(data => alert("Báo cáo đã được lưu vào ổ E! Nếu không có ảnh, hãy lưu ấn lưu biểu đồ lần nữa <3"))
		    .catch(error => console.error("Lỗi lưu báo cáo!"));
		}
	</script>
	
	<script>
		function savetoxlsx() {	
		    fetch("booking_report", {
		        method: "POST",
		        headers: {
		            "Content-Type": "application/x-www-form-urlencoded"
		        },
		        body: "action=savexlsx"
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
                        value: <%=list_ty_le.get(0)%>,
                        name: 'Tầng 1'
                      },
                      {
                        value: <%=list_ty_le.get(1)%>,
                        name: 'Tầng 2'
                      },
                      {
                        value: <%=list_ty_le.get(2)%>,
                        name: 'Tầng 3'
                      },
                      {
                        value: <%=list_ty_le.get(3)%>,
                        name: 'Tầng 4'
                      },
                      {
                          value: <%=list_ty_le.get(4)%>,
                          name: 'Tầng 5'
                       }
                      ]
                    }]
                  });
                });
    </script>
    
    <!-- High chart -->
	<script>
	    Highcharts.chart('container1', {
	        chart: {
	            type: 'pie',
	            options3d: {
	                enabled: true,
	                alpha: 45,
	                beta: 0
	            }
	        },
	        title: {
	            text: 'Tương quan đặt phòng'
	        },
	        subtitle: {
	            text: 'Đơn vị: %'
	        },
	        accessibility: {
	            point: {
	                valueSuffix: '%'
	            }
	        },
	        tooltip: {
	            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
	        },
	        plotOptions: {
	            pie: {
	                allowPointSelect: true,
	                cursor: 'pointer',
	                depth: 35,
	                dataLabels: {
	                    enabled: true,
	                    format: '{point.name}'
	                }
	            }
	        },
	        series: [{
	            type: 'pie',
	            name: 'lượt',
	            data: [
	                ['Tầng 1', <%= list_ty_le.get(0) %>],
	                ['Tầng 2', <%= list_ty_le.get(1) %>],
	                ['Tầng 3', <%= list_ty_le.get(2) %>],
	                ['Tầng 4', <%= list_ty_le.get(3) %>],
	                ['Tầng 5', <%= list_ty_le.get(4) %>]
	            ]
	        }]
	    });
	
	</script>
	<!-- End High chart -->
    
    <!-- Date -->
    <script>
	   const today = new Date().toISOString().split('T')[0];
	   document.querySelectorAll('input[type="date"]').forEach(function(input) {
	      input.max = today;});
	</script>
	<!-- Date -->

<script src="adjs/date-filter-validate.js"></script>
<%@include file="/adjsp/lib/footer.jsp"%>
</html>
