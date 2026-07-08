package com.food.servlets;

import java.io.IOException;
import java.sql.Timestamp;

import com.food.DAOImpl.OrderItemDAOImpl;
import com.food.DAOImpl.OrdersDAOImpl;
import com.food.DAOImpl.RestaurantDAOImpl;
import com.food.Model.Cart;
import com.food.Model.CartItem;
import com.food.Model.OrderItem;
import com.food.Model.Orders;
import com.food.Model.Restaurant;
import com.food.Model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();

		User user = (User) session.getAttribute("user");
		Integer restaurantId = (Integer) session.getAttribute("restaurantId");
		Double grandTotal = (Double) session.getAttribute("grandTotal");
		Cart cart = (Cart) session.getAttribute("cart");

		String paymentMethod = req.getParameter("paymentMethod");

		// Delivery Address
		String address = req.getParameter("address");
		String city = req.getParameter("city");
		String pincode = req.getParameter("pincode");

		if(user == null) {
			RequestDispatcher rd = req.getRequestDispatcher("login.html");
			rd.forward(req, resp);
			return;
		}

		if(user != null && cart != null && !cart.getItems().isEmpty() && restaurantId != null && grandTotal != null) {

			Orders orders = new Orders();

			orders.setUserId(user.getUserId());
			orders.setRestaurantId(restaurantId);
			orders.setOrdersDate(new Timestamp(System.currentTimeMillis()));
			orders.setPaymentMethod(paymentMethod);
			orders.setStatus("Pending");
			orders.setTotalAmount(grandTotal);

			OrdersDAOImpl ordersDAOImpl = new OrdersDAOImpl();
			int ordersId = ordersDAOImpl.addOrders(orders);	

			// Save generated order id
			orders.setOrdersId(ordersId);


			OrderItem orderItem = new OrderItem();

			OrderItemDAOImpl orderItemDAOImpl = new OrderItemDAOImpl();

			for (CartItem items : cart.getItems().values()) {


				orderItem.setOrdersId(ordersId);

				orderItem.setMenuId(items.getMenuId());
				orderItem.setQuantity(items.getQuantity());
				orderItem.setItemTotal(items.getTotalPrice());

				orderItemDAOImpl.addOrderItem(orderItem);
			}

			//		OrderItemDAOImpl orderItemDAOImpl = new OrderItemDAOImpl();


			// Fetch Restaurant Details
			RestaurantDAOImpl restaurantDAOImpl = new RestaurantDAOImpl();
			Restaurant restaurant = restaurantDAOImpl.getRestaurant(restaurantId);

			// Store data for Confirmation Page
			session.setAttribute("currentOrder", orders);
			session.setAttribute("orderedItems", cart);
			session.setAttribute("restaurant", restaurant);


			// Store Delivery Address
			session.setAttribute("deliveryAddress", address);
			session.setAttribute("deliveryCity", city);
			session.setAttribute("deliveryPincode", pincode);

			session.removeAttribute("cart");
			session.removeAttribute("restaurantId");
			session.removeAttribute("grandTotal");

			resp.sendRedirect("orderconfirmation.jsp");

		}
		else {
			resp.sendRedirect("cart.jsp");
			return;
		}
	}
}















