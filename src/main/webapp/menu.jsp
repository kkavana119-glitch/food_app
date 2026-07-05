<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ page import="java.util.List, com.food.Model.Menu"%>
<%@ page import="com.food.Model.Restaurant"%>

<%@ page import="com.food.Model.Cart, com.food.Model.CartItem"%>

<%
Cart cart = (Cart) session.getAttribute("cart");

int cartCount = 0;

if (cart != null) {
	for (CartItem item : cart.getItems().values()) {
		cartCount += item.getQuantity();
	}
}
%>

<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>MenuPage</title>
<!-- Google Fonts & FontAwesome for Premium Icons -->
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
<link rel="stylesheet" href="menupage.css" />
</head>
<body>
	<!-- MASTER NAVIGATION BAR -->
	<header class="app-header">
		<div class="header-container">
			<div class="brand-logo">
				<i class="fa-solid fa-bolt-lightning"></i> Food<span>Express</span>
			</div>
			<div class="search-bar-wrapper">
				<i class="fa-solid fa-magnifying-glass"></i> <input type="text"
					placeholder="Search for restaurants, cuisines, or curated dishes..." />
			</div>


			<a href="cart.jsp">
				<div class="user-actions">
					<div class="cart-widget">
						<i class="fa-solid fa-basket-shopping"></i> <span
							class="cart-badge"> <%=cartCount%></span>
					</div>
			</a> <img
				src="Images/kavana.jpg"
				alt="User Profile" class="profile-avatar" />
		</div>
		</div>
	</header>

	<%
	Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
	%>

	<!-- CORE CONTENT SPLIT WORKSPACE -->
	<div class="app-layout-body">


		<!-- RIGHT COLUMN: MASTER MENU VIEWPORT -->
		<main class="dishes-display-section">
			<!-- HEADER PROFILE HERO WRAPPER (DYNAMIC) -->
			<div id="menuHero" class="restaurant-hero-banner"
				style="
            background:
              linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.8)),
              url('<%=restaurant.getImagePath()%>');
            background-size: cover;
            background-position: center;
          ">

				<div class="hero-content-info">
					<h1 id="resName"><%=restaurant.getRestaurantName()%></h1>
					<p id="resCuisine">
						<i class="fa-solid fa-utensils"></i><%=restaurant.getCuisineType()%>
					</p>
					<div class="metadata-row">
						<span class="meta-tag rating-tag"><i
							class="fa-solid fa-star"></i> <span id="resRating"><%=restaurant.getRating()%></span></span>
						<span class="meta-tag time-tag"><i
							class="fa-solid fa-clock"></i> <span id="resTime"><%=restaurant.getDeliveryTime()%></span>
							mins</span> <span class="meta-tag offer-tag"><i
							class="fa-solid fa-tag"></i> 40% OFF Upto ₹80</span>
					</div>
					<p id="resAddress" class="res-address-text">
						<%=restaurant.getAddress()%>
					</p>
				</div>
			</div>

			<!-- MENU CARDS INTERACTION WORKSPACE -->
			<div class="menu-items-master-container">

				<!-- 1. PIZZA HUB -->
				<div id="pizza-hub" class="restaurant-menu-block active-menu">
					<h2><%=restaurant.getRestaurantName()%></h2>
					<div class="dish-grid-layout">

						<%
						List<Menu> allMenus = (List<Menu>) request.getAttribute("allMenus");

						for (Menu menu : allMenus) {
						%>

						<div class="dish-item-card">
							<div class="dish-details-pane">
								<div class="food-type-icon veg-icon">
									<i class="fa-solid fa-square-caret-up"></i>
									<%=menu.getCategory()%>
								</div>
								<h4 class="dish-name"><%=menu.getItemName()%></h4>
								<div class="dish-price"><%=menu.getPrice()%></div>
								<p class="dish-desc">
									<%=menu.getDescription()%>
								</p>
							</div>
							<div class="dish-image-action-pane">
								<img src="<%=menu.getImagePath()%>" alt="Paneer Pizza" />

								<form action="cartServlet">
									<input type="hidden" name="menuId"
										value="<%=menu.getMenuId()%>"> <input type="hidden"
										name="restaurantId" value="<%=menu.getRestaurantId()%>">
									<input type="hidden" name="quantity" value="1"> <input
										type="hidden" name="action" value="add">
									<button class="add-to-cart-btn">ADD</button>

								</form>
							</div>
						</div>


						<%
						}
						%>


					</div>
		</main>
	</div>

	<!-- TOAST ALERT PANEL -->
	<div class="toast-alert" id="cartToast">
		<i class="fa-solid fa-circle-check"></i> Item successfully added to
		your cart!
	</div>

	<!-- JAVASCRIPT APP ARCHITECTURE WIREUP -->
	<script>
      // RESTAURANT COMPLEX DATA REGISTER
      const restaurantData = {
        "pizza-hub": {
          name: "Pizza Hub",
          cuisine: "Italian • Fast Food",
          rating: "4.5",
          time: "25",
          address: "100 Feet Road, Indiranagar, Bangalore",
          bg: "linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.8)), url('https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=1200')",
        },
        "burger-king": {
          name: "Burger King",
          cuisine: "American • Fast Food",
          rating: "4.3",
          time: "20",
          address: "MG Road, Explicit Plaza, Bangalore",
          bg: "linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.8)), url('https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=1200')",
        },
        "biryani-house": {
          name: "Biryani House",
          cuisine: "Mughlai • North Indian",
          rating: "4.7",
          time: "35",
          address: "Koramangala 5th Block, Bangalore",
          bg: "linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.8)), url('https://images.unsplash.com/photo-1633945274405-b6c8069047b0?q=80&w=1200')",
        },
        "royal-dosa": {
          name: "Royal Dosa",
          cuisine: "South Indian • Pure Veg",
          rating: "4.6",
          time: "15",
          address: "Jayanagar 4th Block, Bangalore",
          bg: "linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.8)), url('https://images.unsplash.com/photo-1668236543090-82eba5ee5976?q=80&w=1200')",
        },
        "dragon-wok": {
          name: "Dragon Wok",
          cuisine: "Asian • Chinese • Thai",
          rating: "4.2",
          time: "30",
          address: "Commercial Street, Bangalore",
          bg: "linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.8)), url('https://images.unsplash.com/photo-1585032226651-759b368d7246?q=80&w=1200')",
        },
        "tandoori-express": {
          name: "Tandoori Express",
          cuisine: "North Indian • Kebab",
          rating: "4.4",
          time: "30",
          address: "HSR Layout, Sector 3, Bangalore",
          bg: "linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.8)), url('https://images.unsplash.com/photo-1628294895950-9805252327bc?q=80&w=1200')",
        },
        "sweet-cravings": {
          name: "Sweet Cravings",
          cuisine: "Desserts • Bakery",
          rating: "4.8",
          time: "15",
          address: "Whitefield Main Road, Bangalore",
          bg: "linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.8)), url('https://images.unsplash.com/photo-1551024601-bec78aea704b?q=80&w=1200')",
        },
        "healthy-bowl": {
          name: "Healthy Bowl",
          cuisine: "Salads • Organic • Vegan",
          rating: "4.5",
          time: "20",
          address: "ST Bed Layout, Koramangala, Bangalore",
          bg: "linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.8)), url('https://images.unsplash.com/photo-1512621776951-a57141f2eefd?q=80&w=1200')",
        },
        "taco-fiesta": {
          name: "Taco Fiesta",
          cuisine: "Mexican • Street Food",
          rating: "4.3",
          time: "25",
          address: "Malleshwaram 11th Cross, Bangalore",
          bg: "linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.8)), url('https://images.unsplash.com/photo-1565299585323-38d6b0865b47?q=80&w=1200')",
        },
        "kebab-kingdom": {
          name: "Kebab Kingdom",
          cuisine: "Awadhi • Mughlai Grill",
          rating: "4.6",
          time: "35",
          address: "Frazer Town, Mosque Road, Bangalore",
          bg: "linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.8)), url('https://images.unsplash.com/photo-1603360946369-dc9bb6258143?q=80&w=1200')",
        },
        "seafood-corner": {
          name: "Seafood Corner",
          cuisine: "Coastal • Seafood",
          rating: "4.4",
          time: "30",
          address: "Ulsoor Lake Road, Bangalore",
          bg: "linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.8)), url('https://images.unsplash.com/photo-1625938146369-adc83368bda7?q=80&w=1200')",
        },
        "green-cafe": {
          name: "Green Cafe",
          cuisine: "Healthy Cafe • Beverages",
          rating: "4.2",
          time: "15",
          address: "Lavelle Road, Richmond Town, Bangalore",
          bg: "linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.8)), url('https://images.unsplash.com/photo-1536256263959-770b48d82b0a?q=80&w=1200')",
        },
        "chicken-hub": {
          name: "Chicken Hub",
          cuisine: "Fried Chicken • Fast Food",
          rating: "4.3",
          time: "22",
          address: "Marathahalli Bridge Outer Ring Rd, Bangalore",
          bg: "linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.8)), url('https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?q=80&w=1200')",
        },
        "pasta-street": {
          name: "Pasta Street",
          cuisine: "Italian • Gourmet Continental",
          rating: "4.6",
          time: "28",
          address: "Cunningham Road, Vasanth Nagar, Bangalore",
          bg: "linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.8)), url('https://images.unsplash.com/photo-1612874742237-6526221588e3?q=80&w=1200')",
        },
        "ice-cream-world": {
          name: "Ice Cream World",
          cuisine: "Ice Creams • Shakes",
          rating: "4.7",
          time: "12",
          address: "Bannerghatta Main Road, Bangalore",
          bg: "linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.8)), url('https://images.unsplash.com/photo-1563805042-7684c019e1cb?q=80&w=1200')",
        },
      };

      // INTERACTIVE DOM NODES SELECTION
      const sidebarLinks = document.querySelectorAll("#restaurantLinks li a");
      const menuBlocks = document.querySelectorAll(".restaurant-menu-block");
      const toast = document.getElementById("cartToast");
      const cartBadge = document.querySelector(".cart-badge");

      const resName = document.getElementById("resName");
      const resCuisine = document.getElementById("resCuisine");
      const resRating = document.getElementById("resRating");
      const resTime = document.getElementById("resTime");
      const resAddress = document.getElementById("resAddress");
      const menuHero = document.getElementById("menuHero");

      let cartItemCount = 0;

      // DYNAMIC TAB CONTROL EVENT HANDLERS
      sidebarLinks.forEach((link) => {
        link.addEventListener("click", function (e) {
          e.preventDefault();

          const targetId = this.getAttribute("data-id");
          const targetData = restaurantData[targetId];

          // Update active layout classes in sidebar navigation
          sidebarLinks.forEach((l) => l.classList.remove("active-category"));
          this.classList.add("active-category");

          // Toggle content listings displays matching targets
          menuBlocks.forEach((block) => {
            if (block.getAttribute("id") === targetId) {
              block.classList.add("active-menu");
            } else {
              block.classList.remove("active-menu");
            }
          });

          // Inject state-based values into the template layout workspace
          if (targetData) {
            resName.textContent = targetData.name;
            resCuisine.innerHTML = `<i class="fa-solid fa-utensils"></i> ${targetData.cuisine}`;
            resRating.textContent = targetData.rating;
            resTime.textContent = targetData.time;
            resAddress.textContent = targetData.address;
            menuHero.style.background = targetData.bg;
            menuHero.style.backgroundSize = "cover";
            menuHero.style.backgroundPosition = "center";
          }

          // Smoothly scroll to content block workspace views for mobile responsive viewports
          if (window.innerWidth <= 992) {
            document
              .querySelector(".dishes-display-section")
              .scrollIntoView({ behavior: "smooth" });
          }
        });
      });

      // INTERACTIVE CART EVENT DISPATCH HANDLING
      document.addEventListener("click", function (e) {
        if (e.target && e.target.classList.contains("add-to-cart-btn")) {
          // Increment cart item count
          cartItemCount++;
          cartBadge.textContent = cartItemCount;
          cartBadge.style.transform = "scale(1.3)";
          setTimeout(() => (cartBadge.style.transform = "scale(1)"), 200);

          // Trigger CSS animations via target injection loops
          toast.classList.add("show");
          setTimeout(() => {
            toast.classList.remove("show");
          }, 2500);
        }
      });
    </script>
</body>
</html>
