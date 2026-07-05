<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Menu</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Arial, Helvetica, sans-serif;
}

body {
	background: linear-gradient(135deg, #ff9a9e, #fad0c4, #fad0c4);
	min-height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 40px;
}

.container {
	width: 700px;
	background: #fff;
	border-radius: 20px;
	padding: 35px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, .25);
}

.container h2 {
	text-align: center;
	color: #ff5722;
	margin-bottom: 30px;
	font-size: 32px;
}

.form-group {
	margin-bottom: 18px;
}

label {
	display: block;
	margin-bottom: 8px;
	font-weight: bold;
	color: #444;
}

input, textarea, select {
	width: 100%;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 10px;
	outline: none;
	transition: .3s;
	font-size: 15px;
}

input:focus, textarea:focus, select:focus {
	border-color: #ff5722;
	box-shadow: 0 0 8px rgba(255, 87, 34, .3);
}

textarea {
	resize: none;
	height: 120px;
}

.row {
	display: flex;
	gap: 20px;
}

.col {
	flex: 1;
}

.btn-group {
	display: flex;
	justify-content: center;
	gap: 20px;
	margin-top: 25px;
}

button {
	padding: 12px 35px;
	border: none;
	border-radius: 30px;
	cursor: pointer;
	font-size: 16px;
	font-weight: bold;
	transition: .3s;
}

.add-btn {
	background: #ff5722;
	color: white;
}

.add-btn:hover {
	background: #e64a19;
	transform: translateY(-3px);
}

.reset-btn {
	background: #555;
	color: white;
}

.reset-btn:hover {
	background: #333;
	transform: translateY(-3px);
}

@media ( max-width :768px) {
	.row {
		flex-direction: column;
	}
	.container {
		width: 100%;
	}
}
</style>

</head>

<body>

	<div class="container">

		<h2>🍽 Add New Menu Item</h2>

		<form action="AddMenuServlet" method="post">

			<div class="form-group">
				<label>Restaurant ID</label> <input type="number"
					name="restaurantId" required>
			</div>

			<div class="form-group">
				<label>Menu Name</label> <input type="text" name="itemName" required>
			</div>

			<div class="row">

				<div class="col">
					<label>Price (₹)</label> <input type="number" name="price" step="0.01" min="1" required>
				</div>

			

			</div>

			<div class="row">

				<div class="col">
					<label>Category</label> <select name="category">
					<option value="">-- Select Category --</option>
						<option>Veg</option>
						<option>Non Veg</option>
						<option>Beverages</option>
						<option>Dessert</option>
						<option>Fast Food</option>
					</select>
				</div>

				<div class="col">
					<label>Availability</label> <select name="isAvailable">
						<option value="true">Available</option>
						<option value="false">Not Available</option>
					</select>
				</div>

			</div>

			<div class="form-group">
				<label>Description</label>
				<textarea name="description" placeholder="Enter menu description..."
					required></textarea>
			</div>

			<div class="form-group">
				<label>Image Path</label> <input type="text" name="imagePath"
					placeholder="images/pizza.jpg" required>
			</div>

			<div class="btn-group">
				<button type="submit" class="add-btn">Add Menu</button>
				<button type="reset" class="reset-btn">Reset</button>
			</div>

		</form>

	</div>

</body>
</html>