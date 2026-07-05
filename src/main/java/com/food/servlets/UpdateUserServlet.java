package com.food.servlets;

import java.io.IOException;

import com.food.DAOImpl.UserDAOImpl;
import com.food.Model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateUserServlet")

public class UpdateUserServlet extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		 int userId = Integer.parseInt(req.getParameter("userId"));
	        String userName = req.getParameter("userName");
	        String email = req.getParameter("email");
	        String password = req.getParameter("password");
	        String role = req.getParameter("role");
	        String address = req.getParameter("address");

	        User user = new User();

	        user.setUserId(userId);
	        user.setUserName(userName);
	        user.setEmail(email);
	        user.setPassword(password);
	        user.setRole(role);
	        user.setAddress(address);

	        UserDAOImpl dao = new UserDAOImpl();

	        dao.updateUser(user);

	        resp.sendRedirect("UserManagementServlet");
	    
	}

}
