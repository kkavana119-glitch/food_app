package com.food.servlets;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/PaymentSuccessServlet")
public class PaymentSuccessServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Get payment details from Razorpay
        String paymentId = req.getParameter("paymentId");
        String orderId = req.getParameter("orderId");

        // Session (optional: use if you stored cart/user details)
        HttpSession session = req.getSession(false);

        if (session == null) {
            resp.sendRedirect("login.html");
            return;
        }

        // 🔥 PRINT FOR DEBUG
        System.out.println("================================");
        System.out.println("PAYMENT SUCCESS");
        System.out.println("Payment ID: " + paymentId);
        System.out.println("Order ID: " + orderId);
        System.out.println("================================");

        // TODO STEP (IMPORTANT FOR YOUR PROJECT):
        // 1. Save payment details into DB
        // 2. Update order status = SUCCESS
        // 3. Clear cart session

        /*
        Example DAO logic (if you have OrderDAOImpl):

        OrdersDAOImpl dao = new OrdersDAOImpl();
        dao.updatePaymentStatus(orderId, paymentId, "SUCCESS");
        */

        // Redirect to success page
        resp.sendRedirect("orderSuccess.jsp");
    }
}