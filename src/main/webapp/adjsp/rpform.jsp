<%@page import="controller.Error_formController"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
	<%@include file="/adjsp/lib/header.jsp"%>
	<%@include file="/adjsp/lib/sidebar.jsp"%>
<body>
		
<main id="main" class="main">

    <div class="pagetitle">
        <h1>Gửi biểu mẫu đóng góp</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/home">Trang chủ</a></li>
                <li class="breadcrumb-item active">Gửi biểu mẫu đóng góp</li>
            </ol>
        </nav>
    </div>

    <section class="section">
        <div class="row">
            <div class="col-lg-12">

                <div class="card">
                    <div class="card-body p-4">	                        
						<div class="card mt-4 border rounded shadow-sm bg-light"> 
						    <div class="card-body">
						        <h5 class="card-title mb-3">
						            <i class="bi bi-qr-code-scan me-2"></i>Truy cập bằng mã QR
						        </h5>
						
						        <div class="row g-3 align-items-end">
						            <div class="col-md-4">
						                <label for="type_file" class="form-label fw-semibold">
						                    <i class="bi bi-filetype-pdf me-1"></i>Chọn biểu mẫu
						                </label>
						                <select class="form-select" id="type_file" onchange="updateLink()">
						                    <option value="err1">Lỗi cơ sở dữ liệu</option>
						                    <option value="err2">Chức năng</option>
						                    <option value="err3">Bổ sung tính năng</option>
						                    <option value="err4">Khác</option>
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
						            <div class="col-md-6">
						            	<input type="text" id="url_form" class="form-control form-control-sm mt-2" readonly/>
									</div>
									<div class="col-md-2">
										<button
											class="btn btn-sm btn-primary d-flex align-items-center gap-1 px-2 py-1"
											onclick="copyLink()" type="button" title="Sao chép liên kết">
											<i class="bi bi-clipboard"></i>
										</button>
									</div>
						        </div>
						    </div>
						</div>

                    </div>
                </div>	
            </div>
        </div>
    </section>
</main>

</body>

<!-- SCRIPT -->
<script>
	const errorLinkMap = {
		err1: "<%= Error_formController.getLinkErr1() %>",
		err2: "<%= Error_formController.getLinkErr2() %>",
		err3: "<%= Error_formController.getLinkErr3() %>",
		err4: "<%= Error_formController.getLinkErr4() %>"
	};

	function updateLink() {
		const selectedType = document.getElementById("type_file").value;
		const link = errorLinkMap[selectedType] || "";
		document.getElementById("url_form").value = link;
	}

	function gen_qr() {
		const link = document.getElementById("type_file").value;
		if (!link) return;

		const qrUrl = "qr?text=" + encodeURIComponent(link);
		document.getElementById("qr_img").src = qrUrl + "&t=" + new Date().getTime(); // chống cache
	}

	function copyLink() {
		const copyText = document.getElementById("url_form");
		if (!copyText.value) return;

		navigator.clipboard.writeText(copyText.value).then(() => {
		}).catch(() => {
			alert("Không thể sao chép. Trình duyệt không hỗ trợ.");
		});
	}

	// Gọi lần đầu để hiện link ngay khi tải trang (nếu cần)
	window.onload = updateLink;
</script>
<!-- END SCRIPT -->

<%@include file="/adjsp/lib/footer.jsp"%>
</html>
