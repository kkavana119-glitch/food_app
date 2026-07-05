package com.food.servlets;

import java.io.IOException;

import com.food.DAOImpl.MenuDAOImpl;
import com.food.Model.Menu;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddMenuServlet")

public class AddMenuServlet extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		 String itemName = req.getParameter("menuName");
	        String description = req.getParameter("description");
	        double price = Double.parseDouble(req.getParameter("price"));
	        boolean isAvailable = Boolean.parseBoolean(req.getParameter("isAvailable"));
	        String category = req.getParameter("category");
	        int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
	        String imagePath = req.getParameter("imagePath");

	        Menu menu = new Menu();

	        menu.setItemName(itemName);
	        menu.setDescription(description);
	        menu.setPrice(price);
	        menu.setAvailable(isAvailable);
	        menu.setCategory(category);
	        menu.setRestaurantId(restaurantId);
	        menu.setImagePath(imagePath);

	        MenuDAOImpl dao = new MenuDAOImpl();

	        dao.addMenu(menu);

	        resp.sendRedirect("MenuManagementServlet");
	    }
	
		
	

}
