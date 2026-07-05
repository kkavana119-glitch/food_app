<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.food.Model.Orders"%>

<%
List<Orders> ordersList = (List<Orders>) request.getAttribute("ordersList");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>My Orders | FoodieExpress</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<link
	href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<link rel="stylesheet" href="orderhistory.css">

</head>

<body>

	<div class="container">

		<!-- Header -->

		<div class="page-header">

			<div>

				<h1>
					<i class="fa-solid fa-bag-shopping"></i> My Orders
				</h1>

				<p>View all your previous food orders.</p>

			</div>

			<a href="home.jsp" class="home-btn"> <i
				class="fa-solid fa-house"></i> Continue Shopping
			</a>

		</div>


		<%
		if (ordersList != null && !ordersList.isEmpty()) {
		%>

		<div class="orders-container">

			<%
			for (Orders order : ordersList) {
			%>

			<div class="order-card">

				<div class="order-top">

					<div>

						<h2>
							Order #ORD<%=order.getOrdersId()%>
						</h2>

						<p>

							<i class="fa-regular fa-calendar"></i>

							<%=order.getOrdersDate()%>

						</p>

					</div>

					<div>

						<%
						String status = order.getStatus();

						String cssClass = "pending";

						if (status.equalsIgnoreCase("Delivered")) {
							cssClass = "delivered";
						} else if (status.equalsIgnoreCase("Preparing")) {
							cssClass = "preparing";
						} else if (status.equalsIgnoreCase("Cancelled")) {
							cssClass = "cancelled";
						}
						%>

						<span class="status <%=cssClass%>"> <%=status%>

						</span>

					</div>

				</div>



				<div class="details-grid">

					<div class="detail-box">

						<i class="fa-solid fa-money-bill-wave"></i>

						<div>

							<h4>Total Amount</h4>

							<p>

								₹<%=String.format("%.2f", order.getTotalAmount())%>

							</p>

						</div>

					</div>



					<div class="detail-box">

						<i class="fa-solid fa-wallet"></i>

						<div>

							<h4>Payment</h4>

							<p>

								<%=order.getPaymentMethod()%>
							</p>
						</div>
					</div>



					<div class="detail-box">
						<i class="fa-solid fa-store"></i>
						<div>
							<h4>Restaurant ID</h4>

							<p>

								<%=order.getRestaurantId()%>

							</p>
						</div>
					</div>
				</div>

				<div class="button-area">

					<a href="OrderDetailsServlet?ordersId=<%=order.getOrdersId()%>"
						class="view-btn"> <i class="fa-solid fa-eye"></i> View Details

					</a>

				</div>

			</div>

			<%
			}
			%>

		</div>

		<%
		} else {
		%>

		<div class="empty-orders">

			<i class="fa-solid fa-box-open"></i>

			<h2>No Orders Yet</h2>

			<p>Looks like you haven't placed any orders.</p>

			<a href="home.jsp"> Start Ordering </a>

		</div>

		<%
}
%>

	</div>

</body>
</html>