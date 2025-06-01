<%@page import="model.booking_report"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.booking_reportDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="en">
<%@include file="/adjsp/lib/header.jsp"%>
<%@include file="/adjsp/lib/sidebar.jsp"%>
<body>

	<main id="main" class="main">

		<!-- Page Title -->
		<div class="pagetitle">
			<h1>Trang chủ</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a
						href="<%=request.getContextPath()%>/home"><i
							class="bi bi-house"></i></a></li>
					<li class="breadcrumb-item active">Dashboard</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->

		<section class="section dashboard">
			<div class="row">
				<!-- Left side columns -->
				<div class="col-lg-8">
					<div class="row">

						<!-- Sales Card -->
						<div class="col-xxl-4 col-md-6">
							<div class="card info-card sales-card">

								<div class="filter">
									<a class="icon" href="#" data-bs-toggle="dropdown"><i
										class="bi bi-three-dots"></i></a>
									<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
										<li class="dropdown-header text-start">
											<h6>Lọc</h6>
										</li>
										<li><a class="dropdown-item" href="#" data-filter="today"
											data-text="Hôm nay">Hôm nay</a></li>
										<li><a class="dropdown-item" href="#" data-filter="month"
											data-text="Tháng này">Tháng này</a></li>
										<li><a class="dropdown-item" href="#" data-filter="year"
											data-text="Năm nay">Năm nay</a></li>
									</ul>
								</div>

								<div class="card-body">
									<h5 class="card-title">
										Số lượt đặt phòng <span class="tg">Hôm nay</span>
									</h5>

									<div class="d-flex align-items-center">
										<div
											class="card-icon rounded-circle d-flex align-items-center justify-content-center">
											<i class="bi bi-cart"></i>
										</div>
										<div class="ps-3">
											<h6 class="dl"></h6>
											<span class="text-success small pt-1 fw-bold"></span> <span
												class="text-muted small pt-2 ps-1">Lượt</span>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- End Sales Card -->

						<script>
			<%ArrayList<Integer> list = (ArrayList<Integer>) request.getAttribute("total_list");
			ArrayList<Double> list1 = (ArrayList<Double>) request.getAttribute("list1");
			ArrayList<Integer> list2 = (ArrayList<Integer>) request.getAttribute("list_ss");
			%>
				document.addEventListener("DOMContentLoaded", () => {
				  const salesData = {
				    today: <%=list.get(2)%>,
				    month: <%=list.get(1)%>,
				    year: <%=list.get(0)%>
				  };
				
				  const salesValueElement = document.querySelector(".sales-card .dl");
				  const ttg = document.querySelector(".sales-card .tg");
				
				  // Gán mặc định ban đầu là hôm nay
				  salesValueElement.textContent = salesData.today;
				  ttg.textContent = "Hôm nay";
				
				  document.querySelectorAll(".sales-card .dropdown-item").forEach(item => {
				    item.addEventListener("click", (e) => {
				      e.preventDefault();
				      const filter = item.getAttribute("data-filter");
				      const label = item.getAttribute("data-text");
				
				      if (salesData.hasOwnProperty(filter)) {
				        salesValueElement.textContent = salesData[filter];
				        ttg.textContent = label;
				      }
				    });
				  });
				});
				</script>

						<!-- Revenue Card -->
						<div class="col-xxl-4 col-md-6">
							<div class="card info-card revenue-card">

								<div class="filter">
									<a class="icon" href="#" data-bs-toggle="dropdown"><i
										class="bi bi-three-dots"></i></a>
									<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
										<li class="dropdown-header text-start">
											<h6>Filter</h6>
										</li>

										<li><a class="dropdown-item" href="#" data-filter="today"
											data-text="Hôm nay">Hôm nay</a></li>
										<li><a class="dropdown-item" href="#" data-filter="month"
											data-text="Tháng này">Tháng này</a></li>
										<li><a class="dropdown-item" href="#" data-filter="year"
											data-text="Năm nay">Năm nay</a></li>
									</ul>
								</div>

								<div class="card-body">
									<h5 class="card-title">
										Doanh thu <span class="tg_1"></span>
									</h5>

									<div class="d-flex align-items-center">
										<div
											class="card-icon rounded-circle d-flex align-items-center justify-content-center">
											<i class="bi bi-currency-dollar"></i>
										</div>
										<div class="ps-3">
											<h6 class="dl_1"></h6>
											<span class="text-success small pt-1 fw-bold">8%</span> <span
												class="text-muted small pt-2 ps-1">tăng</span>
										</div>
									</div>
								</div>

							</div>
						</div>
						<!-- End Revenue Card -->

						<script>
				document.addEventListener("DOMContentLoaded", () => {
				  const revData = {
					today: <%=list1.get(2)%>,
					month: <%=list1.get(1)%>,
					year: <%=list1.get(0)%>
				  };
				
				  const revValueElement = document.querySelector(".revenue-card .dl_1");
				  const ttg_1 = document.querySelector(".revenue-card .tg_1");
				
				  // Gán mặc định ban đầu là hôm nay
				  revValueElement.textContent = revData.today;
				  ttg_1.textContent = "Hôm nay";
				
				  document.querySelectorAll(".revenue-card .dropdown-item").forEach(item => {
				    item.addEventListener("click", (e) => {
				      e.preventDefault();
				      const filter_1 = item.getAttribute("data-filter");
				      const label_1 = item.getAttribute("data-text");
				
				      if (revData.hasOwnProperty(filter_1)) {
				        revValueElement.textContent = revData[filter_1];
				        ttg_1.textContent = label_1;
				      }
				    });
				  });
				});
				</script>

						<!-- Customers Card -->
						<div class="col-xxl-4 col-xl-12">

							<div class="card info-card customers-card">

								<div class="filter">
									<a class="icon" href="#" data-bs-toggle="dropdown"><i
										class="bi bi-three-dots"></i></a>
									<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
										<li class="dropdown-header text-start">
											<h6>Filter</h6>
										</li>

										<li><a class="dropdown-item" href="#" data-filter="today"
											data-text="Hôm nay">Hôm nay</a></li>
										<li><a class="dropdown-item" href="#" data-filter="month"
											data-text="Tháng này">Tháng này</a></li>
										<li><a class="dropdown-item" href="#" data-filter="year"
											data-text="Năm nay">Năm nay</a></li>
									</ul>
								</div>

								<div class="card-body">
									<h5 class="card-title">
										Khách hàng mới <span class="tg_2"> Hôm nay</span>
									</h5>

									<div class="d-flex align-items-center">
										<div
											class="card-icon rounded-circle d-flex align-items-center justify-content-center">
											<i class="bi bi-people"></i>
										</div>
										<div class="ps-3">
											<h6 class="dl_2"></h6>
											<span class="text-danger small pt-1 fw-bold">12%</span> <span
												class="text-muted small pt-2 ps-1">giảm</span>
										</div>
									</div>

								</div>
							</div>

						</div>
						<!-- End Customers Card -->

						<script>
				document.addEventListener("DOMContentLoaded", () => {
				  const cusData = {
				    today: <%=list.get(5)%>,
				    month: <%=list.get(4)%>,
				    year: <%=list.get(3)%>
				  };
				
				  const cusValueElement = document.querySelector(".customers-card .dl_2");
				  const ttg_2 = document.querySelector(".customers-card .tg_2");
				
				  // Gán mặc định ban đầu là hôm nay
				  cusValueElement.textContent = cusData.today;
				  ttg_2.textContent = "Hôm nay";
				
				  document.querySelectorAll(".customers-card .dropdown-item").forEach(item => {
				    item.addEventListener("click", (e) => {
				      e.preventDefault();
				      const filter_2 = item.getAttribute("data-filter");
				      const label_2 = item.getAttribute("data-text");
				
				      if (cusData.hasOwnProperty(filter_2)) {
				        cusValueElement.textContent = cusData[filter_2];
				        ttg_2.textContent = label_2;
				      }
				    });
				  });
				});
			</script>

						<!-- Reports -->
						<div class="col-12">
							<div class="card">

								<div class="filter">
									<a class="icon" href="<%=request.getContextPath()%>/booking_report"><i class="bi bi-eye"></i></a>
