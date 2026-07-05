<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.food.Model.Orders"%>
<%@ page import="com.food.Model.Cart"%>
<%@ page import="com.food.Model.CartItem"%>
<%@ page import="com.food.Model.Restaurant"%>
<%@ page import="com.food.Model.User"%>

<%
Orders orders = (Orders)session.getAttribute("currentOrder");
Cart cart = (Cart)session.getAttribute("orderedItems");
Restaurant restaurant = (Restaurant)session.getAttribute("restaurant");
User user = (User)session.getAttribute("user");

String address = (String)session.getAttribute("deliveryAddress");
String city = (String)session.getAttribute("deliveryCity");
String pincode = (String)session.getAttribute("deliveryPincode");
%>


<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Order Confirmed | FoodieExpress</title>
<link
	href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
<link rel="stylesheet" href="orderconfirmation.css" />
</head>
<body>
	<div class="container">
		<div class="success-card">
			<div class="checkmark-wrapper">
				<div class="checkmark-circle">
					<i class="fa-solid fa-check"></i>
				</div>
				<div class="pulse-ring"></div>
			</div>
			<h1>Order Confirmed!</h1>
			<p>Thank you for your order. Your delicious food is now being
				prepared with love and care.</p>
		</div>

		<div class="main-grid">
			<div class="left-column">
				<div class="card timeline-card">
					<div class="card-header">
						<div class="icon-box">
							<i class="fa-solid fa-truck-fast"></i>
						</div>
						<h2>Track Your Order</h2>
					</div>

					<div class="timeline">
						<div class="step active">
							<div class="circle">
								<i class="fa-solid fa-receipt"></i>
							</div>
							<div class="step-content">
								<span>Ordered</span> <small>Confirmed</small>
							</div>
						</div>

						<div class="line active"></div>

						<div class="step active current">
							<div class="circle">
								<i class="fa-solid fa-utensils"></i>
							</div>
							<div class="step-content">
								<span>Preparing</span> <small>In the kitchen</small>
							</div>
						</div>

						<div class="line"></div>

						<div class="step">
							<div class="circle">
								<i class="fa-solid fa-motorcycle"></i>
							</div>
							<div class="step-content">
								<span>On the Way</span> <small>Out for delivery</small>
							</div>
						</div>

						<div class="line"></div>

						<div class="step">
							<div class="circle">
								<i class="fa-solid fa-house"></i>
							</div>
							<div class="step-content">
								<span>Delivered</span> <small>Enjoy your meal!</small>
							</div>
						</div>
					</div>
				</div>

				<div class="card restaurant-card">
					<img src="<%= restaurant.getImagePath() %>"
						alt="<%= restaurant.getRestaurantName() %>" />
					<div class="restaurant-details">
						<span class="status-badge"><span
							class="dot"></span> <%= orders.getStatus() %></span>
						<h2><%= restaurant.getRestaurantName() %></h2>
						<p>
							<i class="fa-solid fa-location-dot"></i>
							<%= restaurant.getAddress() %>
						</p>
					</div>
				</div>

				<div class="card details-card">
					<div class="card-header">
						<div class="icon-box">
							<i class="fa-solid fa-circle-info"></i>
						</div>
						<h2>Delivery Details</h2>
					</div>

					<div class="row">
						<span>Order ID</span> <strong>#ORD<%= orders.getOrdersId() %></strong>
					</div>
					<div class="row">
						<span>Order Date</span> <strong><%= orders.getOrdersDate() %></strong>
					</div>
					<div class="row">
						<span>Payment Mode</span> <strong><%= orders.getPaymentMethod() %></strong>
					</div>
					<div class="row">
						<span>Estimated Delivery</span> <strong class="highlight-text">30
							- 40 mins</strong>
					</div>
				</div>

				<div class="card address-card">
					<div class="card-header">
						<div class="icon-box">
							<i class="fa-solid fa-map-pin"></i>
						</div>
						<h2>Delivery Address</h2>
					</div>
					<div class="address-content">
						<h5><%=user.getUserName() %></h5>
						<p><%= address %></p>
						<p><%= city %> - <%= pincode %></p>
					</div>
				</div>
			</div>

			<div class="right-column">
				<div class="card summary-card">
					<div class="card-header">
						<div class="icon-box">
							<i class="fa-solid fa-basket-shopping"></i>
						</div>
						<h2>Order Summary</h2>
					</div>

					<div class="item-list">
						<%
            for(CartItem item : cart.getItems().values()) {
            %>

						<div class="item">
							<div class="item-info">
								<h4><%= item.getName() %></h4>
								<p>
									Qty:
									<%= item.getQuantity() %></p>
							</div>
							<span class="price">₹<%= item.getTotalPrice() %></span>
						</div>

						<%
              }
              %>


					</div>

					<%
				double itemTotal = 0;
				
				for(CartItem item : cart.getItems().values()){
				    itemTotal += item.getTotalPrice();
				}
				
				double deliveryFee = 40;
				double packagingFee = 20;
				double grandTotal = itemTotal + deliveryFee + packagingFee;
				%>

					<div class="bill-breakdown">
						<div class="bill-row">
							<span>Item Total</span> <span>₹<%= itemTotal %></span>
						</div>
						<div class="bill-row">
							<span>Delivery Fee</span> <span class="free-text">₹<%= deliveryFee %></span>
						</div>
						<div class="bill-row">
							<span>Packaging Fee</span> <span>₹<%= packagingFee %></span>
						</div>
						<div class="bill-row total-row">
							<span>Total Amount</span> <span>₹<%= grandTotal %></span>
						</div>
					</div>
				</div>

				<div class="action-wrapper">
					<a href="OrderHistoryServlet" class="btn btn-primary"> <i
						class="fa-solid fa-location-crosshairs"></i> My Orders
					</a> <a href="home.jsp" class="btn btn-secondary"> <i
						class="fa-solid fa-house"></i> Continue Shopping
					</a>
				</div>
			</div>
		</div>

		<footer class="footer">
			<p>
				Made with ❤️ by <strong>FoodieExpress</strong>
			</p>
		</footer>
	</div>
</body>
</html>
