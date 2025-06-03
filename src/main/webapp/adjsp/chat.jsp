<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Chat Gemini AI</title>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui-touch-punch/0.2.3/jquery.ui.touch-punch.min.js"></script>
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
            bottom: 20px;
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
<body class="p-3">
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
</body>
</html>