<!-- 									<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow"> -->
<!-- 										<li class="dropdown-header text-start"> -->
<!-- 											<h6>Filter</h6> -->
<!-- 										</li> -->

<!-- 										<li><a class="dropdown-item" href="#">Hôm nay</a></li> -->
<!-- 										<li><a class="dropdown-item" href="#">Tháng này</a></li> -->
<!-- 										<li><a class="dropdown-item" href="#">Năm nay</a></li> -->
<!-- 									</ul> -->
								</div>

								<div class="card-body">
									<h5 class="card-title">
										Báo cáo <span>/ Tuần này</span>
									</h5>
									<!-- Bar Chart -->
									<canvas id="reportsChart" style="max-height: 400px;"></canvas>
								</div>

							</div>
						</div>
						<!-- End Reports -->

						<!-- Recent Sales -->
						<div class="col-12">
							<div class="card recent-sales overflow-auto">

								<div class="filter">
									<a class="icon" href="#" data-bs-toggle="dropdown"><i
										class="bi bi-three-dots"></i></a>
									<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
										<li class="dropdown-header text-start">
											<h6>Lọc</h6>
										</li>

										<li><a class="dropdown-item" href="#">Hôm nay</a></li>
										<li><a class="dropdown-item" href="#">Tháng này</a></li>
										<li><a class="dropdown-item" href="#">Năm nay</a></li>
									</ul>
								</div>

								<div class="card-body">
									<h5 class="card-title">
										Gần đây <span>| Hôm nay</span>
									</h5>

									<table class="table table-borderless datatable">
										<thead>
											<tr>
												<th scope="col">#</th>
												<th scope="col">Khách hàng</th>
												<th scope="col">Phòng</th>
												<th scope="col">Giá</th>
												<th scope="col">Trạng thái</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th scope="row"><a href="#">#2457</a></th>
												<td>Nguyễn Thị Thu</td>
												<td><a href="#" class="text-primary">P101</a></td>
												<td>1.4000.000đ</td>
												<td><span class="badge bg-success">Approved</span></td>
											</tr>
										</tbody>
									</table>

								</div>

							</div>
						</div>
						<!-- End Recent Sales -->

						<!-- Top Selling -->
						<div class="col-12">
							<div class="card top-selling overflow-auto">

								<div class="filter">
									<a class="icon" href="#" data-bs-toggle="dropdown"><i
										class="bi bi-three-dots"></i></a>
									<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
										<li class="dropdown-header text-start">
											<h6>Lọc</h6>
										</li>

										<li><a class="dropdown-item" href="#">Hôm nay</a></li>
										<li><a class="dropdown-item" href="#">Tháng này</a></li>
										<li><a class="dropdown-item" href="#">Năm nay</a></li>
									</ul>
								</div>

								<div class="card-body pb-0">
									<h5 class="card-title">
										Phòng phổ biến <span>| Hôm nay</span>
									</h5>

									<table class="table table-borderless">
										<thead>
											<tr>
												<th scope="col">Tên</th>
												<th scope="col">Giá</th>
												<th scope="col">Số lượt</th>
												<th scope="col">Doanh thu</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td><a href="#" class="text-primary fw-bold">P101</a></td>
												<td>1.400.000đ</td>
												<td class="fw-bold">1</td>
												<td>1.400.000đ</td>
											</tr>
										</tbody>
									</table>

								</div>

							</div>
						</div>
						<!-- End Top Selling -->

					</div>
				</div>
				<!-- End Left side columns -->

				<!-- Right side columns -->
				<div class="col-lg-4">

					<!-- Recent Activity -->
					<div class="card">
						<div class="filter">
							<a class="icon" href="#" data-bs-toggle="dropdown"><i
								class="bi bi-three-dots"></i></a>
							<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
								<li class="dropdown-header text-start">
									<h6>Filter</h6>
								</li>

								<li><a class="dropdown-item" href="#">Hôm nay</a></li>
								<li><a class="dropdown-item" href="#">Tháng này</a></li>
								<li><a class="dropdown-item" href="#">Năm nay</a></li>
							</ul>
						</div>

						<div class="card-body">
							<h5 class="card-title">
								Hoạt động gần đây <span>| Hôm nay</span>
							</h5>

							<div class="activity">

								<div class="activity-item d-flex">
									<div class="activite-label">32 min</div>
									<i
										class='bi bi-circle-fill activity-badge text-success align-self-start'></i>
									<div class="activity-content">Khách hàng Nguyễn Thu đặt
										phòng 101</div>
								</div>
								<!-- End activity item-->

								<div class="activity-item d-flex">
									<div class="activite-label">56 min</div>
									<i
										class='bi bi-circle-fill activity-badge text-danger align-self-start'></i>
									<div class="activity-content">Khách hàng Nguyễn Thu đặt
										phòng 101</div>
								</div>
								<!-- End activity item-->

								<div class="activity-item d-flex">
									<div class="activite-label">2 hrs</div>
									<i
										class='bi bi-circle-fill activity-badge text-primary align-self-start'></i>
									<div class="activity-content">Khách hàng Nguyễn Thu đặt
										phòng 101</div>
								</div>
								<!-- End activity item-->

								<div class="activity-item d-flex">
									<div class="activite-label">1 day</div>
									<i
										class='bi bi-circle-fill activity-badge text-info align-self-start'></i>
									<div class="activity-content">Khách hàng Nguyễn Thu đặt
										phòng 101</div>
								</div>
								<!-- End activity item-->

								<div class="activity-item d-flex">
									<div class="activite-label">2 days</div>
									<i
										class='bi bi-circle-fill activity-badge text-warning align-self-start'></i>
									<div class="activity-content">Khách hàng Nguyễn Thu đặt
										phòng 101</div>
								</div>
								<!-- End activity item-->

								<div class="activity-item d-flex">
									<div class="activite-label">4 weeks</div>
									<i
										class='bi bi-circle-fill activity-badge text-muted align-self-start'></i>
									<div class="activity-content">Khách hàng Nguyễn Thu đặt
										phòng 101</div>
								</div>
								<!-- End activity item-->

							</div>

						</div>
					</div>
					<!-- End Recent Activity -->

					<!-- Budget Report -->
					<div class="card">
						<div class="filter">
							<a class="icon" href="<%=request.getContextPath()%>/revenue_report"><i class="bi bi-eye"></i></a>
						</div>

						<div class="card-body pb-0">
							<h5 class="card-title">
								Báo cáo doanh thu <span>| Tháng này</span>
							</h5>
							<!-- Budget Chart -->
							<canvas id="budgetChart" style="min-height: 400px;"></canvas>
						</div>
					</div>
					<!-- End Budget Report -->

					<!-- Website Traffic -->
					<div class="card">
						<div class="filter">
							<a class="icon" href="<%=request.getContextPath()%>/booking_report"><i
								class="bi bi-eye"></i></a>
