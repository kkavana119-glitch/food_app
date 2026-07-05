package com.food.servlets;

import java.io.IOException;
import java.sql.Timestamp;

import com.food.DAOImpl.OrdersDAOImpl;
import com.food.Model.Orders;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateOrderServlet")

public class UpdateOrderServlet extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		 int ordersId = Integer.parseInt(req.getParameter("ordersId"));
				 

	        int userId = Integer.parseInt(req.getParameter("userId"));

	        int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));

	        double totalAmount = Double.parseDouble(req.getParameter("totalAmount"));

	        String status = req.getParameter("status");

	        String paymentMethod = req.getParameter("paymentMethod");

	        Orders order = new Orders();

	        order.setOrdersId(ordersId);
	        order.setUserId(userId);
	        order.setRestaurantId(restaurantId);
	        order.setOrdersDate(new Timestamp(System.currentTimeMillis()));
	        order.setTotalAmount(totalAmount);
	        order.setStatus(status);
	        order.setPaymentMethod(paymentMethod);

	        OrdersDAOImpl dao = new OrdersDAOImpl();

	        dao.updateOrders(order);

	        resp.sendRedirect("OrderManagementServlet");
	    
		
	}

}
