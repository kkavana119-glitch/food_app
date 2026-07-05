package com.food.servlets;

import java.io.IOException;

import com.food.DAOImpl.RestaurantDAOImpl;
import com.food.Model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddRestaurantServlet")

public class AddRestaurantServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String restaurantName = req.getParameter("restaurantName");
		String cuisineType = req.getParameter("cuisineType");
		int deliveryTime = Integer.parseInt(req.getParameter("deliveryTime"));
		String address = req.getParameter("address");
		double rating = Double.parseDouble(req.getParameter("rating"));
		boolean isActive = Boolean.parseBoolean(req.getParameter("isActive"));
		String imagePath = req.getParameter("imagePath");

		Restaurant restaurant = new Restaurant();

		restaurant.setRestaurantName(restaurantName);
		restaurant.setCuisineType(cuisineType);
		restaurant.setDeliveryTime(deliveryTime);
		restaurant.setAddress(address);
		restaurant.setRating(rating);
		restaurant.setActive(isActive);
		restaurant.setImagePath(imagePath);

		RestaurantDAOImpl dao = new RestaurantDAOImpl();
		dao.addRestaurant(restaurant);

		resp.sendRedirect("restaurantAdmin");
	}

}
