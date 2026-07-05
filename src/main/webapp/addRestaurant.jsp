<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Restaurant</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: "Segoe UI", Arial, sans-serif;
}

body {
	background: linear-gradient(135deg, #fff8f0, #ffe5d0);
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	padding: 30px;
}

.container {
	width: 900px;
	background: #fff;
	border-radius: 18px;
	box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
	overflow: hidden;
}

.header {
	background: linear-gradient(135deg, #ff7b00, #ff5722);
	color: white;
	padding: 30px;
	text-align: center;
}

.header h1 {
	font-size: 32px;
	margin-bottom: 8px;
}

.header p {
	font-size: 16px;
	opacity: .9;
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

.form-group input, .form-group textarea, .form-group select {
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 8px;
	font-size: 15px;
	outline: none;
	transition: 0.3s;
}

.form-group input:focus, .form-group textarea:focus, .form-group select:focus
	{
	border-color: #ff6b00;
	box-shadow: 0 0 8px rgba(255, 107, 0, .3);
}

textarea {
	resize: none;
	height: 90px;
}

.full {
	grid-column: 1/3;
}

.preview {
	text-align: center;
}

.preview img {
	width: 220px;
	height: 150px;
	object-fit: cover;
	border-radius: 12px;
	border: 2px solid #ddd;
	margin-top: 15px;
}

.buttons {
	display: flex;
	justify-content: center;
	gap: 20px;
	margin-top: 35px;
}

.add-btn {
	background: #28a745;
	color: white;
	padding: 14px 35px;
	border: none;
	border-radius: 8px;
	font-size: 16px;
	cursor: pointer;
	transition: .3s;
}

.add-btn:hover {
	background: #218838;
	transform: translateY(-2px);
}

.cancel-btn {
	background: #dc3545;
	color: white;
	padding: 14px 35px;
	border: none;
	border-radius: 8px;
	font-size: 16px;
	cursor: pointer;
	transition: .3s;
}

.cancel-btn:hover {
	background: #c82333;
	transform: translateY(-2px);
}
</style>

<script>
function previewImage() {
	let url = document.getElementById("imagePath").value;
	document.getElementById("preview").src = url;
}
</script>

</head>

<body>

	<div class="container">

		<div class="header">
			<h1>🍽 Add New Restaurant</h1>
			<p>Fill in the details to add a restaurant</p>
		</div>

		<div class="form-container">

			<form action="AddRestaurantServlet" method="post">

				<div class="form-grid">

					<div class="form-group">
						<label>Restaurant Name</label> <input type="text"
							name="restaurantName" placeholder="Enter restaurant name"
							required>
					</div>

					<div class="form-group">
						<label>CuisineType</label> <input type="text" name="cuisineType"
							placeholder="Indian, Chinese, Italian..." required>
					</div>

					<div class="form-group">
						<label>Delivery Time (Minutes)</label> <input type="number"
							name="deliveryTime" placeholder="30" required>
					</div>

					<div class="form-group">
						<label>Rating</label> <input type="number" step="0.1" min="0"
							max="5" name="rating" placeholder="4.5" required>
					</div>

					<div class="form-group full">
						<label>Address</label>
						<textarea name="address" placeholder="Enter restaurant address"
							required></textarea>
					</div>

					<div class="form-group">
						<label>Status</label> <select name="isActive">
							<option value="true">Active</option>
							<option value="false">Inactive</option>
						</select>
					</div>

					<div class="form-group">
						<label>Image URL</label> <input type="text" id="imagePath"
							name="imagePath" placeholder="Paste image URL"
							onkeyup="previewImage()" required>
					</div>

					<div class="preview full">
						<img id="preview"
							src="https://images.unsplash.com/photo-1568901346375-23c9450c58cd"
							alt="Preview">
					</div>

				</div>

				<div class="buttons">
					<button type="submit" class="add-btn">➕ Add Restaurant</button>

					<button type="button" class="cancel-btn" onclick="history.back()">
						❌ Cancel</button>
				</div>

			</form>

		</div>

	</div>

</body>
</html>