<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.food.Model.Orders"%>

<%
Orders order = (Orders) request.getAttribute("order");
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Update Order</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Arial;
}

body{
    margin:0;
    padding:0;
    font-family:Arial, Helvetica, sans-serif;

    background: linear-gradient(
        135deg,
        #ffb37a 0%,
        #ffd8b5 25%,
        #fff7f0 50%,
        #ffe4e6 75%,
        #ffc1cc 100%
    );

    display:flex;
    justify-content:center;
    align-items:center;
    min-height:100vh;
}
.card {
	background: white;
	width: 420px;
	padding: 35px;
	border-radius: 15px;
	box-shadow: 0 8px 25px rgba(0, 0, 0, .3);
}

h2 {
	text-align: center;
	margin-bottom: 25px;
	color: #ff6b00;
}

label {
	display: block;
	margin-top: 15px;
	font-weight: bold;
}

input, select {
	width: 100%;
	padding: 12px;
	margin-top: 6px;
	border: 1px solid #ccc;
	border-radius: 8px;
	font-size: 15px;
}

input[readonly] {
	background: #f2f2f2;
}

button {
	margin-top: 25px;
	width: 100%;
	padding: 14px;
	background: #ff6b00;
	border: none;
	color: white;
	font-size: 17px;
	border-radius: 8px;
	cursor: pointer;
	transition: .3s;
}

button:hover {
	background: #e65c00;
}
</style>

</head>

<body>

	<div class="card">

		<h2>Update Order</h2>

		<form action="UpdateOrderServlet" method="post">

			<input type="hidden" name="ordersId" value="<%=order.getOrdersId()%>">

			<input type="hidden" name="userId" value="<%=order.getUserId()%>">

			<input type="hidden" name="restaurantId"
				value="<%=order.getRestaurantId()%>"> <input type="hidden"
				name="paymentMethod" value="<%=order.getPaymentMethod()%>">

			<label>Order ID</label> <input type="text"
				value="<%=order.getOrdersId()%>" readonly> <label>Total
				Amount</label> <input type="text" name="totalAmount"
				value="<%=order.getTotalAmount()%>" readonly> <label>Status</label>

			<select name="status">

				<option <%=order.getStatus().equals("Pending") ? "selected" : ""%>>Pending</option>

				<option <%=order.getStatus().equals("Preparing") ? "selected" : ""%>>Preparing</option>

				<option
					<%=order.getStatus().equals("Out for Delivery") ? "selected" : ""%>>Out
					for Delivery</option>

				<option <%=order.getStatus().equals("Delivered") ? "selected" : ""%>>Delivered</option>

				<option <%=order.getStatus().equals("Cancelled") ? "selected" : ""%>>Cancelled</option>

			</select>

			<button type="submit">Update Order</button>

		</form>

	</div>

</body>

</html>