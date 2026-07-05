<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.food.Model.Cart, com.food.Model.CartItem"%>

<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Secure Checkout - FoodieExpress</title>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght=300;400;500;600;700&display=swap"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
<link rel="stylesheet" href="cart.css" />
</head>
<body>
	<header class="app-header">
		<div class="logo" onclick="window.location.href = 'homepage.html'"
			style="cursor: pointer">
			<i class="fa-solid fa-burger"></i> FoodieExpress
		</div>

		<%
		Cart cart = (Cart) session.getAttribute("cart");
		%>

		<!-- 	<nav>
			<ul>
				<li><a href="homepage.html">Home</a></li>   
				<li><a href="#">Restaurants</a></li>    
				<li><a href="#">Offers</a></li>    
				<li><a href="#">Sign in</a></li>
			</ul>
		</nav>    -->

		<div class="user-actions">
			<div class="cart-widget active-cart">
				<i class="fa-solid fa-basket-shopping"></i> <span class="cart-badge">
					<%=cart != null ? cart.getItems().size() : 0%></span>
			</div>
			<img
				src="Images/kavana.jpg"
				alt="User Profile" class="profile-avatar" />
		</div>
	</header>

	<main class="cart-layout-body">
		<div class="cart-container">
			<section class="cart-items-section">
				<h2>
					Secure Checkout <span class="item-count"> (<%=cart != null ? cart.getItems().size() : 0%>
						Items)
					</span>
				</h2>

				<%
				Integer restaurantId = (Integer) session.getAttribute("restaurantId");

				if (cart != null && !cart.getItems().isEmpty()) {
				%>

				<%
				for (CartItem item : cart.getItems().values()) {
				%>

				<div class="cart-item-card">
					<div class="item-img-pane">
						<img src="<%=item.getImagePath()%>" alt="<%=item.getName()%>" />
					</div>


					<div class="item-details-pane">
						<!-- 	 <div class="item-category">
							<i class="fa-solid fa-square-caret-up veg-icon"></i> Italian •
							Pizza
						</div>   -->
						<h4 class="item-title"><%=item.getName()%></h4>
						<!-- 	<p class="item-desc">Fresh paneer cubes, crisp capsicum,
							onions, and spicy red paprika with signature pan sauce.</p>    -->
					</div>
					<div class="item-actions-pane">
						<div class="quantity-controller">

							<form action="cartServlet" method="post">
								<input type="hidden" name="menuId" value="<%=item.getMenuId()%>">
								<input type="hidden" name="restaurantId"
									value="<%=restaurantId%>">

								<%
								if (item.getQuantity() - 1 <= 0) {
								%>
								<input type="hidden" name="action" value="delete">
								<%
								} else {
								%>
								<input type="hidden" name="action" value="update"> <input
									type="hidden" name="quantity"
									value="<%=item.getQuantity() - 1%>">
								<%
								}
								%>

								<button type="submit" class="qty-btn">-</button>
							</form>

							<span class="qty-display"><%=item.getQuantity()%></span>


							<form action="cartServlet" method="post">
								<input type="hidden" name="menuId" value="<%=item.getMenuId()%>">
								<input type="hidden" name="restaurantId"
									value="<%=restaurantId%>"> <input type="hidden"
									name="action" value="update"> <input type="hidden"
									name="quantity" value="<%=item.getQuantity() + 1%>">

								<button type="submit" class="qty-btn">+</button>

							</form>

						</div>
						<div class="item-price">
							₹<%=item.getPrice() * item.getQuantity()%>
						</div>

						<form action="cartServlet" method="post">

							<input type="hidden" name="menuId" value="<%=item.getMenuId()%>">
							<input type="hidden" name="restaurantId"
								value="<%=restaurantId%>"> <input type="hidden"
								name="action" value="delete">

							<button type="submit" class="remove-item-btn">

								<i class="fa-regular fa-trash-can"></i> Remove

							</button>

						</form>

					</div>
				</div>


				<%
				}
				%>


				<a href="menu?restaurantId=<%=restaurantId%>" class="add-more-btn">
					<i class="fa-solid fa-cart-plus"></i> Add More Items
				</a>

				<%
				} else {
				%>

				<div class="empty-cart">
					<h2>Your Cart is Empty 🛒</h2>
					<p>Add some delicious food to continue.</p>
					<a href="callHomeServlet" class="shop-btn"> Browse Restaurants
					</a>
				</div>


				<%
				}
				%>

			</section>

			<%
			double itemTotal = 0;

			if (cart != null && !cart.getItems().isEmpty()) {
				for (CartItem item : cart.getItems().values()) {
					itemTotal += item.getPrice() * item.getQuantity();
				}
			}

			double deliveryFee = itemTotal > 0 ? 40 : 0;
			double tax = itemTotal * 0.05;
			double grandTotal = itemTotal + deliveryFee + tax;
			%>

			<aside class="checkout-summary-section">
				<div class="summary-card">
					<h3>Bill Details</h3>

					<div class="billing-row">
						<span>Item Total</span> <span>₹<%=String.format("%.2f", itemTotal)%></span>
					</div>
					<div class="billing-row">
						<span>Delivery Fee</span> <span class="fee-free"> ₹<%=String.format("%.2f", deliveryFee)%></span>
					</div>
					<div class="billing-row">
						<span>Taxes & Charges (5%)</span> <span> ₹<%=String.format("%.2f", tax)%></span>
					</div>

					<div class="promo-box">
						<i class="fa-solid fa-tag"></i> <input type="text"
							placeholder="Apply Promo Code..." value="FOOD50" />
						<button type="button" class="apply-btn">Applied</button>
					</div>

					<hr class="summary-divider" />

					<div class="billing-row total-row">
						<span>Grand Total</span> <span class="grand-price"> ₹<%=String.format("%.2f", grandTotal)%></span>
					</div>

					<button type="button" class="checkout-btn">

						<a href="checkout.jsp" class="checkout-btn"
							style="text-decoration: none; display: flex; 
							justify-content: center; align-items: center; gap: 1px;
							 padding: 5px 10px; width: auto;">
							Proceed to Payment <i class="fa-solid fa-arrow-right"></i>
						</a> 
					</button>
				</div>

				<div class="safety-disclaimer">
					<i class="fa-solid fa-shield-halved"></i>
					<p>Safe and secure checkouts. No contact delivery options
						available at next step.</p>
				</div>
			</aside>
		</div>
	</main>


</body>
</html>
