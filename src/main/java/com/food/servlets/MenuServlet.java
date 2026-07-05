package com.food.servlets;

import java.io.IOException;
import java.util.List;

import com.food.DAOImpl.MenuDAOImpl;
import com.food.DAOImpl.RestaurantDAOImpl;
import com.food.Model.Menu;
import com.food.Model.Restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/menu")

public class MenuServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		MenuDAOImpl menuDAOImpl = new MenuDAOImpl();

		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));

		List<Menu> allMenus = menuDAOImpl.getAllMenus(restaurantId);


		RestaurantDAOImpl restaurantDAOImpl = new RestaurantDAOImpl();

		Restaurant restaurant = restaurantDAOImpl.getRestaurant(restaurantId);

		req.setAttribute("allMenus", allMenus);
		req.setAttribute("restaurant", restaurant);

		RequestDispatcher requestDispatcher = req.getRequestDispatcher("menu.jsp");
		requestDispatcher.forward(req, resp);

	}

}
