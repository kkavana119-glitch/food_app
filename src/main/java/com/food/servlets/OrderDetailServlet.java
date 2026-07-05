package com.food.servlets;

import java.io.IOException;
import java.util.List;

import com.food.DAOImpl.OrderItemDAOImpl;
import com.food.DAOImpl.OrdersDAOImpl;
import com.food.Model.OrderItem;
import com.food.Model.Orders;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/OrderDetailsServlet")

public class OrderDetailServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int orderId = Integer.parseInt(req.getParameter("ordersId"));
		
		OrdersDAOImpl ordersDAOImpl = new OrdersDAOImpl();
		OrderItemDAOImpl orderItemDAOImpl = new OrderItemDAOImpl();
		
		Orders order = ordersDAOImpl.getOrderById(orderId);
        List<OrderItem> items = orderItemDAOImpl.getItemsByOrderId(orderId);
        
        req.setAttribute("order", order);
        req.setAttribute("items", items);
        
        RequestDispatcher rd = req.getRequestDispatcher("orderdetails.jsp");
        rd.forward(req, resp);
		
		
	}

}
