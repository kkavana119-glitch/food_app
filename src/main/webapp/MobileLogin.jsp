<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mobile Login</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Arial, Helvetica, sans-serif;
}

body {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	background: linear-gradient(135deg, #ffe0c3, #fff4ec, #ffd6d6);
}

.container {
	width: 420px;
	background: white;
	padding: 35px;
	border-radius: 18px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, .15);
}

h2 {
	text-align: center;
	color: #ff6b00;
	margin-bottom: 25px;
}

label {
	display: block;
	margin-bottom: 8px;
	font-weight: bold;
	color: #333;
}

input {
	width: 100%;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 8px;
	font-size: 16px;
	margin-bottom: 20px;
	outline: none;
}

input:focus {
	border-color: #ff6b00;
	box-shadow: 0 0 8px rgba(255, 107, 0, .3);
}

button {
	width: 100%;
	padding: 13px;
	background: #ff6b00;
	color: white;
	border: none;
	border-radius: 8px;
	font-size: 17px;
	font-weight: bold;
	cursor: pointer;
	transition: .3s;
}

button:hover {
	background: #e65c00;
}
</style>

</head>

<body>

	<div class="container">

		<h2>📱 Mobile OTP Login</h2>

		<form action="SendOTPServlet" method="post">

			<label>Mobile Number</label> <input type="tel" name="phoneNumber"
				placeholder="+91 9876543210" pattern="^\+91[6-9][0-9]{9}$" required>

			<button type="submit">Send OTP</button>

		</form>

	</div>

</body>

</html>