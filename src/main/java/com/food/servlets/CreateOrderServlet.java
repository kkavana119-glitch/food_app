package com.food.servlets;

import java.io.IOException;

import org.json.JSONObject;

import com.razorpay.Order;
import com.razorpay.RazorpayClient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CreateOrderServlet")
public class CreateOrderServlet extends HttpServlet {

    private static final String KEY_ID = "rzp_test_T9p8VqN8pMu7xS";
    private static final String KEY_SECRET = "098VzM5Kk0Gtf904p326Mvrm";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            String amt = req.getParameter("amount");
            double amountRupees = Double.parseDouble(amt);

            int amountPaise = (int) (amountRupees * 100);

            RazorpayClient client = new RazorpayClient(KEY_ID, KEY_SECRET);

            JSONObject orderRequest = new JSONObject();
            orderRequest.put("amount", amountPaise);
            orderRequest.put("currency", "INR");
            orderRequest.put("payment_capture", 1);

            Order order = client.Orders.create(orderRequest);

            resp.setContentType("application/json");
            resp.getWriter().print(order.toString());

        } catch (Exception e) {
            e.printStackTrace();

            resp.setContentType("application/json");
            resp.getWriter().print("{\"error\":\"Order creation failed\"}");
        }
    }
}