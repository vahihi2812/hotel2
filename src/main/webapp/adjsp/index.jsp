<%@page import="java.util.ArrayList"%>
<%@page import="dao.booking_reportDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
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
          <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/home"><i class="bi bi-house"></i></a></li>
          <li class="breadcrumb-item active">Dashboard</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section dashboard">
      <div class="row">

        <!-- Left side columns -->
        <div class="col-lg-8">
          <div class="row">

			<!-- Sales Card -->
				<div class="col-xxl-4 col-md-6">
				  <div class="card info-card sales-card">
				
				    <div class="filter">
				      <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
				      <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
				        <li class="dropdown-header text-start">
				          <h6>Lọc</h6>
				        </li>
				        <li><a class="dropdown-item" href="#" data-filter="today" data-text="Hôm nay">Hôm nay</a></li>
				        <li><a class="dropdown-item" href="#" data-filter="month" data-text="Tháng này">Tháng này</a></li>
				        <li><a class="dropdown-item" href="#" data-filter="year" data-text="Năm nay">Năm nay</a></li>
				      </ul>
				    </div>
				
				    <div class="card-body">
				      <h5 class="card-title">Số lượt đặt phòng <span class="tg">Hôm nay</span></h5>
				
				      <div class="d-flex align-items-center">
				        <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
				          <i class="bi bi-cart"></i>
				        </div>
				        <div class="ps-3">
				          <h6 class="dl"></h6>
				          <span class="text-success small pt-1 fw-bold"></span>
				          <span class="text-muted small pt-2 ps-1">Lượt</span>
				        </div>
				      </div>
				    </div>
				  </div>
				</div><!-- End Sales Card -->
			
			<script>
			<%
				ArrayList<Integer> list = (ArrayList<Integer>)request.getAttribute("br_list");
			%>
				document.addEventListener("DOMContentLoaded", () => {
				  const salesData = {
				    today: <%=list.get(2) %>,
				    month: <%=list.get(1) %>,
				    year: <%=list.get(0) %>
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
                  <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                  <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                    <li class="dropdown-header text-start">
                      <h6>Filter</h6>
                    </li>

                    <li><a class="dropdown-item" href="#" data-filter="today" data-text="Hôm nay">Hôm nay</a></li>
                    <li><a class="dropdown-item" href="#" data-filter="month" data-text="Tháng này">Tháng này</a></li>
                    <li><a class="dropdown-item" href="#" data-filter="year" data-text="Năm nay">Năm nay</a></li>
                  </ul>
                </div>

                <div class="card-body">
                  <h5 class="card-title">Doanh thu <span class="tg_1"></span></h5>

                  <div class="d-flex align-items-center">
                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
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
            </div><!-- End Revenue Card -->

			<script>
				document.addEventListener("DOMContentLoaded", () => {
				  const revData = {
				    today: 123,
				    month: 456,
				    year: 789
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
                  <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                  <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                    <li class="dropdown-header text-start">
                      <h6>Filter</h6>
                    </li>

                    <li><a class="dropdown-item" href="#" data-filter="today" data-text="Hôm nay">Hôm nay</a></li>
                    <li><a class="dropdown-item" href="#" data-filter="month" data-text="Tháng này">Tháng này</a></li>
                    <li><a class="dropdown-item" href="#" data-filter="year" data-text="Năm nay">Năm nay</a></li>
                  </ul>
                </div>

                <div class="card-body">
                  <h5 class="card-title">Khách hàng mới <span class="tg_2">  Hôm nay</span></h5>

                  <div class="d-flex align-items-center">
                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
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

            </div><!-- End Customers Card -->
            
            <script>
				document.addEventListener("DOMContentLoaded", () => {
				  const cusData = {
				    today: <%=list.get(5) %>,
				    month: <%=list.get(4) %>,
				    year: <%=list.get(3) %>
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
                  <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
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
                  <h5 class="card-title">Báo cáo <span>/  Tuần này</span></h5>

                  <!-- Line Chart -->
                  <div id="reportsChart"></div>

                  <script>
                    document.addEventListener("DOMContentLoaded", () => {
                      new ApexCharts(document.querySelector("#reportsChart"), {
                        series: [{
                          name: 'Tầng 1',
                          data: [5, 4, 7, 6, 8, 10, 6],
                        }, {
                          name: 'Tầng 2',
                          data: [6, 9, 5, 3, 4, 13, 7]
                        }, {
                          name: 'Tầng 3',
                          data: [4, 8, 9, 12, 15, 16, 17]
                        }
                        , {
                          name: 'Tầng 4',
                          data: [1, 3, 4, 5, 2, 10, 13]
                        }
                        , {
                          name: 'Tầng 5',
                          data: [6, 7, 5, 3, 2, 4, 8]
                        }
                        ],
                        chart: {
                          height: 350,
                          type: 'area',
                          toolbar: {
                            show: false
                          },
                        },
                        markers: {
                          size: 4
                        },
                        colors: ['#4154f1', '#2eca6a', '#ff771d', '#ff4560', '#00d9e0'],
                        fill: {
                          type: "gradient",
                          gradient: {
                            shadeIntensity: 1,
                            opacityFrom: 0.3,
                            opacityTo: 0.4,
                            stops: [0, 90, 100]
                          }
                        },
                        dataLabels: {
                          enabled: false
                        },
                        stroke: {
                          curve: 'smooth',
                          width: 2
                        },
                        xaxis: {
                          type: 'datetime',
                          categories: ["2024-09-19T00:00:00.000Z", "2024-09-20T00:00:00.000Z", "2024-09-21T00:00:00.000Z", "2024-09-22T00:00:00.000Z", "2024-09-23T00:00:00.000Z", "2024-09-24T00:00:00.000Z", "2024-09-25T00:00:00.000Z"]
                        },
                        tooltip: {
                          x: {
                            format: 'dd/MM/yy HH:mm'
                          },
                        }
                      }).render();
                    });
                  </script>
                  <!-- End Line Chart -->

                </div>

              </div>
            </div><!-- End Reports -->

            <!-- Recent Sales -->
            <div class="col-12">
              <div class="card recent-sales overflow-auto">

                <div class="filter">
                  <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
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
                  <h5 class="card-title">Gần đây <span>| Hôm nay</span></h5>

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
            </div><!-- End Recent Sales -->

            <!-- Top Selling -->
            <div class="col-12">
              <div class="card top-selling overflow-auto">

                <div class="filter">
                  <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
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
                  <h5 class="card-title">Phòng phổ biến <span>| Hôm nay</span></h5>

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
            </div><!-- End Top Selling -->

          </div>
        </div><!-- End Left side columns -->

        <!-- Right side columns -->
        <div class="col-lg-4">

          <!-- Recent Activity -->
          <div class="card">
            <div class="filter">
              <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
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
              <h5 class="card-title">Hoạt động gần đây <span>| Hôm nay</span></h5>

              <div class="activity">

                <div class="activity-item d-flex">
                  <div class="activite-label">32 min</div>
                  <i class='bi bi-circle-fill activity-badge text-success align-self-start'></i>
                  <div class="activity-content">
                    Khách hàng Nguyễn Thu đặt phòng 101
                  </div>
                </div><!-- End activity item-->

                <div class="activity-item d-flex">
                  <div class="activite-label">56 min</div>
                  <i class='bi bi-circle-fill activity-badge text-danger align-self-start'></i>
                  <div class="activity-content">
                    Khách hàng Nguyễn Thu đặt phòng 101
                  </div>
                </div><!-- End activity item-->

                <div class="activity-item d-flex">
                  <div class="activite-label">2 hrs</div>
                  <i class='bi bi-circle-fill activity-badge text-primary align-self-start'></i>
                  <div class="activity-content">
                    Khách hàng Nguyễn Thu đặt phòng 101
                  </div>
                </div><!-- End activity item-->

                <div class="activity-item d-flex">
                  <div class="activite-label">1 day</div>
                  <i class='bi bi-circle-fill activity-badge text-info align-self-start'></i>
                  <div class="activity-content">
                    Khách hàng Nguyễn Thu đặt phòng 101
                  </div>
                </div><!-- End activity item-->

                <div class="activity-item d-flex">
                  <div class="activite-label">2 days</div>
                  <i class='bi bi-circle-fill activity-badge text-warning align-self-start'></i>
                  <div class="activity-content">
                    Khách hàng Nguyễn Thu đặt phòng 101                  </div>
                </div><!-- End activity item-->

                <div class="activity-item d-flex">
                  <div class="activite-label">4 weeks</div>
                  <i class='bi bi-circle-fill activity-badge text-muted align-self-start'></i>
                  <div class="activity-content">
                    Khách hàng Nguyễn Thu đặt phòng 101                  </div>
                </div><!-- End activity item-->

              </div>

            </div>
          </div><!-- End Recent Activity -->

          <!-- Budget Report -->
          <div class="card">
            <div class="filter">
              <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
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
              <h5 class="card-title">Báo cáo doanh thu <span>| Tháng này</span></h5>

              <div id="budgetChart" style="min-height: 400px;" class="echart"></div>

              <script>
                document.addEventListener("DOMContentLoaded", () => {
                  var budgetChart = echarts.init(document.querySelector("#budgetChart")).setOption({
                    legend: {
                      data: ['Plan', 'Real']
                    },
                    radar: {
                      // shape: 'circle',
                      indicator: [{
                        name: '1st Floor',
                        max: 6500
                      },
                      {
                        name: '2nd Floor',
                        max: 16000
                      },
                      {
                        name: '3rd Floor',
                        max: 30000
                      },
                      {
                        name: '4th Floor',
                        max: 38000
                      },
                      {
                        name: '5th Floor',
                        max: 52000
                      },
                      ]
                    },
                    series: [{
                      name: 'Budget vs spending',
                      type: 'radar',
                      data: [{
                        value: [4200, 3000, 20000, 35000, 50000, 18000],
                        name: 'Plan'
                      },
                      {
                        value: [5000, 14000, 28000, 26000, 42000, 21000],
                        name: 'Real'
                      }
                      ]
                    }]
                  });
                });
              </script>

            </div>
          </div><!-- End Budget Report -->

          <!-- Website Traffic -->
          <div class="card">
            <div class="filter">
              <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
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
              <h5 class="card-title">Thời điểm đặt phòng <span>| Hôm nay</span></h5>

              <div id="trafficChart" style="min-height: 400px;" class="echart"></div>

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
                      name: 'Access From',
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
                        value: 1048,
                        name: '5h - 12h'
                      },
                      {
                        value: 735,
                        name: '12h - 17h'
                      },
                      {
                        value: 580,
                        name: '17h - 22h'
                      },
                      {
                        value: 484,
                        name: '22h - 5h'
                      }
                      ]
                    }]
                  });
                });
              </script>

            </div>
          </div><!-- End Website Traffic -->

          <!-- News & Updates Traffic -->
          <div class="card">
            <div class="filter">
              <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
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
              <h5 class="card-title">Tin tức &amp; Cập nhật <span>| Hôm nay</span></h5>

              <div class="news">
                <div class="post-item clearfix">
                  <img src="adimg/news-1.jpg" alt="">
                  <h4><a href="#">Phòng 101 trang bị thêm TV OLED</a></h4>
                  <p>Tăng trải nghiệm cho khách hàng</p>
                </div>

                <div class="post-item clearfix">
                  <img src="adimg/news-2.jpg" alt="">
                  <h4><a href="#">Phòng 101 trang bị thêm TV OLED</a></h4>
                  <p>Tăng trải nghiệm cho khách hàng</p>
                </div>

                <div class="post-item clearfix">
                  <img src="adimg/news-3.jpg" alt="">
                  <h4><a href="#">Phòng 101 trang bị thêm TV OLED</a></h4>
                  <p>Tăng trải nghiệm cho khách hàng</p>
                </div>

                <div class="post-item clearfix">
                  <img src="adimg/news-4.jpg" alt="">
                  <h4><a href="#">Phòng 101 trang bị thêm TV OLED</a></h4>
                  <p>Tăng trải nghiệm cho khách hàng</p>
                </div>

                <div class="post-item clearfix">
                  <img src="adimg/news-5.jpg" alt="">
                  <h4><a href="#">Phòng 101 trang bị thêm TV OLED</a></h4>
                  <p>Tăng trải nghiệm cho khách hàng</p>
                </div>

              </div><!-- End sidebar recent posts-->

            </div>
          </div><!-- End News & Updates -->

        </div><!-- End Right side columns -->

      </div>
    </section>

  </main><!-- End #main -->
</body>
<%@include file="/adjsp/lib/footer.jsp"%>

</html>