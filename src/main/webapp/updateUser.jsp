<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.food.Model.User"%>

<%
User user = (User) request.getAttribute("user");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update User</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Arial, Helvetica, sans-serif;
}

body {
	background: linear-gradient(135deg, #ffe0c3, #fff4ec, #ffd6d6);
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
}

.container {
	width: 450px;
	background: white;
	padding: 35px;
	border-radius: 18px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, .15);
}

h2 {
	text-align: center;
	color: #ff6b00;
	margin-bottom: 25px;
	font-size: 30px;
}

label {
	display: block;
	margin-top: 15px;
	margin-bottom: 5px;
	font-weight: bold;
	color: #333;
}

input, select {
	width: 100%;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 8px;
	font-size: 15px;
	outline: none;
	transition: .3s;
}

input:focus, select:focus {
	border-color: #ff6b00;
	box-shadow: 0 0 8px rgba(255, 107, 0, .25);
}

button {
	width: 100%;
	padding: 14px;
	margin-top: 30px;
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
	transform: translateY(-2px);
}

.readonly {
	background: #f2f2f2;
}
</style>

</head>

<body>

	<div class="container">

		<h2>Update User</h2>

		<form action="UpdateUserServlet" method="post">

			<input type="hidden" name="userId" value="<%=user.getUserId()%>">

			<label>User ID</label> <input type="text"
				value="<%=user.getUserId()%>" readonly class="readonly"> <label>User
				Name</label> <input type="text" name="userName"
				value="<%=user.getUserName()%>" required> <label>Email</label>

			<input type="email" name="email" value="<%=user.getEmail()%>"
				required> <label>Password</label> <input type="text"
				name="password" value="<%=user.getPassword()%>" required> <label>Role</label>

			<select name="role">

				<option value="Customer"
					<%=user.getRole().equals("Customer") ? "selected" : ""%>>
					Customer</option>

				<option value="Restaurant Owner"
					<%=user.getRole().equals("Restaurant Owner") ? "selected" : ""%>>
					Restaurant Owner</option>

				<option value="Admin"
					<%=user.getRole().equals("Admin") ? "selected" : ""%>>Admin</option>

			</select> <label>Address</label> <input type="text" name="address"
				value="<%=user.getAddress()%>" required>

			<button type="submit">Update User</button>

		</form>

	</div>

</body>

</html>