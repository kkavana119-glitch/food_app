<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Verify OTP</title>

<%
String error = (String) request.getAttribute("error");
if (error != null) {
%>

<p style="color: red; text-align: center; font-weight: bold;">
	<%=error%>
</p>

<%
}
%>

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

p {
	text-align: center;
	color: #555;
	margin-bottom: 20px;
}

label {
	display: block;
	margin-bottom: 8px;
	font-weight: bold;
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
	border: none;
	border-radius: 8px;
	background: #ff6b00;
	color: white;
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

		<h2>OTP Verification</h2>

		<p>Please enter the 6-digit OTP sent to your mobile number.</p>

		<form action="VerifyOTPServlet" method="post">

			<label>Enter OTP</label> <input type="text" name="otp"
				placeholder="Enter 6-digit OTP" pattern="[0-9]{6}" maxlength="6"
				required>

			<button type="submit">Verify OTP</button>

		</form>

	</div>

</body>

</html>