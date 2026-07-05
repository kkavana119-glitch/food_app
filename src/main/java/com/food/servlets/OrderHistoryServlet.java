package com.food.servlets;

import java.io.IOException;
import java.util.List;

import com.food.DAOImpl.OrdersDAOImpl;
import com.food.Model.Orders;
import com.food.Model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/OrderHistoryServlet")

public class OrderHistoryServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		User user = (User) session.getAttribute("user");
		
		if(user == null) {
			resp.sendRedirect("login.html");
			return;
			
		}
		
		
		OrdersDAOImpl ordersDAOImpl = new OrdersDAOImpl();
		
		List<Orders> ordersList =  ordersDAOImpl.getOrdersByUserId(user.getUserId());
		
		req.setAttribute("ordersList", ordersList);
		
		RequestDispatcher rd = req.getRequestDispatcher("orderhistory.jsp");
		rd.forward(req, resp);
		
		
	}

}














