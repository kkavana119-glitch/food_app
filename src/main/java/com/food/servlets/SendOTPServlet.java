package com.food.servlets;

import java.io.IOException;
import java.util.Random;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/SendOTPServlet")

public class SendOTPServlet extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		  String name = req.getParameter("name");
	        String email = req.getParameter("email");
	        String password = req.getParameter("password");
	        String role = req.getParameter("role");
	        String address = req.getParameter("address");
	        String phoneNumber = req.getParameter("phoneNumber");

	        Random random = new Random();

	        int otp = 100000 + random.nextInt(900000);

	        HttpSession session = req.getSession();

	        session.setAttribute("name", name);
	        session.setAttribute("email", email);
	        session.setAttribute("password", password);
	        session.setAttribute("role", role);
	        session.setAttribute("address", address);
	        session.setAttribute("phoneNumber", phoneNumber);
	        session.setAttribute("otp", otp);

	        System.out.println("=================================");
	        System.out.println("Generated OTP : " + otp);
	        System.out.println("Mobile Number : " + phoneNumber);
	        System.out.println("=================================");

	        resp.sendRedirect("VerifyOTP.jsp");
		
	}

}
