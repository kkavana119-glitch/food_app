package com.food.servlets;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.List;

import com.food.DAOImpl.MenuDAOImpl;
import com.food.DAOImpl.OrdersDAOImpl;
import com.food.Model.Cart;
import com.food.Model.CartItem;
import com.food.Model.Menu;
import com.food.Model.Orders;
import com.food.Model.User;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/chat")
public class ChatBotServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	// Replace with your Groq API Key
	private static final String API_KEY = "gsk_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response)
					throws ServletException, IOException {

		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");

		String userMessage = request.getParameter("message");

		if (userMessage == null || userMessage.trim().isEmpty()) {
			response.getWriter().print("Please enter a message.");
			return;
		}

		String msg = userMessage.toLowerCase().trim();

		// -----------------------------
		// Greeting
		// -----------------------------
		if (msg.equals("hi") ||
				msg.equals("hello") ||
				msg.equals("hey")) {

			response.getWriter().print(
					"👋 Hello!\n\n" +
							"Welcome to FoodieExpress.\n\n" +
							"You can ask me:\n\n" +
							"• show menu\n" +
							"• show pizza\n" +
							"• show burger\n" +
							"• show biryani\n" +
							"• show desserts\n" +
							"• show chinese\n" +
							"• show pasta\n" +
							"• recommend pizza"
					);
			return;
		}

		// -----------------------------
		// Help
		// -----------------------------
		if (msg.equals("help")) {

			response.getWriter().print(
					"🍽 Supported Commands\n\n" +
							"show menu\n" +
							"show pizza\n" +
							"show burger\n" +
							"show biryani\n" +
							"show chinese\n" +
							"show seafood\n" +
							"show pasta\n" +
							"show desserts\n" +
							"show chicken\n" +
							"recommend pizza"
					);
			return;
		}

		MenuDAOImpl dao = new MenuDAOImpl();
		List<Menu> items = null;

		// -----------------------------
		// Show All Menu
		// -----------------------------
		if (msg.equals("show menu") ||
				msg.equals("menu") ||
				msg.equals("all menu")) {

			items = dao.getAllMenus();

			StringBuilder sb = new StringBuilder();

			sb.append("🍽 Available Menu\n\n");

			int count = 1;

			for (Menu menu : items) {

				sb.append(count++)
				.append(". ")
				.append(menu.getItemName())
				.append("\n");

				sb.append("💰 ₹")
				.append((int) menu.getPrice())
				.append("\n\n");
			}

			response.getWriter().print(sb.toString());
			return;
		}

		// -----------------------------
		// Smart Keyword Detection
		// -----------------------------

		String keyword = "";

		if (msg.contains("pizza"))
			keyword = "pizza";

		else if (msg.contains("burger"))
			keyword = "burger";

		else if (msg.contains("biryani"))
			keyword = "biryani";

		else if (msg.contains("dessert") ||
				msg.contains("desserts") ||
				msg.contains("sweet") ||
				msg.contains("cake"))
			keyword = "sweet";

		else if (msg.contains("ice cream") ||
				msg.contains("kulfi") ||
				msg.contains("sundae"))
			keyword = "ice cream";

		else if (msg.contains("coffee") ||
				msg.contains("cafe"))
			keyword = "green cafe";

		else if (msg.contains("healthy") ||
				msg.contains("salad") ||
				msg.contains("bowl"))
			keyword = "healthy";

		else if (msg.contains("chinese") ||
				msg.contains("noodles") ||
				msg.contains("manchurian"))
			keyword = "chinese";

		else if (msg.contains("south indian") ||
				msg.contains("dosa") ||
				msg.contains("idli"))
			keyword = "south indian";

		else if (msg.contains("tandoori"))
			keyword = "tandoori";

		else if (msg.contains("kebab"))
			keyword = "kebab";

		else if (msg.contains("seafood") ||
				msg.contains("fish") ||
				msg.contains("prawn") ||
				msg.contains("crab"))
			keyword = "seafood";

		else if (msg.contains("chicken"))
			keyword = "chicken";

		else if (msg.contains("pasta") ||
				msg.contains("lasagna") ||
				msg.contains("spaghetti"))
			keyword = "pasta";

		else if (msg.contains("taco") ||
				msg.contains("burrito") ||
				msg.contains("nachos"))
			keyword = "taco";

		// Database Search

		if (!keyword.isEmpty()) {

			items = dao.getMenuByCategory(keyword);

			if (items != null && !items.isEmpty()) {

				StringBuilder sb = new StringBuilder();

				sb.append("🍽 Results for ")
				.append(keyword.toUpperCase())
				.append("\n\n");

				int count = 1;

				for (Menu menu : items) {

					sb.append(count++)
					.append(". ")
					.append(menu.getItemName())
					.append("\n");

					sb.append("💰 ₹")
					.append((int) menu.getPrice())
					.append("\n\n");
				}

				response.getWriter().print(sb.toString());
				return;
			}
		}


		// ============================
		// CART COMMANDS
		// ============================

		if (msg.contains("cart")) {

			Cart cart = (Cart) request.getSession().getAttribute("cart");

			if (cart == null || cart.getItems().isEmpty()) {

				response.getWriter().print(
						"🛒 Your cart is currently empty.\n\n" +
								"Go to Menu and add some delicious food."
						);
				return;
			}

			response.getWriter().print(
					"🛒 You currently have " +
							cart.getItems().size() +
							" item(s) in your cart."
					);
			return;
		}

		if (msg.contains("cart total")
				|| msg.contains("bill")
				|| msg.contains("total")) {

			Cart cart = (Cart) request.getSession().getAttribute("cart");

			if (cart == null || cart.getItems().isEmpty()) {

				response.getWriter().print("🛒 Your cart is empty.");
				return;
			}

			double total = 0;

			for (CartItem item : cart.getItems().values()) {
				total += item.getPrice() * item.getQuantity();
			}

			double delivery = 40;
			double tax = total * 0.05;
			double grand = total + delivery + tax;

			response.getWriter().print(
					"💰 Bill Summary\n\n" +
							"Item Total : ₹" + String.format("%.2f", total) + "\n" +
							"Delivery : ₹40\n" +
							"GST (5%) : ₹" + String.format("%.2f", tax) + "\n\n" +
							"Grand Total : ₹" + String.format("%.2f", grand)
					);
			return;
		}

		if (msg.contains("checkout")) {

			response.getWriter().print(
					"💳 Click 'Proceed to Payment' to continue securely."
					);
			return;
		}

		if (msg.contains("delivery")) {

			response.getWriter().print(
					"🚚 Delivery charge is ₹40."
					);
			return;
		}

		if (msg.contains("coupon")
				|| msg.contains("offer")
				|| msg.contains("promo")) {

			response.getWriter().print(
					"🎉 Use coupon code FOOD50 to get exciting discounts."
					);
			return;
		}

		// ============================
		// CHECKOUT COMMANDS
		// ============================

		if (msg.contains("payment")
				|| msg.contains("payment methods")) {

			response.getWriter().print(
					"💳 Available Payment Methods\n\n" +
							"• UPI\n" +
							"• Credit Card\n" +
							"• Debit Card\n" +
							"• Net Banking\n" +
							"• Wallet\n" +
							"• Cash on Delivery (if available)"
					);
			return;
		}

		if (msg.contains("upi")
				|| msg.contains("gpay")
				|| msg.contains("google pay")
				|| msg.contains("phonepe")
				|| msg.contains("paytm")) {

			response.getWriter().print(
					"📱 You can pay using:\n\n" +
							"• Google Pay\n" +
							"• PhonePe\n" +
							"• Paytm\n" +
							"• BHIM UPI"
					);
			return;
		}

		if (msg.contains("credit card")
				|| msg.contains("debit card")
				|| msg.contains("card")) {

			response.getWriter().print(
					"💳 We accept Visa, MasterCard and RuPay cards."
					);
			return;
		}

		if (msg.contains("cash on delivery")
				|| msg.equals("cod")) {

			response.getWriter().print(
					"💵 Cash on Delivery is available for eligible locations."
					);
			return;
		}

		if (msg.contains("delivery time")
				|| msg.contains("estimated delivery")) {

			response.getWriter().print(
					"🚚 Your food is expected to arrive within 30–45 minutes."
					);
			return;
		}

		if (msg.contains("address")
				|| msg.contains("delivery address")) {

			response.getWriter().print(
					"📍 Your delivery address will be used for this order. You can edit it before placing the order."
					);
			return;
		}

		if (msg.contains("change address")) {

			response.getWriter().print(
					"✏️ You can change your delivery address before placing your order."
					);
			return;
		}

		if (msg.contains("place order")
				|| msg.contains("confirm order")) {

			response.getWriter().print(
					"✅ Click the 'Place Order' button to complete your order securely."
					);
			return;
		}

		if (msg.contains("refund")) {

			response.getWriter().print(
					"💰 Refunds are processed if the payment fails or the order is cancelled according to our refund policy."
					);
			return;
		}


		// ============================
		// LAST ORDER
		// ============================

		if (msg.contains("last order")
		        || msg.contains("latest order")
		        || msg.contains("recent order")) {

		    User user = (User) request.getSession().getAttribute("user");

		    if (user == null) {

		        response.getWriter().print(
		            "Please login to view your last order."
		        );
		        return;
		    }

		    OrdersDAOImpl ordersDAO = new OrdersDAOImpl();

		    List<Orders> orders = ordersDAO.getOrdersByUserId(user.getUserId());

		    if (orders == null || orders.isEmpty()) {

		        response.getWriter().print(
		            "You haven't placed any orders yet."
		        );
		        return;
		    }

		    Orders lastOrder = orders.get(0);

		    response.getWriter().print(

		        "🛍 Your Last Order\n\n" +

		        "Order ID : ORD" + lastOrder.getOrdersId() + "\n" +

		        "Amount : ₹" + String.format("%.2f",
		        lastOrder.getTotalAmount()) + "\n" +

		        "Status : " + lastOrder.getStatus() + "\n" +

		        "Payment : " + lastOrder.getPaymentMethod() + "\n" +

		        "Restaurant ID : " + lastOrder.getRestaurantId() + "\n" +

		        "Date : " + lastOrder.getOrdersDate()

		    );

		    return;
		}

		// ===== PART 2 CONTINUES FROM HERE =====

		// ============================
		// GROQ AI FALLBACK
		// ============================

		String json = """
				{
				  "model":"llama-3.3-70b-versatile",
				  "messages":[
				    {
				      "role":"system",
				      "content":"You are FoodieExpress AI Assistant. Help users with restaurants, menus, ordering, payments, delivery, offers and food recommendations. If the question is unrelated to FoodieExpress, politely reply that you only assist with FoodieExpress."
				    },
				    {
				      "role":"user",
				      "content":"%s"
				    }
				  ],
				  "temperature":0.7,
				  "max_tokens":300
				}
				""".formatted(userMessage.replace("\"", "\\\""));

		HttpClient client = HttpClient.newHttpClient();

		HttpRequest httpRequest = HttpRequest.newBuilder()
				.uri(URI.create("https://api.groq.com/openai/v1/chat/completions"))
				.header("Authorization", "Bearer " + API_KEY)
				.header("Content-Type", "application/json")
				.POST(HttpRequest.BodyPublishers.ofString(json))
				.build();

		try {

			HttpResponse<String> apiResponse =
					client.send(httpRequest,
							HttpResponse.BodyHandlers.ofString());

			String responseBody = apiResponse.body();

			JsonObject root =
					JsonParser.parseString(responseBody)
					.getAsJsonObject();

			JsonArray choices =
					root.getAsJsonArray("choices");

			if (choices != null && choices.size() > 0) {

				String reply = choices
						.get(0)
						.getAsJsonObject()
						.getAsJsonObject("message")
						.get("content")
						.getAsString();

				response.getWriter().print(reply);

			} else {

				response.getWriter().print(
						"Sorry, I couldn't generate a response."
						);

			}

		} catch (Exception e) {

			e.printStackTrace();

			response.getWriter().print(
					"Sorry! FoodieExpress AI is temporarily unavailable."
					);
		}

	}

}