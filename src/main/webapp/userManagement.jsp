<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.food.Model.User"%>

<%
List<User> userList = (List<User>) request.getAttribute("userList");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Management</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Arial, Helvetica, sans-serif;
}

body {
	background: linear-gradient(135deg, #fff5eb, #ffe4d6, #ffd8cc);
	min-height: 100vh;
	padding: 40px;
}

.container {
	width: 95%;
	margin: auto;
}

.heading {
	text-align: center;
	margin-bottom: 30px;
	color: #ff6b00;
	font-size: 35px;
	font-weight: bold;
}

.card {
	background: white;
	padding: 25px;
	border-radius: 15px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, .15);
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 15px;
}

th {
	background: #ff6b00;
	color: white;
	padding: 15px;
	font-size: 17px;
}

td {
	padding: 14px;
	text-align: center;
	border-bottom: 1px solid #ddd;
}

tr:nth-child(even) {
	background: #fff8f2;
}

tr:hover {
	background: #ffe8d9;
}

.updateBtn {
	background: #28a745;
	color: white;
	padding: 10px 18px;
	border-radius: 8px;
	text-decoration: none;
	font-weight: bold;
	transition: .3s;
}

.updateBtn:hover {
	background: #218838;
}

.role {
	font-weight: bold;
}

.customer {
	color: #0d6efd;
}

.admin {
	color: #dc3545;
}

.owner {
	color: #198754;
}

.footer {
	text-align: center;
	margin-top: 25px;
	color: #666;
	font-size: 15px;
}
</style>

</head>

<body>

	<div class="container">

		<h1 class="heading">👤 User Management</h1>

		<div class="card">

			<table>

				<tr>

					<th>User ID</th>

					<th>User Name</th>

					<th>Email</th>

					<th>Role</th>

					<th>Address</th>

					<th>Created Date</th>

					<th>Last Login</th>

					<th>Action</th>

				</tr>

				<%
				if (userList != null) {

					for (User user : userList) {

						String role = user.getRole();

						String cssClass = "customer";

						if (role.equalsIgnoreCase("Admin")) {

					cssClass = "admin";

						} else if (role.equalsIgnoreCase("Restaurant Owner")) {

					cssClass = "owner";

						}
				%>

				<tr>

					<td><%=user.getUserId()%></td>

					<td><%=user.getUserName()%></td>

					<td><%=user.getEmail()%></td>

					<td><span class="role <%=cssClass%>"> <%=user.getRole()%>

					</span></td>

					<td><%=user.getAddress()%></td>

					<td><%=user.getCreateDate()%></td>

					<td><%=user.getLastLoginDate()%></td>

					<td><a class="updateBtn"
						href="UserManagementServlet?action=edit&userId=<%=user.getUserId()%>">

							Update </a></td>

				</tr>

				<%

          }

          }

         %>

			</table>

		</div>

		<div class="footer">Food Delivery Admin Panel</div>

	</div>

</body>

</html>