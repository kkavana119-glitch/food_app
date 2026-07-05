package com.food.servlets;

import java.io.IOException;

import com.food.DAOImpl.RestaurantDAOImpl;
import com.food.Model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateRestaurantServlet")

public class UpdateRestaurantServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));

		String restaurantName = req.getParameter("restaurantName");

		String cuisineType = req.getParameter("cuisineType");

		float rating = Float.parseFloat(req.getParameter("rating"));

		String imagePath = req.getParameter("imagePath");

		boolean isActive = Boolean.parseBoolean(req.getParameter("isActive"));

		Restaurant restaurant = new Restaurant();

		restaurant.setRestaurantId(restaurantId);
		restaurant.setRestaurantName(restaurantName);
		restaurant.setCuisineType(cuisineType);
		restaurant.setRating(rating);
		restaurant.setImagePath(imagePath);
		restaurant.setActive(isActive);

		RestaurantDAOImpl dao = new RestaurantDAOImpl();

		dao.updateRestaurant(restaurant);

		resp.sendRedirect("restaurantAdmin");
	}

}
