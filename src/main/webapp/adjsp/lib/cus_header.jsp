<%@page import="model.account"%>
<%@page import="model.user"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <title>Khách sạn Thu Cúc</title>
  <meta name="description" content="">
  <meta name="keywords" content="">

  <!-- Favicons -->
  <link href="adimg/logo.png" rel="icon">
  <link href="adimg/logo.png" rel="apple-touch-icon">

  <!-- Fonts -->
  <link href="https://fonts.googleapis.com" rel="preconnect">
  <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
  <link
    href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Satisfy:wght@400&display=swap"
    rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="advendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="advendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="advendor/aos/aos.css" rel="stylesheet">
  <link href="advendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="advendor/swiper/swiper-bundle.min.css" rel="stylesheet">
  
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui-touch-punch/0.2.3/jquery.ui.touch-punch.min.js"></script>

  <!-- Main CSS File -->
  <link href="adcss/cus_main.css" rel="stylesheet">
  
  <style>
        #chatOutput {
            height: 300px;
            overflow-y: auto;
            border: 1px solid #ddd;
            padding: 10px;
            background-color: #fafafa;
        }
        .chat-msg {
            max-width: 70%;
            margin: 5px 10px;
            padding: 8px 12px;
            border-radius: 15px;
            clear: both;
            font-size: 14px;
            word-wrap: break-word;
        }
        .chat-user {
            background-color: #DCF8C6;
            float: right;
            text-align: right;
        }
        .chat-ai {
            background-color: #F1F0F0;
            float: left;
            text-align: left;
        }
        .modal-dialog {
            cursor: pointer;
        }
        #dragBtn {
            position: fixed;
            bottom: 50px;
            right: 5px;
            z-index: 2000;
            user-select: none;
            width: 60px;     
		    height: 60px;
		    border-radius: 50%;    
		    overflow: hidden;     
		    padding: 0;             
		    border: none;         
		    cursor: pointer;
		    display: flex;
		    align-items: center;
		    justify-content: center;
        }
        #dragBtn img {
		    width: 100%;
		    height: 100%;
		    object-fit: cover;
		    border-radius: 50%;
		    display: block;
		}
    </style>
</head>

<body class="index-page">
	
	<%
	user u = (user) session.getAttribute("user");
	account acc = (account) session.getAttribute("account");

	if (acc == null) {
		response.sendRedirect(request.getContextPath() + "/login");
		return;
	}
	if (acc.getRole_id() == 1) {
		response.sendRedirect(request.getContextPath() + "/home");
		return;
	}
	%>
	<header id="header" class="header fixed-top">

    <div class="topbar d-flex align-items-center">
      <div class="container d-flex justify-content-end justify-content-md-between">
        <div class="contact-info d-flex align-items-center">
          <i class="bi bi-phone d-flex align-items-center d-none d-lg-block"><span>+84 978 530 698</span></i>
          <i class="bi bi-clock ms-4 d-none d-lg-flex align-items-center"><span>T2-T7: 8:00 AM - 23:00 PM</span></i>
        </div>
      </div>
    </div><!-- End Top Bar -->

    <div class="branding d-flex align-items-cente">

      <div class="container position-relative d-flex align-items-center justify-content-between">
        <a href="<%=request.getContextPath() %>/trangchu" class="logo d-flex align-items-center">
          <h1 class="sitename" style="font-family: 'Satisfy', sans-serif;">ThuCucHotel</h1>
        </a>

        <nav id="navmenu" class="navmenu">
          <ul>
            <li><a href="#hero" class="active">Trang chủ</a></li>
            <li><a href="#about">Giới thiệu</a></li>
            <li><a href="#why-us">Nổi bật</a></li>
            <li><a href="#hotels">Phòng</a></li>
            <li><a href="#specials">Ưu đãi</a></li>
            <li><a href="#chefs">Phục vụ</a></li>
            <li><a href="#contact">Liên hệ</a></li>
            <li class="dropdown"><a href="#"><span>Hỗ trợ</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
              <ul>
                <li><a href="#">Trung tâm hỗ trợ</a></li>
                <li class="dropdown"><a href="#"><span>Nhiều hơn</span> <i
                      class="bi bi-chevron-down toggle-dropdown"></i></a>
                  <ul>
                    <li><a href="#">Lựa chọn 1</a></li>
                    <li><a href="#">Lựa chọn 2</a></li>
                    <li><a href="#">Lựa chọn 3</a></li>
                    <li><a href="#">Lựa chọn 4</a></li>
                    <li><a href="#">Lựa chọn 5</a></li>
                  </ul>
                </li>
                <li><a href="#">Chat trực tiếp</a></li>
                <li><a href="#">Gọi hỗ trợ</a></li>
                <li><a href="logout">Đăng xuất</a></li>
              </ul>
            </li>
          </ul>
          <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
        </nav>

      </div>

    </div>
    
    <button id="dragBtn" class="btn btn-dark">
    	<img src="adimg/chatbot.jpg">
    </button>
    <div class="modal fade" id="chatModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Chat với Gemini AI</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body d-flex flex-column">
                    <div id="chatOutput" class="mb-2 flex-grow-1"></div>
                    <textarea id="userInput" class="form-control" rows="2" placeholder="Nhập câu hỏi..."></textarea>
                </div>
                <div class="modal-footer">
                    <button id="sendBtn" class="btn btn-success" onclick="send()">Gửi</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        const chatOutput = document.getElementById('chatOutput');
        const userInput = document.getElementById('userInput');
        const sendBtn = document.getElementById('sendBtn');

        function appendAiMessage(text) {
            const newDivAI = document.createElement("div");
            newDivAI.className = "chat-msg chat-ai";
            newDivAI.innerText = text;
            chatOutput.appendChild(newDivAI);
            chatOutput.scrollTop = chatOutput.scrollHeight;
        }

        function send() {
            var text = userInput.value;
            if (!text) return;
            const newDivUser = document.createElement("div");
            newDivUser.className = "chat-msg chat-user";
            newDivUser.innerText = text;
            chatOutput.appendChild(newDivUser);
            chatOutput.scrollTop = chatOutput.scrollHeight;
            userInput.value = '';
            userInput.disabled = true;
            sendBtn.disabled = true;
            fetch('<%= request.getContextPath() %>/chatgemini', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'question=' + encodeURIComponent(text)
            })
            .then(res => res.text())
            .then(answer => {
                appendAiMessage(answer);
            })
            .catch(err => {
                appendAiMessage('Lỗi kết nối hoặc API');
            })
            .finally(() => {
                userInput.disabled = false;
                sendBtn.disabled = false;
                userInput.focus();
            });
        }

        $(function() {
            $('#chatModal').on('shown.bs.modal', function() {
                $(this).find('.modal-dialog').draggable({
                    handle: ".modal-header"
                });
            });
            $('#dragBtn').draggable({
                containment: 'body',
                zIndex: 2000,
                cursor: 'move'
            });
            console.log('Draggable initialized on #dragBtn');
            $('#dragBtn').on('click', function() {
                const myModal = new bootstrap.Modal(document.getElementById('chatModal'));
                myModal.show();
            });
        });
    </script>

  </header>
