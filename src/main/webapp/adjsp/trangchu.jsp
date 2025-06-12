<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
	<%@include file="/adjsp/lib/cus_header.jsp"%>
  <main class="main">
    <!-- Hero Section -->
    <section id="hero" class="hero section dark-background">

      <div id="hero-carousel" class="carousel slide carousel-fade" data-bs-ride="carousel" data-bs-interval="5000">

        <div class="carousel-item active">
          <img src="adimg/hero-carousel/hotel1.jpg" alt="Luxury Hotel">
          <div class="carousel-container">
            <h2>Trải nghiệm<span> địa điểm nghỉ dưỡng hoàn hảo</span></h2>
            <p>Khám phá những dịch vụ sang trọng đẳng cấp thế giới. Đặt phòng nhanh chóng, thuận tiện và với giá tốt
              nhất.
            </p>
            <div>
              <a href="<%=request.getContextPath()%>/phong" class="btn-get-started">Đặt phòng ngay</a>
            </div>
          </div>
        </div><!-- End Carousel Item -->

        <div class="carousel-item">
          <img src="adimg/hero-carousel/hotel2.jpg" alt="Premium Hotel Room">
          <div class="carousel-container">
            <h2>Thư giãn thoải mái và phong cách</h2>
            <p>Thư giãn trong không gian yên tĩnh với tiện nghi hiện đại và tầm nhìn tuyệt đẹp. Đặt ngay để có kỳ nghỉ
              hoàn hảo.</p>
            <div>
              <a href="<%=request.getContextPath()%>/phong" class="btn-get-started">Đặt ngay</a>
            </div>
          </div>
        </div><!-- End Carousel Item -->

        <div class="carousel-item">
          <img src="adimg/hero-carousel/hotel3.jpg" alt="Beachfront Resort">
          <div class="carousel-container">
            <h2>Kỳ nghỉ khó quên với dịch vụ hàng đầu</h2>
            <p>Chọn phòng tốt nhất cho kỳ nghỉ mơ ước của bạn. Giá cả phải chăng, dịch vụ đặc biệt.</p>
            <div>
              <a href="<%=request.getContextPath()%>/phong" class="btn-get-started">Đặt ngay</a>
            </div>
          </div>
        </div><!-- End Carousel Item -->

        <a class="carousel-control-prev" href="#hero-carousel" role="button" data-bs-slide="prev">
          <span class="carousel-control-prev-icon bi bi-chevron-left" aria-hidden="true"></span>
        </a>

        <a class="carousel-control-next" href="#hero-carousel" role="button" data-bs-slide="next">
          <span class="carousel-control-next-icon bi bi-chevron-right" aria-hidden="true"></span>
        </a>

        <ol class="carousel-indicators"></ol>

      </div>

    </section>
    <!-- /Hero Section -->

    <!-- About Section -->
    <section id="about" class="about section light-background">
      <div class="container">
        <div class="row gy-4">
          <div class="col-lg-6 position-relative align-self-start" data-aos="fade-up" data-aos-delay="100">
            <img src="adimg/about.jpg" class="img-fluid" alt="About Us">
            <a href="https://www.youtube.com/watch?v=e5x6Q2j2Qg8" class="glightbox pulsating-play-btn"></a>
          </div>
          <div class="col-lg-6 content" data-aos="fade-up" data-aos-delay="200">
            <h3>Khám phá trải nghiệm đặt phòng khách sạn tốt nhất</h3>
            <p class="fst-italic">
              Chúng tôi cung cấp trải nghiệm đặt phòng khách sạn liền mạch, đảm bảo sự thoải mái và tiện lợi cho mọi du
              khách.
            </p>
            <ul>
              <li><i class="bi bi-check2-all"></i> <span>Tìm ưu đãi đặt phòng tốt nhất với giá cạnh tranh nhất.</span>
              </li>
              <li><i class="bi bi-check2-all"></i> <span>Quá trình đặt chỗ an toàn và không rắc rối.</span></li>
              <li><i class="bi bi-check2-all"></i> <span>Nhiều phòng phù hợp với mọi sở thích và ngân sách.</span></li>
            </ul>
            <p>
              Cho dù bạn đi công tác hay giải trí, nền tảng của chúng tôi cung cấp nhiều loại chỗ ở với dịch vụ hàng
              đầu. Trải nghiệm sự thoải mái, tiện lợi và chất lượng cùng chúng tôi.
            </p>
          </div>
        </div>
      </div>
    </section>
    <!-- /About Section -->


    <!-- Why Us Section -->
    <section id="why-us" class="why-us section">

      <!-- Section Title -->
      <div class="container section-title" data-aos="fade-up">
        <h2>Nổi bật</h2>
        <div><span>Lý do lựa chọn</span> <span class="description-title">Thu Cúc Hotel</span></div>
      </div><!-- End Section Title -->

      <div class="container">

        <div class="row gy-4">

          <div class="col-lg-4" data-aos="fade-up" data-aos-delay="100">
            <div class="card-item">
              <span>01</span>
              <h4><a href="" class="stretched-link">Đảm Bảo Giá Tốt Nhất</a></h4>
              <p>Chúng tôi cung cấp mức giá cạnh tranh nhất mà không có phí ẩn. Hãy tận hưởng những ưu đãi và giảm giá
                đặc biệt.</p>
            </div>
          </div><!-- Card Item -->

          <div class="col-lg-4" data-aos="fade-up" data-aos-delay="200">
            <div class="card-item">
              <span>02</span>
              <h4><a href="" class="stretched-link">Sang Trọng Thoải Mái</a></h4>
              <p>Trải nghiệm chỗ ở hàng đầu với các tiện nghi sang trọng để có một kỳ nghỉ thư giãn và dễ chịu.</p>
            </div>
          </div><!-- Card Item -->

          <div class="col-lg-4" data-aos="fade-up" data-aos-delay="300">
            <div class="card-item">
              <span>03</span>
              <h4><a href="" class="stretched-link">Hỗ Trợ Khách Hàng 24/7</a></h4>
              <p>Đội ngũ hỗ trợ tận tâm của chúng tôi luôn sẵn sàng 24/7 để hỗ trợ bạn với mọi thắc mắc hoặc vấn đề.</p>
            </div>
          </div><!-- Card Item -->

        </div>

      </div>


    </section><!-- /Why Us Section -->

    <!-- Phần Mục Khách Sạn -->
    <section id="hotels" class="menu section">

      <!-- Tiêu Đề Phần -->
      <div class="container section-title" data-aos="fade-up">
        <h2>Phòng Khách Sạn</h2>
        <div><span>Khám Phá Các</span> <span class="description-title">Phòng Sang Trọng</span></div>
      </div>
      <!-- Kết Thúc Tiêu Đề Phần -->

      <div class="container isotope-layout" data-default-filter="*" data-layout="masonry" data-sort="original-order">

        <div class="row" data-aos="fade-up" data-aos-delay="100">
          <div class="col-lg-12 d-flex justify-content-center">
            <ul class="menu-filters isotope-filters">
              <li data-filter="*" class="filter-active">Tất Cả</li>
              <li data-filter=".filter-standard">Phòng đơn</li>
              <li data-filter=".filter-deluxe">Phòng gia đình</li>
              <li data-filter=".filter-suite">Phòng cao cấp</li>
            </ul>
          </div>
        </div><!-- Bộ Lọc Phòng -->

        <div class="row isotope-container" data-aos="fade-up" data-aos-delay="200">

          <div class="col-lg-6 menu-item isotope-item filter-standard">
            <img src="adimg/menu/standard-room.jpg" class="menu-img" alt="Phòng Tiêu Chuẩn">
            <div class="menu-content">
              <a href="#">Phòng đơn</a><span>2400k/đêm</span>
            </div>
            <div class="menu-ingredients">
              Giường thoải mái, Wi-Fi miễn phí, điều hòa không khí, minibar
            </div>
          </div><!-- Mục Phòng -->

          <div class="col-lg-6 menu-item isotope-item filter-deluxe">
            <img src="adimg/menu/deluxe-room.jpg" class="menu-img" alt="Phòng Cao Cấp">
            <div class="menu-content">
              <a href="#">Phòng gia đình</a><span>3600k/đêm</span>
            </div>
            <div class="menu-ingredients">
              Phòng rộng rãi, giường cỡ king, ban công, tầm nhìn ra biển
            </div>
          </div><!-- Mục Phòng -->

          <div class="col-lg-6 menu-item isotope-item filter-suite">
            <img src="adimg/menu/executive-suite.jpg" class="menu-img" alt="Suite Cao Cấp">
            <div class="menu-content">
              <a href="#">Cao Cấp</a><span>6000k/đêm</span>
            </div>
            <div class="menu-ingredients">
              Phòng sang trọng, phòng khách riêng, bồn jacuzzi, dịch vụ VIP
            </div>
          </div><!-- Mục Phòng -->

          <div class="col-lg-6 menu-item isotope-item filter-suite">
            <img src="adimg/menu/presidential-suite.jpg" class="menu-img" alt="Suite Tổng Thống">
            <div class="menu-content">
              <a href="#">Hạng sang</a><span>12000k/đêm</span>
            </div>
            <div class="menu-ingredients">
              Dịch vụ độc quyền, quản gia riêng, tầm nhìn toàn cảnh thành phố
            </div>
          </div><!-- Mục Phòng -->

        </div><!-- Container Phòng -->

      </div>

    </section><!-- /Phần Mục Khách Sạn -->

    <!-- Specials Section -->
    <section id="specials" class="specials section">

      <!-- Section Title -->
      <div class="container section-title" data-aos="fade-up">
        <h2>Ưu Đãi Đặc Biệt</h2>
        <div><span>Khám Phá</span> <span class="description-title">Các Ưu Đãi Độc Quyền</span></div>
      </div><!-- End Section Title -->

      <div class="container" data-aos="fade-up" data-aos-delay="100">

        <div class="row">
          <div class="col-lg-3">
            <ul class="nav nav-tabs flex-column">
              <li class="nav-item">
                <a class="nav-link active show" data-bs-toggle="tab" href="#specials-tab-1">Ưu Đãi Suite Sang Trọng</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#specials-tab-2">Ưu Đãi Cuối Tuần</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#specials-tab-3">Gói Nghỉ Dưỡng Gia Đình</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#specials-tab-4">Chuyến Đi Lãng Mạn</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#specials-tab-5">Ưu Đãi Doanh Nhân</a>
              </li>
            </ul>
          </div>
          <div class="col-lg-9 mt-4 mt-lg-0">
            <div class="tab-content">
              <div class="tab-pane active show" id="specials-tab-1">
                <div class="row">
                  <div class="col-lg-8 details order-2 order-lg-1">
                    <h3>Suite Sang Trọng Với Giá Đặc Biệt</h3>
                    <p class="fst-italic">Trải nghiệm sự thoải mái và sang trọng tối đa với ưu đãi giảm giá 20% cho
                      suite cao cấp.</p>
                    <p>Thưởng thức tầm nhìn ngoạn mục, tiện nghi đẳng cấp thế giới và dịch vụ cá nhân hóa. Lý tưởng cho
                      những ai muốn một kỳ nghỉ xa hoa.</p>
                  </div>
                  <div class="col-lg-4 text-center order-1 order-lg-2">
                    <img src="adimg/luxury-suite.jpg" alt="Suite Sang Trọng" class="img-fluid">
                  </div>
                </div>
              </div>
              <div class="tab-pane" id="specials-tab-2">
                <div class="row">
                  <div class="col-lg-8 details order-2 order-lg-1">
                    <h3>Ưu Đãi Cuối Tuần</h3>
                    <p class="fst-italic">Trốn khỏi thành phố và thư giãn trong không gian nghỉ dưỡng cao cấp.</p>
                    <p>Đặt phòng hai đêm vào cuối tuần và nhận ngay giảm giá 15%, bao gồm bữa sáng miễn phí và sử dụng
                      spa.</p>
                  </div>
                  <div class="col-lg-4 text-center order-1 order-lg-2">
                    <img src="adimg/weekend-getaway.jpg" alt="Ưu Đãi Cuối Tuần" class="img-fluid">
                  </div>
                </div>
              </div>
              <div class="tab-pane" id="specials-tab-3">
                <div class="row">
                  <div class="col-lg-8 details order-2 order-lg-1">
                    <h3>Gói Nghỉ Dưỡng Gia Đình</h3>
                    <p class="fst-italic">Kỳ nghỉ hoàn hảo cho gia đình bạn với những đặc quyền độc đáo.</p>
                    <p>Đặt phòng gia đình cho ba đêm để nhận các bữa ăn miễn phí cho trẻ em, tham gia các hoạt động câu
                      lạc bộ trẻ em và một chuyến tham quan thành phố đặc biệt.</p>
                  </div>
                  <div class="col-lg-4 text-center order-1 order-lg-2">
                    <img src="adimg/family-vacation.jpg" alt="Gói Nghỉ Dưỡng Gia Đình" class="img-fluid">
                  </div>
                </div>
              </div>
              <div class="tab-pane" id="specials-tab-4">
                <div class="row">
                  <div class="col-lg-8 details order-2 order-lg-1">
                    <h3>Chuyến Đi Lãng Mạn</h3>
                    <p class="fst-italic">Hãy làm người thân yêu của bạn bất ngờ với một kỳ nghỉ lãng mạn.</p>
                    <p>Thưởng thức phòng được trang trí đẹp mắt, bữa tối dưới ánh nến và một chai rượu vang miễn phí, lý
                      tưởng cho các dịp kỷ niệm đặc biệt.</p>
                  </div>
                  <div class="col-lg-4 text-center order-1 order-lg-2">
                    <img src="adimg/romantic-escape.jpg" alt="Chuyến Đi Lãng Mạn" class="img-fluid">
                  </div>
                </div>
              </div>
              <div class="tab-pane" id="specials-tab-5">
                <div class="row">
                  <div class="col-lg-8 details order-2 order-lg-1">
                    <h3>Ưu Đãi Doanh Nhân</h3>
                    <p class="fst-italic">Thiết kế dành riêng cho các chuyên gia bận rộn.</p>
                    <p>Tận hưởng Wi-Fi tốc độ cao, không gian làm việc miễn phí và các tùy chọn nhận/trả phòng linh hoạt
                      cho một chuyến công tác thuận tiện.</p>
                  </div>
                  <div class="col-lg-4 text-center order-1 order-lg-2">
                    <img src="adimg/business-traveler.jpg" alt="Ưu Đãi Doanh Nhân" class="img-fluid">
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>

    </section><!-- /Specials Section -->


    <!-- Phần Sự Kiện -->
    <section id="events" class="events section">

      <img class="slider-bg" src="adimg/events-bg.jpg" alt="" data-aos="fade-in">

      <div class="container">

        <div class="swiper init-swiper" data-aos="fade-up" data-aos-delay="100">
          <script type="application/json" class="swiper-config">
        {
          "loop": true,
          "speed": 600,
          "autoplay": {
            "delay": 5000
          },
          "slidesPerView": "auto",
          "pagination": {
            "el": ".swiper-pagination",
            "type": "bullets",
            "clickable": true
          }
        }
      </script>
          <div class="swiper-wrapper">

            <div class="swiper-slide">
              <div class="row gy-4 event-item">
                <div class="col-lg-6">
                  <img src="adimg/events-slider/events-slider-1.jpg" class="img-fluid" alt="">
                </div>
                <div class="col-lg-6 pt-4 pt-lg-0 content">
                  <h3>Tiệc Sinh Nhật</h3>
                  <div class="price">
                    <p><span>189$</span></p>
                  </div>
                  <p class="fst-italic">
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore
                    et dolore magna aliqua.
                  </p>
                  <ul>
                    <li><i class="bi bi-check2-circle"></i> <span>Cung cấp dịch vụ chuyên nghiệp và tiện nghi.</span>
                    </li>
                    <li><i class="bi bi-check2-circle"></i> <span>Không gian ấm cúng và trang trí sáng tạo.</span></li>
                    <li><i class="bi bi-check2-circle"></i> <span>Đội ngũ nhân viên tận tâm và nhiệt tình.</span></li>
                  </ul>
                  <p>
                    Dịch vụ tiệc sinh nhật với không gian ấm áp, mang lại trải nghiệm đáng nhớ cho khách hàng.
                  </p>
                </div>
              </div>
            </div><!-- Kết thúc Slider -->

            <div class="swiper-slide">
              <div class="row gy-4 event-item">
                <div class="col-lg-6">
                  <img src="adimg/events-slider/events-slider-2.jpg" class="img-fluid" alt="">
                </div>
                <div class="col-lg-6 pt-4 pt-lg-0 content">
                  <h3>Tiệc Riêng Tư</h3>
                  <div class="price">
                    <p><span>290$</span></p>
                  </div>
                  <p class="fst-italic">
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore
                    et dolore magna aliqua.
                  </p>
                  <ul>
                    <li><i class="bi bi-check2-circle"></i> <span>Không gian riêng tư và thoải mái.</span></li>
                    <li><i class="bi bi-check2-circle"></i> <span>Thiết kế phù hợp với mọi yêu cầu của khách
                        hàng.</span></li>
                    <li><i class="bi bi-check2-circle"></i> <span>Chất lượng phục vụ hàng đầu.</span></li>
                  </ul>
                  <p>
                    Tiệc riêng tư hoàn hảo cho mọi dịp quan trọng, đáp ứng mọi nhu cầu của khách hàng.
                  </p>
                </div>
              </div>
            </div><!-- Kết thúc Slider -->

            <div class="swiper-slide">
              <div class="row gy-4 event-item">
                <div class="col-lg-6">
                  <img src="adimg/events-slider/events-slider-3.jpg" class="img-fluid" alt="">
                </div>
                <div class="col-lg-6 pt-4 pt-lg-0 content">
                  <h3>Tiệc Theo Yêu Cầu</h3>
                  <div class="price">
                    <p><span>99$</span></p>
                  </div>
                  <p class="fst-italic">
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore
                    et dolore magna aliqua.
                  </p>
                  <ul>
                    <li><i class="bi bi-check2-circle"></i> <span>Gói dịch vụ linh hoạt theo mong muốn của khách
                        hàng.</span></li>
                    <li><i class="bi bi-check2-circle"></i> <span>Trang trí độc đáo và sáng tạo.</span></li>
                    <li><i class="bi bi-check2-circle"></i> <span>Chi phí hợp lý, chất lượng cao.</span></li>
                  </ul>
                  <p>
                    Tiệc theo yêu cầu mang đến sự sáng tạo và cá nhân hóa, đảm bảo sự hài lòng tuyệt đối.
                  </p>
                </div>
              </div>
            </div><!-- Kết thúc Slider -->

          </div>
          <div class="swiper-pagination"></div>
        </div>

      </div>

    </section><!-- /Phần Sự Kiện -->


    <!-- Đặt Phòng Khách Sạn Thu Cúc -->
    <!-- Book A Table Section -->
    <section id="book-a-table" class="book-a-table section">

      <!-- Section Title -->
      <div class="container section-title" data-aos="fade-up">
        <h2>Đặt phòng</h2>
        <div><span>Đặt </span> <span class="description-title">phòng</span></div>
      </div><!-- End Section Title -->

      <div class="container">

        <div class="row g-0" data-aos="fade-up" data-aos-delay="100">

          <div class="col-lg-4 reservation-img" style="background-image: url(adimg/reservation.jpg);"></div>

          <div class="col-lg-8 d-flex align-items-center reservation-form-bg" data-aos="fade-up" data-aos-delay="200">
            <form action="forms/book-a-table.php" method="post" role="form" class="php-email-form">
              <div class="row gy-4">
                <div class="col-lg-4 col-md-6">
                  <input type="text" name="name" class="form-control" id="name" placeholder="Your Name" required="">
                </div>
                <div class="col-lg-4 col-md-6">
                  <input type="email" class="form-control" name="email" id="email" placeholder="Your Email" required="">
                </div>
                <div class="col-lg-4 col-md-6">
                  <input type="text" class="form-control" name="phone" id="phone" placeholder="Your Phone" required="">
                </div>
                <div class="col-lg-4 col-md-6">
                  <input type="date" name="date" class="form-control" id="date" placeholder="Date" required="">
                </div>
                <div class="col-lg-4 col-md-6">
                  <input type="time" class="form-control" name="time" id="time" placeholder="Time" required="">
                </div>
                <div class="col-lg-4 col-md-6">
                  <input type="number" class="form-control" name="people" id="people" placeholder="# of people"
                    required="">
                </div>
              </div>

              <div class="form-group mt-3">
                <textarea class="form-control" name="message" rows="5" placeholder="Message"></textarea>
              </div>

              <div class="text-center mt-3">
                <div class="loading">Đang tải</div>
                <div class="error-message"></div>
                <div class="sent-message">Yêu cầu đặt chỗ của bạn đã được gửi. Chúng tôi sẽ gọi lại hoặc gửi Email để xác nhận
                    đặt chỗ của bạn. Cảm ơn bạn!</div>
                <button type="submit">Đặt phòng</button>
              </div>
            </form>
          </div><!-- End Reservation Form -->

        </div>

      </div>

    </section><!-- /Book A Table Section -->


    <!-- Gallery Section -->
    <section id="gallery" class="gallery section">

      <!-- Section Title -->
      <div class="container section-title" data-aos="fade-up">
        <h2>Thư viện ảnh</h2>
        <div><span>Một số ảnh</span> <span class="description-title">khách sạn chúng tôi</span></div>
      </div><!-- End Section Title -->

      <div class="container-fluid" data-aos="fade-up" data-aos-delay="100">

        <div class="row g-0">

          <div class="col-lg-3 col-md-4">
            <div class="gallery-item">
              <a href="adimg/gallery/gallery-1.jpg" class="glightbox" data-gallery="images-gallery">
                <img src="adimg/gallery/gallery-1.jpg" alt="" class="img-fluid">
              </a>
            </div>
          </div><!-- End Gallery Item -->

          <div class="col-lg-3 col-md-4">
            <div class="gallery-item">
              <a href="adimg/gallery/gallery-2.jpg" class="glightbox" data-gallery="images-gallery">
                <img src="adimg/gallery/gallery-2.jpg" alt="" class="img-fluid">
              </a>
            </div>
          </div><!-- End Gallery Item -->

          <div class="col-lg-3 col-md-4">
            <div class="gallery-item">
              <a href="adimg/gallery/gallery-3.jpg" class="glightbox" data-gallery="images-gallery">
                <img src="adimg/gallery/gallery-3.jpg" alt="" class="img-fluid">
              </a>
            </div>
          </div><!-- End Gallery Item -->

          <div class="col-lg-3 col-md-4">
            <div class="gallery-item">
              <a href="adimg/gallery/gallery-4.jpg" class="glightbox" data-gallery="images-gallery">
                <img src="adimg/gallery/gallery-4.jpg" alt="" class="img-fluid">
              </a>
            </div>
          </div><!-- End Gallery Item -->

          <div class="col-lg-3 col-md-4">
            <div class="gallery-item">
              <a href="adimg/gallery/gallery-5.jpg" class="glightbox" data-gallery="images-gallery">
                <img src="adimg/gallery/gallery-5.jpg" alt="" class="img-fluid">
              </a>
            </div>
          </div><!-- End Gallery Item -->

          <div class="col-lg-3 col-md-4">
            <div class="gallery-item">
              <a href="adimg/gallery/gallery-6.jpg" class="glightbox" data-gallery="images-gallery">
                <img src="adimg/gallery/gallery-6.jpg" alt="" class="img-fluid">
              </a>
            </div>
          </div><!-- End Gallery Item -->

          <div class="col-lg-3 col-md-4">
            <div class="gallery-item">
              <a href="adimg/gallery/gallery-7.jpg" class="glightbox" data-gallery="images-gallery">
                <img src="adimg/gallery/gallery-7.jpg" alt="" class="img-fluid">
              </a>
            </div>
          </div><!-- End Gallery Item -->

          <div class="col-lg-3 col-md-4">
            <div class="gallery-item">
              <a href="adimg/gallery/gallery-8.jpg" class="glightbox" data-gallery="images-gallery">
                <img src="adimg/gallery/gallery-8.jpg" alt="" class="img-fluid">
              </a>
            </div>
          </div><!-- End Gallery Item -->

        </div>

      </div>

    </section><!-- /Gallery Section -->

    <!-- Chefs Section -->
    <section id="chefs" class="chefs section">

      <!-- Section Title -->
      <div class="container section-title" data-aos="fade-up">
        <h2>Phục vụ</h2>
        <div><span>Đội ngũ đầu bếp </span> <span class="description-title">chuyên nghiệp</span></div>
      </div><!-- End Section Title -->

      <div class="container">

        <div class="row gy-5">

          <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
            <div class="member">
              <div class="pic"><img src="adimg/chefs/chefs-1.jpg" class="img-fluid" alt=""></div>
              <div class="member-info">
                <h4>Lê Quốc Huy</h4>
                <span>Đầu bếp nổi tiếng</span>
                <div class="social">
                  <a href=""><i class="bi bi-twitter-x"></i></a>
                  <a href=""><i class="bi bi-facebook"></i></a>
                  <a href=""><i class="bi bi-instagram"></i></a>
                  <a href=""><i class="bi bi-linkedin"></i></a>
                </div>
              </div>
            </div>
          </div><!-- End Team Member -->

          <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
            <div class="member">
              <div class="pic"><img src="adimg/chefs/chefs-2.jpg" class="img-fluid" alt=""></div>
              <div class="member-info">
                <h4>Nguyễn Hà Nhi</h4>
                <span>Thợ làm bánh</span>
                <div class="social">
                  <a href=""><i class="bi bi-twitter-x"></i></a>
                  <a href=""><i class="bi bi-facebook"></i></a>
                  <a href=""><i class="bi bi-instagram"></i></a>
                  <a href=""><i class="bi bi-linkedin"></i></a>
                </div>
              </div>
            </div>
          </div><!-- End Team Member -->

          <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
            <div class="member">
              <div class="pic"><img src="adimg/chefs/chefs-3.jpg" class="img-fluid" alt=""></div>
              <div class="member-info">
                <h4>Nguyễn Hà Sơn</h4>
                <span>Đầu bếp</span>
                <div class="social">
                  <a href=""><i class="bi bi-twitter-x"></i></a>
                  <a href=""><i class="bi bi-facebook"></i></a>
                  <a href=""><i class="bi bi-instagram"></i></a>
                  <a href=""><i class="bi bi-linkedin"></i></a>
                </div>
              </div>
            </div>
          </div><!-- End Team Member -->

        </div>

      </div>

    </section><!-- /Chefs Section -->

    <!-- Testimonials Section -->
    <section id="testimonials" class="testimonials section dark-background">

      <img src="adimg/testimonials-bg.jpg" class="testimonials-bg" alt="">

      <div class="container" data-aos="fade-up" data-aos-delay="100">

        <div class="swiper init-swiper">
          <script type="application/json" class="swiper-config">
            {
              "loop": true,
              "speed": 600,
              "autoplay": {
                "delay": 5000
              },
              "slidesPerView": "auto",
              "pagination": {
                "el": ".swiper-pagination",
                "type": "bullets",
                "clickable": true
              }
            }
          </script>
          <div class="swiper-wrapper">

            <div class="swiper-slide">
              <div class="testimonial-item">
                <img src="adimg/testimonials/testimonials-1.jpg" class="testimonial-img" alt="">
                <h3>Nguyễn Văn Dũng</h3>
                <h4>Ceo &amp; Founder</h4>
                <div class="stars">
                  <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i
                    class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                </div>
                <p>
                  <i class="bi bi-quote quote-icon-left"></i>
                  <span>Tôi đã có một trải nghiệm tuyệt vời tại khách sạn Thu Cúc. Phòng sạch sẽ, tiện nghi đầy đủ, nhân viên thân thiện và nhiệt tình. Vị trí thuận lợi, dễ dàng di chuyển đến các điểm tham quan. Chắc chắn sẽ quay lại lần sau!</span>
                  <i class="bi bi-quote quote-icon-right"></i>
                </p>
              </div>
            </div><!-- End testimonial item -->

            <div class="swiper-slide">
              <div class="testimonial-item">
                <img src="adimg/testimonials/testimonials-2.jpg" class="testimonial-img" alt="">
                <h3>Nguyễn Hồng Nhung</h3>
                <h4>Nhà thiết kế</h4>
                <div class="stars">
                  <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i
                    class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                </div>
                <p>
                  <i class="bi bi-quote quote-icon-left"></i>
                  <span>Khách sạn sạch sẽ, không gian yên tĩnh, rất phù hợp để nghỉ ngơi. Nhân viên phục vụ chu đáo, thân thiện.</span>
                  <i class="bi bi-quote quote-icon-right"></i>
                </p>
              </div>
            </div><!-- End testimonial item -->

            <div class="swiper-slide">
              <div class="testimonial-item">
                <img src="adimg/testimonials/testimonials-3.jpg" class="testimonial-img" alt="">
                <h3>Nguyễn Hà</h3>
                <h4>Chủ cửa hàng</h4>
                <div class="stars">
                  <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i
                    class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                </div>
                <p>
                  <i class="bi bi-quote quote-icon-left"></i>
                  <span>Dịch vụ tuyệt vời, phòng ốc gọn gàng, đầy đủ tiện nghi. Giá cả hợp lý, rất đáng để trải nghiệm</span>
                  <i class="bi bi-quote quote-icon-right"></i>
                </p>
              </div>
            </div><!-- End testimonial item -->

            <div class="swiper-slide">
              <div class="testimonial-item">
                <img src="adimg/testimonials/testimonials-4.jpg" class="testimonial-img" alt="">
                <h3>Huy Nguyễn</h3>
                <h4>Làm tự do</h4>
                <div class="stars">
                  <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i
                    class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                </div>
                <p>
                  <i class="bi bi-quote quote-icon-left"></i>
                  <span>Vị trí thuận tiện, dễ dàng di chuyển. Nhân viên lễ tân hỗ trợ nhiệt tình, tạo cảm giác thoải mái khi lưu trú.</span>
                  <i class="bi bi-quote quote-icon-right"></i>
                </p>
              </div>
            </div><!-- End testimonial item -->

            <div class="swiper-slide">
              <div class="testimonial-item">
                <img src="adimg/testimonials/testimonials-5.jpg" class="testimonial-img" alt="">
                <h3>Hoàng Khoa</h3>
                <h4>Lập trình viên</h4>
                <div class="stars">
                  <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i
                    class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                </div>
                <p>
                  <i class="bi bi-quote quote-icon-left"></i>
                  <span>Bữa sáng ngon miệng, đa dạng món ăn. Không gian thoáng đãng, mang lại cảm giác thư giãn và dễ chịu.</span>
                  <i class="bi bi-quote quote-icon-right"></i>
                </p>
              </div>
            </div><!-- End testimonial item -->

          </div>
          <div class="swiper-pagination"></div>
        </div>

      </div>

    </section><!-- /Testimonials Section -->

    <!-- Contact Section -->
    <section id="contact" class="contact section">

      <!-- Section Title -->
      <div class="container section-title" data-aos="fade-up">
        <h2>Liên hệ</h2>
        <div><span>Kiểm tra</span> <span class="description-title">liên hệ</span></div>
      </div><!-- End Section Title -->

      <div class="mb-5">
        <iframe style="width: 100%; height: 400px;"
          src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.1234567890!2d105.834567890!3d21.028511234!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135abc123456789%3A0xabcdef1234567890!2sVăn+Miếu+–+Quốc+Tử+Giám!5e0!3m2!1svi!2s!4v1610000000000"
          frameborder="0" allowfullscreen=""></iframe>
      </div><!-- End Google Maps -->

      <div class="container" data-aos="fade">

        <div class="row gy-5 gx-lg-5">

          <div class="col-lg-4">

            <div class="info">
              <h3>Liên hệ ngay</h3>
              <p>Đóng góp cho sự phát triển của Thu Cúc Hotel</p>

              <div class="info-item d-flex">
                <i class="bi bi-geo-alt flex-shrink-0"></i>
                <div>
                  <h4>Vị trí:</h4>
                  <p>Hanoi, Vietnam</p>
                </div>
              </div><!-- End Info Item -->

              <div class="info-item d-flex">
                <i class="bi bi-envelope flex-shrink-0"></i>
                <div>
                  <h4>Email:</h4>
                  <p>hotelbooking@gmail.com</p>
                </div>
              </div><!-- End Info Item -->

              <div class="info-item d-flex">
                <i class="bi bi-phone flex-shrink-0"></i>
                <div>
                  <h4>Gọi ngay:</h4>
                  <p>+84 978 530 698</p>
                </div>
              </div><!-- End Info Item -->

            </div>

          </div>

          <div class="col-lg-8">
            <form action="forms/contact.php" method="post" role="form" class="php-email-form">
              <div class="row">
                <div class="col-md-6 form-group">
                  <input type="text" name="name" class="form-control" id="name" placeholder="Your Name" required="">
                </div>
                <div class="col-md-6 form-group mt-3 mt-md-0">
                  <input type="email" class="form-control" name="email" id="email" placeholder="Your Email" required="">
                </div>
              </div>
              <div class="form-group mt-3">
                <input type="text" class="form-control" name="subject" id="subject" placeholder="Subject" required="">
              </div>
              <div class="form-group mt-3">
                <textarea class="form-control" name="message" placeholder="Message" required=""></textarea>
              </div>
              <div class="my-3">
                <div class="loading">Đang tải</div>
                <div class="error-message"></div>
                <div class="sent-message">Tin nhắn của bạn đã được gửi. Xin cảm ơn!</div>
              </div>
              <div class="text-center"><button type="submit">Gửi tín nhắn</button></div>
            </form>
          </div><!-- End Contact Form -->

        </div>

      </div>

    </section><!-- /Contact Section -->

  </main>

  <footer id="footer" class="footer dark-background">

    <div class="container">
      <div class="row gy-3">
        <div class="col-lg-3 col-md-6 d-flex">
          <i class="bi bi-geo-alt icon"></i>
          <div class="address">
            <h4>Địa chỉ</h4>
            <p>123 Q.Đống Đa</p>
            <p>Hanoi, Vietnam</p>
            <p></p>
          </div>

        </div>

        <div class="col-lg-3 col-md-6 d-flex">
          <i class="bi bi-telephone icon"></i>
          <div>
            <h4>Liên hệ</h4>
            <p>
              <strong>SĐT:</strong> <span>+84 978 530 698</span><br>
              <strong>Email:</strong> <span>bookinghotel@gmail.com</span><br>
            </p>
          </div>
        </div>

        <div class="col-lg-3 col-md-6 d-flex">
          <i class="bi bi-clock icon"></i>
          <div>
            <h4>Giờ mở cửa</h4>
            <p>
              <strong>T2-CN:</strong> <span>0AM - 0PM</span><br>
            </p>
          </div>
        </div>

        <div class="col-lg-3 col-md-6">
          <h4>Theo dõi</h4>
          <div class="social-links d-flex">
            <a href="#" class="twitter"><i class="bi bi-twitter-x"></i></a>
            <a href="#" class="facebook"><i class="bi bi-facebook"></i></a>
            <a href="#" class="instagram"><i class="bi bi-instagram"></i></a>
            <a href="#" class="linkedin"><i class="bi bi-linkedin"></i></a>
          </div>
        </div>

      </div>
    </div>

    <div class="container copyright text-center mt-4">
      <p>© <span>Copyright</span> <strong class="px-1 sitename">ThuCuc</strong> <span>All Rights Reserved</span></p>
      <div class="credits">
      </div>
    </div>

  </footer>

  <!-- Scroll Top -->
  <a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center"><i
      class="bi bi-arrow-up-short"></i></a>

  <!-- Preloader -->
  <div id="preloader"></div>

  <!-- Vendor JS Files -->
  <script src="advendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="advendor/php-email-form/validate.js"></script>
  <script src="advendor/aos/aos.js"></script>
  <script src="advendor/glightbox/js/glightbox.min.js"></script>
  <script src="advendor/imagesloaded/imagesloaded.pkgd.min.js"></script>
  <script src="advendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="advendor/swiper/swiper-bundle.min.js"></script>

  <!-- Main JS File -->
  <script src="adjs/cus_main.js"></script>

</body>

</html>
