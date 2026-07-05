<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
    session.invalidate();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logout</title>

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
	padding: 40px;
	border-radius: 18px;
	text-align: center;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
}

.icon {
	font-size: 70px;
	margin-bottom: 15px;
}

h2 {
	color: #ff6b00;
	margin-bottom: 15px;
}

p {
	color: #555;
	font-size: 17px;
	margin-bottom: 30px;
	line-height: 25px;
}

a {
	display: inline-block;
	text-decoration: none;
	background: #ff6b00;
	color: white;
	padding: 12px 28px;
	border-radius: 8px;
	font-size: 16px;
	font-weight: bold;
	transition: 0.3s;
}

a:hover {
	background: #e65c00;
}
</style>

<meta http-equiv="refresh" content="3;url=Login.jsp">

</head>

<body>

	<div class="container">

		<div class="icon">👋</div>

		<h2>Logged Out Successfully</h2>

		<p>
			Thank you for using the Food Delivery System.<br> You have been
			logged out successfully.
		</p>

		<a href="login.html">Login Again</a>

	</div>

</body>
</html>