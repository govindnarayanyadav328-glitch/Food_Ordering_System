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
        String email = (String) session.getAttribute("userEmail");
        String userName = (String) session.getAttribute("user");
        String paymentMethod = request.getParameter("paymentMethod");

        try {
            if (cart == null || cart.isEmpty()) {
                response.sendRedirect("Cart");
                return;
            }

            Connection conn = DBConfig.getConnection();
            
            // Get user ID
            int userId = 0;
            if (email != null && !email.isEmpty()) {
                PreparedStatement userPs = conn.prepareStatement("SELECT id FROM users WHERE email = ?");
                userPs.setString(1, email);
                ResultSet userRs = userPs.executeQuery();
                if (userRs.next()) userId = userRs.getInt("id");
            }
            if (userId == 0 && userName != null && !userName.isEmpty()) {
                PreparedStatement userPs = conn.prepareStatement("SELECT id FROM users WHERE name = ?");
                userPs.setString(1, userName);
                ResultSet userRs = userPs.executeQuery();
                if (userRs.next()) userId = userRs.getInt("id");
            }
            if (userId == 0) {
                PreparedStatement userPs = conn.prepareStatement("SELECT id FROM users WHERE role = 'user' LIMIT 1");
                ResultSet userRs = userPs.executeQuery();
                if (userRs.next()) userId = userRs.getInt("id");
            }
            
            if (userId == 0) {
                response.getWriter().println("<h3>Error: No user found. Please register first.</h3>");
                return;
            }

            // Check stock for all items
            boolean stockAvailable = true;
            StringBuilder outOfStockMessage = new StringBuilder();
            
            for (CartItem item : cart) {
                PreparedStatement stockPs = conn.prepareStatement("SELECT name, stock FROM food WHERE id=?");
                stockPs.setInt(1, item.getId());
                ResultSet stockRs = stockPs.executeQuery();
                
                if (stockRs.next()) {
                    int currentStock = stockRs.getInt("stock");
                    if (currentStock < item.getQuantity()) {
                        stockAvailable = false;
                        outOfStockMessage.append(stockRs.getString("name")).append(" (Need: ").append(item.getQuantity()).append(", Available: ").append(currentStock).append("), ");
                    }
                }
            }
            
            // Set order status based on stock availability
            String orderStatus = stockAvailable ? "Completed" : "Pending";
            String stockIssue = stockAvailable ? null : outOfStockMessage.toString();

            double totalAmount = 0;
            for (CartItem item : cart) {
                totalAmount += item.getPrice() * item.getQuantity();
            }

            // Insert order
            String sql = "INSERT INTO orders (user_id, total_amount, status, payment_method, stock_issue, order_date) VALUES (?, ?, ?, ?, ?, NOW())";
            PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setInt(1, userId);
            ps.setDouble(2, totalAmount);
            ps.setString(3, orderStatus);
            ps.setString(4, paymentMethod);
            ps.setString(5, stockIssue);
            ps.executeUpdate();

            // Get order ID
            ResultSet generatedKeys = ps.getGeneratedKeys();
            int orderId = 0;
            if (generatedKeys.next()) {
                orderId = generatedKeys.getInt(1);
            }

            // Insert order items and reduce stock
            String itemSql = "INSERT INTO order_items (order_id, food_id, quantity, price) VALUES (?, ?, ?, ?)";
            PreparedStatement itemPs = conn.prepareStatement(itemSql);
            
            for (CartItem item : cart) {
                // Get current stock
                PreparedStatement stockPs = conn.prepareStatement("SELECT stock FROM food WHERE id=?");
                stockPs.setInt(1, item.getId());
                ResultSet stockRs = stockPs.executeQuery();
                int currentStock = 0;
                if (stockRs.next()) currentStock = stockRs.getInt("stock");
                
                int actualQuantity = item.getQuantity();
                if (currentStock < actualQuantity) {
                    actualQuantity = currentStock;
                }
                
                // Insert order item
                itemPs.setInt(1, orderId);
                itemPs.setInt(2, item.getId());
                itemPs.setInt(3, actualQuantity);
                itemPs.setDouble(4, item.getPrice());
                itemPs.addBatch();
                
                // Reduce stock
                PreparedStatement updateStockPs = conn.prepareStatement("UPDATE food SET stock = stock - ? WHERE id = ?");
                updateStockPs.setInt(1, actualQuantity);
                updateStockPs.setInt(2, item.getId());
                updateStockPs.executeUpdate();
            }
            itemPs.executeBatch();

            // Clear cart
            session.removeAttribute("cart");
            
            // Store success message
            session.setAttribute("paymentSuccess", true);
            session.setAttribute("orderId", orderId);
            session.setAttribute("paymentMethod", paymentMethod);
            session.setAttribute("orderStatus", orderStatus);
            
            if (!stockAvailable) {
                session.setAttribute("orderMessage", "Your order has been placed successfully! It will be processed once stock is available.");
            } else {
                session.setAttribute("orderMessage", "Your order has been placed successfully!");
            }
            
            response.sendRedirect("order-success");

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<h3>Payment Failed: " + e.getMessage() + "</h3>");
            response.getWriter().println("<a href='Cart' style='background: #ff6b35; color: white; padding: 0.5rem 1rem; text-decoration: none; border-radius: 5px; display: inline-block; margin-top: 1rem;'>Go Back to Cart</a>");
        }
    }
}