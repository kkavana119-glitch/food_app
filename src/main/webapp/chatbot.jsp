<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>FoodieExpress AI Assistant</title>
<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: "Segoe UI", sans-serif;
}

body {
	background: transparent;
}

/* ===========================
        CHAT CONTAINER
=========================== */
.chat-container {
	width: 100%;
	height: 100vh;
	display: flex;
	flex-direction: column;
	background: #ffffff;
	border-radius: 20px;
	overflow: hidden;
}

/* ===========================
            HEADER
=========================== */
.chat-header {
	background: linear-gradient(135deg, #ff5722, #ff784e);
	color: white;
	padding: 18px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.header-left {
	display: flex;
	align-items: center;
	gap: 12px;
}

.bot-avatar {
	width: 55px;
	height: 55px;
	border-radius: 50%;
	background: white;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 28px;
}

.chat-header h2 {
	font-size: 22px;
}

.chat-header span {
	font-size: 13px;
	opacity: .9;
}

.online-dot {
	width: 12px;
	height: 12px;
	background: #00e676;
	border-radius: 50%;
	box-shadow: 0 0 10px #00e676;
}

/* ===========================
         CHAT AREA
=========================== */
.chat-box {
	flex: 1;
	padding: 18px;
	overflow-y: auto;
	background: #f8f9fb;
}

/* ===========================
       MESSAGE STYLE
=========================== */
.message {
	display: flex;
	margin-bottom: 18px;
	align-items: flex-end;
}

.message.bot {
	justify-content: flex-start;
}

.message.user {
	justify-content: flex-end;
}

/* ===========================
        BOT AVATAR
=========================== */
.avatar {
	width: 42px;
	height: 42px;
	border-radius: 50%;
	background: #ff5722;
	color: white;
	display: flex;
	justify-content: center;
	align-items: center;
	margin-right: 10px;
	font-size: 20px;
}

/* ===========================
      CHAT BUBBLES
=========================== */
.bubble {
	max-width: 78%;
	padding: 16px;
	border-radius: 18px;
	font-size: 15px;
	line-height: 1.7;
	box-shadow: 0 4px 12px rgba(0, 0, 0, .08);
}

.bot .bubble {
	background: white;
	color: #333;
	border-bottom-left-radius: 5px;
}

.user .bubble {
	background: #ff5722;
	color: white;
	border-bottom-right-radius: 5px;
}

/* ===========================
      WELCOME MESSAGE
=========================== */
.bubble h3 {
	color: #ff5722;
	margin-bottom: 10px;
}

.bubble ul {
	margin-top: 12px;
	margin-left: 20px;
}

.bubble li {
	margin: 6px 0;
}

/* ===========================
     SUGGESTION BUTTONS
=========================== */
.suggestions {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
	margin-top: 15px;
}

.suggestions span {
	background: #fff3ef;
	color: #ff5722;
	border: 1px solid #ff5722;
	padding: 8px 14px;
	border-radius: 30px;
	font-size: 13px;
	font-weight: 600;
}

/* ===========================
      TYPING AREA
=========================== */
.typing {
	display: none;
	padding: 10px 18px;
	align-items: center;
	gap: 10px;
	background: white;
}

.typing-bubble {
	background: #ececec;
	border-radius: 20px;
	padding: 10px 18px;
}

.typing-bubble span {
	width: 8px;
	height: 8px;
	margin: 0 2px;
	background: #888;
	border-radius: 50%;
	display: inline-block;
	animation: typing 1.3s infinite;
}

.typing-bubble span:nth-child(2) {
	animation-delay: .2s;
}

.typing-bubble span:nth-child(3) {
	animation-delay: .4s;
}

@
keyframes typing { 0%{
	transform: translateY(0);
	opacity: .4;
}

50
%
{
transform
:
translateY(
-5px
);
opacity
:
1;
}
100
%
{
transform
:
translateY(
0
);
opacity
:
.4;
}
}

/* ===========================
        INPUT AREA
=========================== */
.chat-input {
	display: flex;
	padding: 15px;
	background: white;
	border-top: 1px solid #ddd;
}

.chat-input input {
	flex: 1;
	padding: 14px 18px;
	border: 1px solid #ddd;
	border-radius: 30px;
	outline: none;
	font-size: 15px;
}

.chat-input input:focus {
	border-color: #ff5722;
}

.send-btn{

    width:52px;

    height:52px;

    margin-left:10px;

    border:none;

    border-radius:50%;

    background:linear-gradient(135deg,#ff6b35,#ff3d00);

    color:white;

    display:flex;

    justify-content:center;

    align-items:center;

    cursor:pointer;

    transition:.3s;

    box-shadow:0 5px 15px rgba(255,87,34,.35);

}

.send-btn:hover{

    transform:scale(1.08);

    box-shadow:0 8px 20px rgba(255,87,34,.45);

}

.send-btn i{

    font-size:20px;

}

/* ===========================
       SCROLLBAR
=========================== */
.chat-box::-webkit-scrollbar {
	width: 6px;
}

.chat-box::-webkit-scrollbar-thumb {
	background: #ff5722;
	border-radius: 20px;
}
</style>

</head>

<body>

	<div class="chat-container">

		<!-- Header -->
		<div class="chat-header">

			<div class="header-left">

				<div class="bot-avatar">🤖</div>

				<div>

					<h2>FoodieExpress AI</h2>

					<span>Your Food Ordering Assistant</span>

				</div>

			</div>

			<div class="online-dot"></div>

		</div>


		<!-- Chat Messages -->
		<div class="chat-box" id="chatBox">

			<!-- Welcome Message -->

			<div class="message bot">

				<div class="avatar">🤖</div>

				<div class="bubble">

					<h3>👋 Hello!</h3>

					<p>
						Welcome to <b>FoodieExpress</b>. I can help you with:
					</p>

					<ul>

						<li>🍕 Show Pizza</li>

						<li>🍔 Show Burger</li>

						<li>🍗 Show Chicken</li>

						<li>🍜 Show Chinese</li>

						<li>🍰 Show Desserts</li>

						<li>📋 Show Menu</li>

					</ul>

					<p>💡 Try typing:</p>

					<div class="suggestions">

						<span>show pizza</span> <span>show menu</span> <span>recommend
							burger</span>

					</div>

				</div>

			</div>

		</div>


		<!-- Typing Animation -->

		<div class="typing" id="typing">

			<div class="avatar">🤖</div>

			<div class="typing-bubble">

				<span></span> <span></span> <span></span>

			</div>

		</div>


		<!-- Input Area -->

		<div class="chat-input">

			<input type="text" id="message" placeholder="Ask me about food...">

			<button onclick="sendMessage()" class="send-btn">
				<i class="fa-solid fa-paper-plane"></i>
			</button>

		</div>

	</div>

	<script src="https://kit.fontawesome.com/6b0f91df1b.js"
		crossorigin="anonymous"></script>

	<script src="JavaScript/chatbot.js"></script>

</body>
</html>