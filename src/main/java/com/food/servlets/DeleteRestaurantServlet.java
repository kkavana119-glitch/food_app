package com.food.servlets;

import java.io.IOException;

import com.food.DAOImpl.RestaurantDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteRestaurantServlet")

public class DeleteRestaurantServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
		
		RestaurantDAOImpl restaurantDAOImpl = new RestaurantDAOImpl();
		restaurantDAOImpl.deleteRestaurant(restaurantId);
		
		resp.sendRedirect("restaurantAdmin");
		
	}

}
