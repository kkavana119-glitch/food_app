package com.food.servlets;

import java.io.IOException;

import com.food.DAOImpl.MenuDAOImpl;
import com.food.Model.Cart;
import com.food.Model.CartItem;
import com.food.Model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cartServlet")
public class CartServlet extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		Cart cart = (Cart)session.getAttribute("cart");
		Integer restaurantId = (Integer) session.getAttribute("restaurantId");
		
		
		int newRestaurantId = Integer.parseInt(req.getParameter("restaurantId"));
		

		if(cart == null || restaurantId != newRestaurantId) {
			
			cart = new Cart();
			session.setAttribute("cart", cart);
			session.setAttribute("restaurantId", newRestaurantId);
		}
		
		String action = req.getParameter("action");    
		
		if(action.equals("add")) {
			addItemToCart(req, cart);
		}
		else if(action.equals("update")) {
			updateItemToCart(req,cart);
		}
		else if(action.equals("delete")) {
			deleteItemFromCart(req, cart);
		}
		
		resp.sendRedirect("cart.jsp");
		
	}

	private void deleteItemFromCart(HttpServletRequest req, Cart cart) {

		int menuId = Integer.parseInt(req.getParameter("menuId"));
		
		cart.removeItem(menuId);
		
	}

	private void updateItemToCart(HttpServletRequest req, Cart cart) {

		int menuId = Integer.parseInt(req.getParameter("menuId"));
		int quantity = Integer.parseInt(req.getParameter("quantity"));
		
		cart.updateItem(menuId, quantity);
		
	}

	private void addItemToCart(HttpServletRequest req, Cart cart) {

		int menuId = Integer.parseInt(req.getParameter("menuId"));
		int quantity = Integer.parseInt(req.getParameter("quantity"));
		
		MenuDAOImpl menuDAOImpl = new MenuDAOImpl();
		Menu menu = menuDAOImpl.getMenu(menuId);
		
		CartItem cartItem = new CartItem(menu.getMenuId(), menu.getRestaurantId(), menu.getItemName(), menu.getPrice(), quantity, menu.getImagePath());
		
		cart.addItem(cartItem);
		
	}
	
}
