<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.food.Model.Menu"%>

<%
Menu menu = (Menu) request.getAttribute("menu");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Menu</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Arial, Helvetica, sans-serif;
}

body {
	background: linear-gradient(135deg, #ff9a9e, #fad0c4);
	min-height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 40px;
}

.container {
	width: 750px;
	background: #fff;
	border-radius: 20px;
	padding: 35px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, .2);
}

h2 {
	text-align: center;
	color: #ff5722;
	margin-bottom: 25px;
}

.form-group {
	margin-bottom: 18px;
}

label {
	display: block;
	font-weight: bold;
	margin-bottom: 8px;
	color: #444;
}

input, textarea, select {
	width: 100%;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 10px;
	font-size: 15px;
	outline: none;
}

input:focus, textarea:focus, select:focus {
	border-color: #ff5722;
}

textarea {
	height: 120px;
	resize: none;
}

.row {
	display: flex;
	gap: 20px;
}

.col {
	flex: 1;
}

.image-preview {
	text-align: center;
	margin-bottom: 20px;
}

.image-preview img {
	width: 180px;
	height: 130px;
	object-fit: cover;
	border-radius: 10px;
	border: 2px solid #ddd;
}

.btn-group {
	display: flex;
	justify-content: center;
	gap: 20px;
	margin-top: 25px;
}

button {
	padding: 12px 30px;
	border: none;
	border-radius: 30px;
	cursor: pointer;
	font-size: 16px;
	font-weight: bold;
}

.update {
	background: #28a745;
	color: white;
}

.update:hover {
	background: #218838;
}

.cancel {
	background: #dc3545;
	color: white;
}

.cancel:hover {
	background: #c82333;
}
</style>

</head>

<body>

	<div class="container">

		<h2>✏ Edit Menu Item</h2>

		<form action="UpdateMenuServlet" method="post"
			enctype="multipart/form-data">

			<input type="hidden" name="menuId" value="<%=menu.getMenuId()%>">

			<input type="hidden" name="existingImage"
				value="<%=menu.getImagePath() != null ? menu.getImagePath() : "" %>">

			<div class="image-preview">

				<%
				String imagePath = menu.getImagePath();

				if (imagePath.startsWith("http://") || imagePath.startsWith("https://")) {
				%>

				<img src="<%=imagePath%>">

				<%
				} else {
				%>

				<img src="<%=request.getContextPath() + "/" + imagePath%>">

				<%
				}
				%>

			</div>

			<div class="form-group">

				<label>Upload New Image</label> <input type="file" name="image"
					accept="image/*">

			</div>

			<div class="form-group">

				<label>Or Paste Image URL</label> <input type="url" name="imageUrl"
					placeholder="https://example.com/pizza.jpg"
					value="<%=menu.getImagePath().startsWith("http") ? menu.getImagePath() : ""%>">

			</div>
			<div class="form-group">

				<label>Restaurant ID</label> <input type="number"
					name="restaurantId" value="<%=menu.getRestaurantId()%>" required>

			</div>

			<div class="form-group">

				<label>Item Name</label> <input type="text" name="itemName"
					value="<%=menu.getItemName()%>" required>

			</div>

			<div class="row">

				<div class="col">

					<label>Price</label> <input type="number" name="price" step="0.01"
						value="<%=menu.getPrice()%>" required>

				</div>

				<div class="col">

					<label>Availability</label> <select name="available">

						<option value="true" <%=menu.isAvailable() ? "selected" : ""%>>

							Available</option>

						<option value="false" <%=!menu.isAvailable() ? "selected" : ""%>>

							Not Available</option>

					</select>

				</div>

			</div>

			<div class="form-group">

				<label>Category</label> <select name="category">

					<option value="Veg"
						<%=menu.getCategory().equals("Veg") ? "selected" : ""%>>Veg</option>

					<option value="Non Veg"
						<%=menu.getCategory().equals("Non Veg") ? "selected" : ""%>>

						Non Veg</option>

					<option value="Beverages"
						<%=menu.getCategory().equals("Beverages") ? "selected" : ""%>>

						Beverages</option>

					<option value="Dessert"
						<%=menu.getCategory().equals("Dessert") ? "selected" : ""%>>

						Dessert</option>

					<option value="Fast Food"
						<%=menu.getCategory().equals("Fast Food") ? "selected" : ""%>>

						Fast Food</option>

				</select>

			</div>

			<div class="form-group">

				<label>Description</label>

				<textarea name="description" required><%=menu.getDescription()%></textarea>

			</div>

			<div class="btn-group">

				<button class="update" type="submit">Update Menu</button>

				<button class="cancel" type="button"
					onclick="location.href='MenuManagementServlet'">Cancel</button>

			</div>

		</form>

	</div>

</body>
</html>