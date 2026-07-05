<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List, com.food.Model.Restaurant"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Restaurant Management</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Arial, Helvetica, sans-serif;
}

body {
	background: #f4f6f9;
	padding: 40px;
}

.container {
	background: white;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 3px 10px rgba(0, 0, 0, .1);
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
}

.header h2 {
	color: #333;
}

.buttons {
	display: flex;
	gap: 15px;
}

button {
	border: none;
	padding: 12px 20px;
	border-radius: 6px;
	cursor: pointer;
	font-size: 15px;
	font-weight: bold;
}

.add {
	background: #28a745;
	color: white;
}

.delete {
	background: #dc3545;
	color: white;
}

button:hover {
	opacity: .9;
}

.search {
	margin-bottom: 20px;
}

.search input {
	width: 300px;
	padding: 10px;
	border: 1px solid gray;
	border-radius: 5px;
}

table {
	width: 100%;
	border-collapse: collapse;
}

table th {
	background: #ff6b00;
	color: white;
	padding: 15px;
}

table td {
	padding: 15px;
	text-align: center;
	border-bottom: 1px solid #ddd;
}

table tr:hover {
	background: #f2f2f2;
}

.edit {
	background: #007bff;
	color: white;
	padding: 8px 15px;
}

.remove {
	background: #dc3545;
	color: white;
	padding: 8px 15px;
}

img {
	width: 70px;
	height: 55px;
	border-radius: 8px;
}
</style>
</head>

<body>

	<div class="container">

		<div class="header">

			<h2>
				<a href="restaurantAdmin">🏪 Restaurant Management</a>
			</h2>

			<div class="buttons">

				<button class="add" onclick="location.href='addRestaurant.jsp'">+
					Add Restaurant</button>

				<button class="remove">Delete Restaurant</button>

			</div>

		</div>

		<div class="search">

			<input type="text" placeholder="Search Restaurant">

		</div>

		<table>
			<tr>
				<th>Image</th>
				<th>Restaurant Name</th>
				<th>CuisineType</th>
				<th>Rating</th>
				<th>Status</th>
				<th>Actions</th>

			</tr>

			<%
			List<Restaurant> allRestaurants = (List<Restaurant>) request.getAttribute("allRestaurants");

			if (allRestaurants != null) {

				for (Restaurant restaurant : allRestaurants) {
			%>

			<tr>

				<td><img src="<%=restaurant.getImagePath()%>"></td>

				<td><%=restaurant.getRestaurantName()%></td>

				<td><%=restaurant.getCuisineType()%></td>

				<td><%=restaurant.getRating()%> ⭐</td>

				<td><%=restaurant.isActive() ? "Active" : "Inactive"%></td>

				<td>

					<button class="edit"
						onclick="location.href='EditRestaurantServlet?restaurantId=<%=restaurant.getRestaurantId()%>'">

						Edit</button>

					<button class="remove"
						onclick="if(confirm('Delete this restaurant?'))location.href='DeleteRestaurantServlet?id=<%=restaurant.getRestaurantId()%>'">
						Delete</button> <script>
								function deleteRestaurant(id) {
								
								    if(confirm("Are you sure you want to delete this restaurant?")) {
								
								        window.location.href =
								            "DeleteRestaurantServlet?restaurantId=" + id;
								    }
								}
								</script>

				</td>

			</tr>

			<%
			}
			}
			%>


		</table>

	</div>

</body>
</html>