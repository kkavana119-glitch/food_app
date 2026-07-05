<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.food.Model.Orders"%>

<%
List<Orders> orderList = (List<Orders>) request.getAttribute("orderList");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Management</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Arial, Helvetica, sans-serif;
}

body {
	background: #f4f6f9;
}

.container {
	width: 95%;
	margin: 40px auto;
}

h1 {
	text-align: center;
	margin-bottom: 30px;
	color: #ff6b00;
}

.card {
	background: white;
	padding: 25px;
	border-radius: 12px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, .15);
}

table {
	width: 100%;
	border-collapse: collapse;
	overflow: hidden;
	border-radius: 10px;
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

tr:hover {
	background: #fff4eb;
}

.editBtn {
	background: #28a745;
	padding: 10px 18px;
	color: white;
	text-decoration: none;
	border-radius: 6px;
	font-weight: bold;
	transition: .3s;
}

.editBtn:hover {
	background: #218838;
}

.pending {
	color: #ff9800;
	font-weight: bold;
}

.preparing {
	color: #2196f3;
	font-weight: bold;
}

.delivered {
	color: green;
	font-weight: bold;
}

.cancelled {
	color: red;
	font-weight: bold;
}
</style>

</head>

<body>

	<div class="container">

		<h1>📦 Order Management</h1>

		<div class="card">

			<table>

				<tr>

					<th>Order ID</th>
					<th>User ID</th>
					<th>Restaurant ID</th>
					<th>Order Date</th>
					<th>Total Amount</th>
					<th>Status</th>
					<th>Payment</th>
					<th>Action</th>

				</tr>

				<%
				for (Orders order : orderList) {

					String status = order.getStatus();
				%>

				<tr>

					<td><%=order.getOrdersId()%></td>

					<td><%=order.getUserId()%></td>

					<td><%=order.getRestaurantId()%></td>

					<td><%=order.getOrdersDate()%></td>

					<td>₹ <%=order.getTotalAmount()%></td>

					<td><span class="<%=status.toLowerCase()%>"> <%=status%>

					</span></td>

					<td><%=order.getPaymentMethod()%></td>

					<td><a class="editBtn"
						href="OrderManagementServlet?action=edit&ordersId=<%=order.getOrdersId()%>">

							Update </a></td>

				</tr>

				<%

}

%>

			</table>

		</div>

	</div>

</body>

</html>