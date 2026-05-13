package com.food.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.food.config.DBConfig;
import com.food.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/process-payment")
public class OrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        @SuppressWarnings("unchecked")
        ArrayList<CartItem> cart = (ArrayList<CartItem>) session.getAttribute("cart");
        String email = (String) session.getAttribute("user");
        String paymentMethod = request.getParameter("paymentMethod");

        try {
            if (cart == null || cart.isEmpty()) {
                response.sendRedirect("Cart");
                return;
            }

            Connection conn = DBConfig.getConnection();

            // Get user ID from email
            int userId = 1;
            String userSql = "SELECT id FROM users WHERE email=?";
            PreparedStatement userPs = conn.prepareStatement(userSql);
            userPs.setString(1, email);
            ResultSet userRs = userPs.executeQuery();
            if (userRs.next()) {
                userId = userRs.getInt("id");
            }

            double totalAmount = 0;
            for (CartItem item : cart) {
                totalAmount += item.getPrice() * item.getQuantity();
            }

            // Insert order
            String sql = "INSERT INTO orders (user_id, total_amount, status, payment_method, order_date) VALUES (?, ?, ?, ?, NOW())";
            PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setInt(1, userId);
            ps.setDouble(2, totalAmount);
            ps.setString(3, "Completed");
            ps.setString(4, paymentMethod);
            ps.executeUpdate();

            // Get the order ID
            ResultSet generatedKeys = ps.getGeneratedKeys();
            int orderId = 0;
            if (generatedKeys.next()) {
                orderId = generatedKeys.getInt(1);
            }

            // Insert order items
            String itemSql = "INSERT INTO order_items (order_id, food_id, quantity, price) VALUES (?, ?, ?, ?)";
            PreparedStatement itemPs = conn.prepareStatement(itemSql);
            
            for (CartItem item : cart) {
                itemPs.setInt(1, orderId);
                itemPs.setInt(2, item.getId());
                itemPs.setInt(3, item.getQuantity());
                itemPs.setDouble(4, item.getPrice());
                itemPs.addBatch();
            }
            itemPs.executeBatch();

            // Clear cart
            session.removeAttribute("cart");
            
            // Store success message
            session.setAttribute("paymentSuccess", true);
            session.setAttribute("orderId", orderId);
            session.setAttribute("paymentMethod", paymentMethod);
            
            // Redirect to success page - USE .jsp extension
            response.sendRedirect("order-success");

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<h3>Payment Failed: " + e.getMessage() + "</h3>");
            response.getWriter().println("<a href='Cart' style='background: #ff6b35; color: white; padding: 0.5rem 1rem; text-decoration: none; border-radius: 5px; display: inline-block; margin-top: 1rem;'>Go Back to Cart</a>");
        }
    }
}