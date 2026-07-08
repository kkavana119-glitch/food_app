package com.food.servlets;

import java.io.IOException;
import java.util.List;

import com.food.DAOImpl.RestaurantDAOImpl;
import com.food.Model.Restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/callHomeServlet")

public class HomeServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		RestaurantDAOImpl restaurantDAOImpl = new RestaurantDAOImpl();

		List<Restaurant> list = restaurantDAOImpl.getAllRestaurants();

		req.setAttribute("allRestaurants", list);

		RequestDispatcher requestDispatcher = req.getRequestDispatcher("home.jsp");
		requestDispatcher.forward(req, resp);

	}
}
