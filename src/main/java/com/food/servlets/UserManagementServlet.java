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

@WebServlet("/UserManagementServlet")

public class UserManagementServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		UserDAOImpl dao = new UserDAOImpl();

		String action = req.getParameter("action");

		if (action == null) {

			List<User> userList = dao.getAllUsers();

			req.setAttribute("userList", userList);

			RequestDispatcher rd = req.getRequestDispatcher("userManagement.jsp");
			rd.forward(req, resp);

		}

		else if (action.equals("edit")) {

			int userId = Integer.parseInt(req.getParameter("userId"));

			User user = dao.getUser(userId);

			req.setAttribute("user", user);

			RequestDispatcher rd = req.getRequestDispatcher("updateUser.jsp");
			rd.forward(req, resp);

		}
	}
	
	

}
