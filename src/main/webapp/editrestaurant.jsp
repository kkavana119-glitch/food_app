<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ page import="com.food.Model.Restaurant"%>

<%
Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Restaurant</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Segoe UI, Arial, sans-serif;
}

body {
	background: #f4f7fb;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
}

.container {
	width: 850px;
	background: white;
	border-radius: 15px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, .15);
	overflow: hidden;
}

.header {
	background: linear-gradient(135deg, #ff7b00, #ff4d4d);
	color: white;
	padding: 25px;
	text-align: center;
}

.header h1 {
	font-size: 30px;
}

.form-container {
	padding: 35px;
}

.form-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 25px;
}

.form-group {
	display: flex;
	flex-direction: column;
}

.form-group label {
	font-weight: bold;
	margin-bottom: 8px;
	color: #444;
}

.form-group input, .form-group select {
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 8px;
	font-size: 15px;
	outline: none;
	transition: .3s;
}

.form-group input:focus, .form-group select:focus {
	border-color: #ff6b00;
	box-shadow: 0 0 8px rgba(255, 107, 0, .3);
}

.full {
	grid-column: 1/3;
}

.buttons {
	margin-top: 30px;
	display: flex;
	justify-content: center;
	gap: 20px;
}

.update-btn {
	background: #28a745;
	color: white;
	border: none;
	padding: 14px 35px;
	border-radius: 8px;
	font-size: 16px;
	cursor: pointer;
	transition: .3s;
}

.update-btn:hover {
	background: #218838;
}

.cancel-btn {
	background: #dc3545;
	color: white;
	border: none;
	padding: 14px 35px;
	border-radius: 8px;
	font-size: 16px;
	cursor: pointer;
	transition: .3s;
}

.cancel-btn:hover {
	background: #c82333;
}

img {
	width: 180px;
	height: 130px;
	object-fit: cover;
	border-radius: 10px;
	border: 2px solid #ddd;
	margin-top: 10px;
}

.preview {
	text-align: center;
}
</style>

</head>

<body>

	<div class="container">

		<div class="header">

			<h1>🍽 Edit Restaurant</h1>

			<p>Update Restaurant Information</p>

		</div>

		<div class="form-container">

			<form action="UpdateRestaurantServlet" method="post">

				<input type="hidden" name="restaurantId"
					value="<%=restaurant.getRestaurantId()%>">

				<div class="form-grid">

					<div class="form-group">

						<label>Restaurant Name</label> <input type="text"
							name="restaurantName" value="<%=restaurant.getRestaurantName()%>"
							required>

					</div>

					<div class="form-group">

						<label>CuisineType</label> <input type="text" name="cuisineType"
							value="<%=restaurant.getCuisineType()%>" required>

					</div>

					<div class="form-group">

						<label>Rating</label> <input type="number" step="0.1" min="0"
							max="5" name="rating" value="<%=restaurant.getRating()%>">

					</div>

					<div class="form-group">

						<label>Status</label> <select name="isActive">

							<option value="true" <%=restaurant.isActive() ? "selected" : ""%>>

								Active</option>

							<option value="false"
								<%=!restaurant.isActive() ? "selected" : ""%>>Inactive

							</option>

						</select>

					</div>

					<div class="form-group full">

						<label>Image Path</label> <input type="text" name="imagePath"
							value="<%=restaurant.getImagePath()%>">

					</div>

					<div class="preview full">

						<img src="<%=restaurant.getImagePath()%>" alt="Restaurant Image">

					</div>

				</div>

				<div class="buttons">

					<button class="update-btn" type="submit">💾 Update
						Restaurant</button>

					<button class="cancel-btn" type="button" onclick="history.back()">

						❌ Cancel</button>

				</div>

			</form>

		</div>

	</div>

</body>
</html>