<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List, com.food.Model.Restaurant"%>

<!doctype html>
<html lang="en" style="scroll-behavior: smooth">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>HomePage</title>
<link rel="stylesheet" href="homepage.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />

</head>

<body>
	<!-- HEADER SECTION -->
	<header>
		<div class="logo">
			<i class="fa-solid fa-burger"></i> FoodieExpress
		</div>

		<nav>
			<ul>
				<li><a href="#" class="active-link">Home</a></li>
				<li><a href="#restaurants">Restaurants</a></li>
				<li><a href="#offer">Offers</a></li>
				<li><a href="#orders">Orders</a></li>
				<li><a href="cart.jsp">Cart</a></li>
			</ul>
		</nav>

		<div class="header-actions">
			<button class="login-btn">
				<a href="login.html">Login</a>
			</button>
			<button class="signup-btn">
				<a href="register.html">Sign Up</a>
			</button>

			<div class="">
				<a href="profile"> <i class=""></i> <img src="Images/kavana.jpg"
					alt="User Profile" class="profile-avatar" />
				</a>
			</div>
		</div>
	</header>

	<!-- HERO SECTION -->
	<section class="hero">
		<div class="video-background-wrapper">
			<iframe
				src="https://www.youtube.com/embed/K8pVOQhXxto?autoplay=1&mute=1&loop=1&playlist=K8pVOQhXxto&controls=0&showinfo=0&rel=0&modestbranding=1&end=73"
				frameborder="0"
				allow="
            accelerometer;
            autoplay;
            clipboard-write;
            encrypted-media;
            gyroscope;
            picture-in-picture;
            web-share;
          "
				allowfullscreen> </iframe>
		</div>

		<div class="hero-content">
			<h1 id="orders">Delicious Food Delivered To Your Doorstep</h1>
			<p>Order from your favorite restaurants anytime.</p>

			<div class="search-box">
				<input type="text"
					placeholder="Search restaurants, cuisines, dishes..." />
				<button>
					<i class="fa-solid fa-search"></i>
				</button>
			</div>
		</div>
	</section>

	<!-- FOOD CATEGORIES SECTION -->
	<section class="categories">
		<h2>Food Categories</h2>

		<div class="category-container">
			<div class="category-card">
				<img src="https://img.icons8.com/fluent/96/hamburger.png"
					alt="Burger" />
				<h3>Burger</h3>
			</div>

			<div class="category-card">
				<img src="https://img.icons8.com/fluent/96/pizza.png" alt="Pizza" />
				<h3>Pizza</h3>
			</div>

			<div class="category-card">
				<img src="https://img.icons8.com/color/96/rice-bowl.png"
					alt="Biryani" />
				<h3>Biryani</h3>
			</div>

			<div class="category-card">
				<img src="https://img.icons8.com/fluent/96/cupcake.png"
					alt="Desserts" />
				<h3>Desserts</h3>
			</div>

			<div class="category-card">
				<img src="https://img.icons8.com/fluent/96/soda-bottle.png"
					alt="Drinks" />
				<h3 id="offer">Drinks</h3>
			</div>
		</div>
	</section>

	<!-- OFFER BANNER SECTION -->
	<!-- <section class="offer-banner">
      <h2>🔥 Flat 50% OFF on First Order</h2>
      <p>Use Code: FOOD50</p>
    </section>   -->

	<section class="offers-section">
		<div class="premium-promo-card">
			<div class="promo-badge">
				<i class="fa-solid fa-fire-flame-curved"></i> Limited Offer
			</div>
			<h3 class="promo-heading">Flat 50% OFF on First Order</h3>
			<p class="promo-subtext">Unlock your exclusive welcome discount
				today.</p>
			<div class="coupon-pill">
				Use Code: <span class="code-highlight">FOOD50</span>
			</div>
		</div>
	</section>

	<!-- POPULAR RESTAURANTS SECTION -->
	<section class="restaurants">
		<h2 id="restaurants">Popular Restaurants</h2>

		<!-- The grid container below is forced to 3 items per line via CSS -->
		<div class="restaurant-container">


			<%
      List<Restaurant> allRestaurants = (List<Restaurant>) request.getAttribute("allRestaurants");
      
      if(allRestaurants != null) {
      
      for(Restaurant restaurant : allRestaurants)
      {
      %>

			<!-- Restaurant 1 (Active / Open) -->
			<a href="menu?restaurantId=<%= restaurant.getRestaurantId() %>"
				class="restaurant-link">
				<div class="restaurant-card">

					<div class="image-wrapper">
						<img src="<%= restaurant.getImagePath() %>" alt="Pizza Hub" /> <span
							class="status-badge active">Open</span>
					</div>
					<div class="restaurant-info">
						<h3>
							<%= restaurant.getRestaurantName() %>
						</h3>
						<p class="cuisine">
							<%= restaurant.getCuisineType() %></p>
						<p class="address">
							<i class="fa-solid fa-location-dot"></i>
							<%= restaurant.getAddress() %>
						</p>
						<span class="meta">⭐ <%= restaurant.getRating() %> • <%= restaurant.getDeliveryTime() %>
							mins
						</span>
					</div>

				</div>
			</a>


			<%
      }
      }
        %>


		</div>
	</section>

	<!-- Floating Chat Button -->

	<div class="chat-icon" onclick="toggleChat()">
		<i class="fa-solid fa-comments"></i>
	</div>

	<div class="chat-window" id="chatWindow">
		<iframe src="chatbot.jsp"></iframe>
	</div>

	<!-- FOOTER SECTION -->
	<footer>
		<h3>FoodieExpress</h3>
		<p>Fastest Food Delivery Service</p>
		<p>© 2026 FoodieExpress. All Rights Reserved.</p>
	</footer>

	<script src="JavaScript/chatbot.js"></script>

</body>
</html>
