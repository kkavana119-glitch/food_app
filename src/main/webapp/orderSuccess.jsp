<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Success</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Arial, Helvetica, sans-serif;
}

body {
	height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
	background: linear-gradient(135deg, #d4fc79, #96e6a1);
}

.container {
	text-align: center;
	background: white;
	padding: 50px 40px;
	border-radius: 20px;
	box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
	width: 420px;
	animation: pop 0.6s ease-in-out;
}

@
keyframes pop {from { transform:scale(0.8);
	opacity: 0;
}

to {
	transform: scale(1);
	opacity: 1;
}

}
.success-icon {
	font-size: 70px;
	color: #28a745;
	margin-bottom: 15px;
}

h1 {
	color: #28a745;
	margin-bottom: 10px;
}

p {
	color: #555;
	margin-bottom: 20px;
	font-size: 15px;
}

.details {
	background: #f8f9fa;
	padding: 15px;
	border-radius: 10px;
	margin-bottom: 20px;
	font-size: 14px;
	color: #333;
}

.btn {
	display: inline-block;
	padding: 12px 20px;
	margin: 8px;
	border-radius: 8px;
	text-decoration: none;
	font-weight: bold;
	transition: 0.3s;
}

.home-btn {
	background: #28a745;
	color: white;
}

.home-btn:hover {
	background: #218838;
}

.order-btn {
	background: #007bff;
	color: white;
}

.order-btn:hover {
	background: #0056b3;
}
</style>

</head>

<body>

	<div class="container">

		<div class="success-icon">✔</div>

		<h1>Order Placed Successfully!</h1>

		<p>Thank you for your payment. Your order has been confirmed.</p>

		<div class="details">
			<p>
				<strong>Status:</strong> Payment Successful
			</p>
			<p>
				<strong>Message:</strong> Your food will be prepared soon 🍔
			</p>
		</div>

		<a href="home.jsp" class="btn home-btn">Go to Home</a> <a
			href="orders.jsp" class="btn order-btn">View Orders</a>

	</div>

</body>
</html>