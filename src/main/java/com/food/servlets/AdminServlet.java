package com.food.servlets;

import java.io.IOException;
import java.util.List;

import com.food.DAOImpl.UserDAOImpl;
import com.food.Model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin")

public class AdminServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		UserDAOImpl userDAOImpl = new UserDAOImpl();
		List<User> allUsers = userDAOImpl.getAllUsers();
		
		req.setAttribute("allUsers", allUsers);
		
		RequestDispatcher rd = req.getRequestDispatcher("admin.html");
		rd.forward(req, resp);
		
	}
}
