package com.food.servlets;

import java.io.IOException;
import java.sql.Timestamp;

import org.mindrot.jbcrypt.BCrypt;

import com.food.DAOImpl.UserDAOImpl;
import com.food.Model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/VerifyOTPServlet")
public class VerifyOTPServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		if (session == null) {
			resp.sendRedirect("register.html");
			return;
		}

		String enteredOTP = req.getParameter("otp");
		Integer generatedOTP = (Integer) session.getAttribute("otp");

		if (generatedOTP != null &&
				enteredOTP.equals(String.valueOf(generatedOTP))) {

			String name = (String) session.getAttribute("name");
			String email = (String) session.getAttribute("email");
			String password = (String) session.getAttribute("password");
			String role = (String) session.getAttribute("role");
			String address = (String) session.getAttribute("address");
			String phoneNumber = (String) session.getAttribute("phoneNumber");

			String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(8));

			Timestamp now = new Timestamp(System.currentTimeMillis());

			User user = new User();

			user.setUserName(name);
			user.setEmail(email);
			user.setPassword(hashedPassword);
			user.setRole(role);
			user.setAddress(address);
			user.setPhoneNumber(phoneNumber);
			user.setCreateDate(now);
			user.setLastLoginDate(now);

			UserDAOImpl dao = new UserDAOImpl();

			int result = dao.addUser(user);

			if (result == 1) {

				session.removeAttribute("otp");
				session.removeAttribute("name");
				session.removeAttribute("email");
				session.removeAttribute("password");
				session.removeAttribute("role");
				session.removeAttribute("address");
				session.removeAttribute("phoneNumber");

				resp.sendRedirect("login.html");

			} else {

				req.setAttribute("error", "Registration Failed");
				RequestDispatcher rd = req.getRequestDispatcher("register.jsp");
				rd.forward(req, resp);

			}

		} else {

			req.setAttribute("error", "Invalid OTP");

			RequestDispatcher rd = req.getRequestDispatcher("VerifyOTP.jsp");
			rd.forward(req, resp);

		}

	}

}