package com.food.servlets;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.food.DAOImpl.UserDAOImpl;
import com.food.Model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")

public class LoginServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String email = req.getParameter("email");
		String password = req.getParameter("password");
		
		HttpSession session = req.getSession();

		UserDAOImpl userDAOImpl = new UserDAOImpl(); 
		User user = userDAOImpl.getUserByEmail(email);
		
		String dbPassword = user.getPassword();

		if (BCrypt.checkpw(password, dbPassword)) {

		    session.setAttribute("user", user);
		    
		    if ("Admin".equalsIgnoreCase(user.getRole())) {
	            resp.sendRedirect("admin.html");
	            return;
	        }


		    String redirect = (String) session.getAttribute("redirectAfterLogin");

		    if ("checkout".equals(redirect)) {
		        session.removeAttribute("redirectAfterLogin");
		        resp.sendRedirect("checkout");
		    } else {
		        resp.sendRedirect("callHomeServlet");
		    }
		    
		    
		}
	}
}
