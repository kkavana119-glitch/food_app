<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.food.Model.User"%>
<%
    User user = (User) session.getAttribute("user");
    // Redirect to login if session has expired or user is not logged in
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Account Dashboard | <%= user.getUserName() %></title>

<!-- Google Fonts & FontAwesome Icons -->
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<link rel="stylesheet" href="profile.css">
</head>
<body>

	<div class="background-decor"></div>

	<div class="profile-container">

		<!-- LEFT SIDEBAR CARD -->
		<aside class="profile-card">
			<div class="avatar-container">
				<img src="Images/kavana.jpg" alt="Profile" class="profile-avatar">
				<span class="status-badge"></span>
			</div>

			<h2 class="user-name"><%= user.getUserName() %></h2>
			<span class="role-tag"><%= user.getRole() %></span>

			<div class="quick-contact">
				<i class="fa-regular fa-envelope"></i> <span><%= user.getEmail() %></span>
			</div>

			<hr class="divider">

			<nav class="profile-nav">
				<a href="EditProfile.jsp" class="btn btn-primary"> <i
					class="fa-solid fa-user-pen"></i> Edit Profile
				</a> <a href="LogoutServlet" class="btn btn-danger"> <i
					class="fa-solid fa-right-from-bracket"></i> Logout
				</a>
			</nav>
		</aside>

		<!-- RIGHT DETAILS AREA -->
		<main class="details-card">
			<div class="details-header">
				<h2>Account Overview</h2>
				<p>Manage your public profile settings and data.</p>
			</div>

			<div class="info-grid">
				<div class="info-item">
					<div class="info-icon">
						<i class="fa-solid fa-hashtag"></i>
					</div>
					<div class="info-content">
						<label>User ID</label>
						<p><%= user.getUserId() %></p>
					</div>
				</div>

				<div class="info-item">
					<div class="info-icon">
						<i class="fa-solid fa-user"></i>
					</div>
					<div class="info-content">
						<label>Username</label>
						<p><%= user.getUserName() %></p>
					</div>
				</div>

				<div class="info-item full-width">
					<div class="info-icon">
						<i class="fa-solid fa-envelope"></i>
					</div>
					<div class="info-content">
						<label>Email Address</label>
						<p><%= user.getEmail() %></p>
					</div>
				</div>

				<div class="info-item full-width">
					<div class="info-icon">
						<i class="fa-solid fa-location-dot"></i>
					</div>
					<div class="info-content">
						<label>Delivery Address</label>
						<p><%= user.getAddress() != null ? user.getAddress() : "No address provided yet." %></p>
					</div>
				</div>

				<div class="info-item">
					<div class="info-icon">
						<i class="fa-solid fa-shield-halved"></i>
					</div>
					<div class="info-content">
						<label>Account Role</label>
						<p class="capitalize"><%= user.getRole() %></p>
					</div>
				</div>

				<div class="info-item">
					<div class="info-icon">
						<i class="fa-solid fa-calendar-plus"></i>
					</div>
					<div class="info-content">
						<label>Joined Date</label>
						<p><%= user.getCreateDate() %></p>
					</div>
				</div>
			</div>

			<div class="details-footer">
				<i class="fa-solid fa-clock-rotate-left"></i> <span>Last
					activity detected on: <strong><%= user.getLastLoginDate() %></strong>
				</span>
			</div>
		</main>

	</div>

</body>
</html>