<!-- 							<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow"> -->
<!-- 								<li class="dropdown-header text-start"> -->
<!-- 									<h6>Filter</h6> -->
<!-- 								</li> -->

<!-- 								<li><a class="dropdown-item" href="#">Hôm nay</a></li> -->
<!-- 								<li><a class="dropdown-item" href="#">Tháng này</a></li> -->
<!-- 								<li><a class="dropdown-item" href="#">Năm nay</a></li> -->
<!-- 							</ul> -->
						</div>

						<div class="card-body pb-0">
							<h5 class="card-title">
								Tỉ lệ đặt phòng <span>| Tuần này</span>
							</h5>

							<div id="trafficChart" style="min-height: 400px;" class="echart"></div>

				<%ArrayList<Integer> list_ty_le = (ArrayList<Integer>) request.getAttribute("list_ty_le"); %>
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
                        name: 'Tầng 1'
                      },
                      {
                        value: <%= list_ty_le.get(1) %>,
                        name: 'Tầng 2'
                      },
                      {
                        value: <%= list_ty_le.get(2) %>,
                        name: 'Tầng 3'
                      },
                      {
                        value: <%= list_ty_le.get(3) %>,
                        name: 'Tầng 4'
                      },
                      {
                          value: <%= list_ty_le.get(4) %>,
                          name: 'Tầng 5'
                       }
                      ]
                    }]
                  });
                });
              </script>

						</div>
					</div>
					<!-- End Website Traffic -->

					<!-- News & Updates Traffic -->
					<div class="card">
						<div class="filter">
							<a class="icon" href="#" data-bs-toggle="dropdown"><i
								class="bi bi-three-dots"></i></a>
							<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
								<li class="dropdown-header text-start">
									<h6>Filter</h6>
								</li>

								<li><a class="dropdown-item" href="#">Hôm nay</a></li>
								<li><a class="dropdown-item" href="#">Tháng này</a></li>
								<li><a class="dropdown-item" href="#">Năm nay</a></li>
							</ul>
						</div>

						<div class="card-body pb-0">
							<h5 class="card-title">
								Tin tức &amp; Cập nhật <span>| Hôm nay</span>
							</h5>

							<div class="news">
								<div class="post-item clearfix">
									<img src="adimg/news-1.jpg" alt="">
									<h4>
										<a href="#">Phòng 101 trang bị thêm TV OLED</a>
									</h4>
									<p>Tăng trải nghiệm cho khách hàng</p>
								</div>

								<div class="post-item clearfix">
									<img src="adimg/news-2.jpg" alt="">
									<h4>
										<a href="#">Phòng 101 trang bị thêm TV OLED</a>
									</h4>
									<p>Tăng trải nghiệm cho khách hàng</p>
								</div>

								<div class="post-item clearfix">
									<img src="adimg/news-3.jpg" alt="">
									<h4>
										<a href="#">Phòng 101 trang bị thêm TV OLED</a>
									</h4>
									<p>Tăng trải nghiệm cho khách hàng</p>
								</div>

								<div class="post-item clearfix">
									<img src="adimg/news-4.jpg" alt="">
									<h4>
										<a href="#">Phòng 101 trang bị thêm TV OLED</a>
									</h4>
									<p>Tăng trải nghiệm cho khách hàng</p>
								</div>

								<div class="post-item clearfix">
									<img src="adimg/news-5.jpg" alt="">
									<h4>
										<a href="#">Phòng 101 trang bị thêm TV OLED</a>
									</h4>
									<p>Tăng trải nghiệm cho khách hàng</p>
								</div>

							</div>
							<!-- End sidebar recent posts-->

						</div>
					</div>
					<!-- End News & Updates -->

				</div>
				<!-- End Right side columns -->

			</div>
		</section>

	</main>
	<!-- End #main -->

	<%ArrayList<booking_report> list_tuan = (ArrayList<booking_report>)request.getAttribute("list_tuan");%>

	<!-- Script -->
	<script>
	  document.addEventListener("DOMContentLoaded", () => {		
		  <%
			  StringBuilder labelsBuilder = new StringBuilder();
			  StringBuilder dataBkBuilder = new StringBuilder();
			  for (int i = 0; i < list_tuan.size(); i++) {
			    booking_report br = list_tuan.get(i);
			    String label = formatDateId(String.valueOf(br.getBr_id()));
			    labelsBuilder.append("\"").append(label).append("\"");
			    dataBkBuilder.append(br.getBr_amount());
			    if (i < list_tuan.size() - 1) {
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

	<!-- Script -->
	<script>
		document.addEventListener("DOMContentLoaded", () => {					
			const data = {
				labels: [
					'Phòng',
					'Thức ăn',
					'Dịch vụ',
					'Làm đẹp',
					'Thể thao'],
		  		datasets: [
			  		{
				    label: 'Hôm qua',
						data: [<%= list2.get(0)%>, <%= list2.get(1)%>, <%= list2.get(2)%>, <%= list2.get(3)%>, <%= list2.get(4)%>],
						fill: true,
						backgroundColor: 'rgba(255, 99, 132, 0.2)',
						borderColor: 'rgb(255, 99, 132)',
						pointBackgroundColor: 'rgb(255, 99, 132)',
						pointBorderColor: '#fff',
						pointHoverBackgroundColor: '#fff',
						pointHoverBorderColor: 'rgb(255, 99, 132)'
					 },
					  
					{
					label: 'Hôm nay',
						data: [<%= list2.get(5)%>, <%= list2.get(6)%>, <%= list2.get(7)%>, <%= list2.get(8)%>, <%= list2.get(9)%>],
						fill: true,
						backgroundColor: 'rgba(54, 162, 235, 0.2)',
						borderColor: 'rgb(54, 162, 235)',
						pointBackgroundColor: 'rgb(54, 162, 235)',
						pointBorderColor: '#fff',
						pointHoverBackgroundColor: '#fff',
						pointHoverBorderColor: 'rgb(54, 162, 235)'}]
					};
					
					const config_1 = {
					    type: 'radar',
					    data: data,
					    options: {
					    	elements: {
					    	line: {
					    	 borderWidth: 3
					    			}
					    		}
					    	},
					    };
					
					    const ctx_1 = document.getElementById("budgetChart").getContext("2d");
					    new Chart(ctx_1, config_1);
					  });
	</script>
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
</body>
<%@include file="/adjsp/lib/footer.jsp"%>

</html>