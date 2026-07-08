package com.food.servlets;

import java.io.IOException;
import java.sql.Timestamp;

import org.mindrot.jbcrypt.BCrypt;

import com.food.DAOImpl.UserDAOImpl;
import com.food.Model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/register")

public class RegisterServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		String role = req.getParameter("role");
		String address = req.getParameter("address");
		String phoneNumber = req.getParameter("phoneNumber");

		String hashpw = BCrypt.hashpw(password, BCrypt.gensalt(8));

		Timestamp now = new Timestamp(System.currentTimeMillis());

		User user = new User();

		user.setUserName(name);
		user.setEmail(email);
		user.setPassword(hashpw);
		user.setRole(role);
		user.setAddress(address);
		user.setCreateDate(now);
		user.setLastLoginDate(now);
		user.setPhoneNumber(phoneNumber);


		UserDAOImpl userDAOImpl = new UserDAOImpl();
		int res = userDAOImpl.addUser(user);

		if(res == 1) {
			resp.sendRedirect("login.html");
		}
		else {
			resp.sendRedirect("register.html");
		}

	}

}
