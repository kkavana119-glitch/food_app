<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.food.Model.Menu"%>
<%@ page import="com.food.DAOImpl.MenuDAOImpl"%>

<%
List<Menu> menuList = (List<Menu>) request.getAttribute("menuList");


%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Menu Management</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Segoe UI, Tahoma, Geneva, Verdana, sans-serif;
}

body {
	background: #f4f6f9;
}

.container {
	width: 95%;
	margin: 30px auto;
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 25px;
}

.header h1 {
	color: orange;
}

.addBtn {
	text-decoration: none;
	background: #28a745;
	color: white;
	padding: 12px 22px;
	border-radius: 8px;
	font-weight: bold;
	transition: .3s;
}

.addBtn:hover {
	background: #218838;
}

.card {
	background: white;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, .12);
	overflow: hidden;
}

table {
	width: 100%;
	border-collapse: collapse;
}

thead {
	background: #343a40;
	color: white;
}

thead th {
	padding: 16px;
	font-size: 16px;
}

td {
	max-width: 200px;
	word-wrap: break-word;
	white-space: normal;
}

tbody td {
	padding: 15px;
	text-align: center;
	border-bottom: 1px solid #eee;
}

tbody tr:hover {
	background: #f8f9fa;
}

img {
	width: 80px;
	height: 60px;
	border-radius: 8px;
	object-fit: cover;
}

.available {
	color: green;
	font-weight: bold;
}

.unavailable {
	color: red;
	font-weight: bold;
}

.edit {
	text-decoration: none;
	background: #007bff;
	color: white;
	padding: 8px 14px;
	border-radius: 6px;
	margin-right: 5px;
}

.edit:hover {
	background: #0056b3;
}

.delete {
	text-decoration: none;
	background: #dc3545;
	color: white;
	padding: 8px 14px;
	border-radius: 6px;
}

.delete:hover {
	background: #b52a37;
}

.total {
	margin-bottom: 20px;
	color: #666;
	font-size: 17px;
}

.searchBox {
	margin-bottom: 20px;
}

.searchBox input {
	width: 300px;
	padding: 10px;
	border-radius: 8px;
	border: 1px solid #ccc;
	outline: none;
}

.desc {
	max-width: 300px;
	word-wrap: break-word;
	white-space: normal;
	line-height: 1.4;
}
</style>

</head>

<body>

	<div class="container">

		<div class="header">

			<h1>
				<a href="${pageContext.request.contextPath}/MenuManagementServlet">
					🍽 Menu Management </a>
			</h1>

			<a href="addMenu.jsp" class="addBtn"> + Add Menu </a>

		</div>

		<div class="searchBox">
			<input type="text" placeholder="Search Menu Item...">
		</div>

		<div class="total">
			Total Menu Items : <b><%=menuList.size()%></b>
		</div>

		<div class="card">

			<table>
				<thead>
					<tr>

						<th>Image</th>
						<th>Item Name</th>
						<th>Description</th>
						<th>Category</th>
						<th>Price</th>
						<th>Status</th>
						<th>Action</th>

					</tr>

				</thead>

				<tbody>

									<%
				if(menuList != null){
				    for(Menu m : menuList){
				%>

					<tr>

						<td><%
String imagePath = m.getImagePath();

if(imagePath != null &&
   (imagePath.startsWith("http://") || imagePath.startsWith("https://"))) {
%>

    <img src="<%=imagePath%>" width="80" height="60">

<%
} else {
%>

    <img src="<%=request.getContextPath() + "/" + imagePath%>" width="80" height="60">

<%
}
%></td>

						<td><%=m.getItemName()%></td>

						<td><%=m.getDescription()%></td>

						<td><%=m.getCategory()%></td>

						<td>₹ <%=m.getPrice()%></td>

						<td>
							<%
							if (m.isAvailable()) {
							%> <span class="available">Available</span> <%
						 } else {
							 %> <span class="unavailable">Unavailable</span> <%
							 }
							 %>

						</td>

						<td><a class="edit"
							href="EditMenuServlet?id=<%=m.getMenuId()%>"> Edit </a> <a
							class="delete" href="DeleteMenuServlet?id=<%=m.getMenuId()%>"
							onclick="return confirm('Are you sure?')"> Delete </a></td>

					</tr>

					<%
					}
				}
					%>

				</tbody>

			</table>

		</div>

	</div>

</body>
</html>