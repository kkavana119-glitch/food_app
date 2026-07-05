package com.food.servlets;

import java.io.IOException;
import java.util.List;

import com.food.DAOImpl.OrdersDAOImpl;
import com.food.Model.Orders;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/OrderManagementServlet")

public class OrderManagementServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		 OrdersDAOImpl dao = new OrdersDAOImpl();

	        String action = req.getParameter("action");

	        if(action == null) {

	            List<Orders> orderList = dao.getAllOrders();

	            req.setAttribute("orderList", orderList);

	            RequestDispatcher rd = req.getRequestDispatcher("orderManagement.jsp");

	            rd.forward(req, resp);
	        }

	        else if(action.equals("edit")) {

	            int ordersId = Integer.parseInt(req.getParameter("ordersId"));

	            Orders order = dao.getOrderById(ordersId);

	            req.setAttribute("order", order);

	            RequestDispatcher rd = req.getRequestDispatcher("updateOrder.jsp");

	            rd.forward(req, resp);
	        }
	}

}
