package com.food.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.food.config.DBConfig;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/approve-order")
public class ApproveOrderServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        
        try {
            Connection conn = DBConfig.getConnection();
            
            // Check if stock is now available for this order
            String checkSql = "SELECT oi.food_id, oi.quantity, f.stock, f.name " +
                              "FROM order_items oi " +
                              "JOIN food f ON oi.food_id = f.id " +
                              "WHERE oi.order_id = ?";
            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setInt(1, orderId);
            ResultSet checkRs = checkPs.executeQuery();
            
            boolean stockAvailable = true;
            String insufficientItems = "";
            while (checkRs.next()) {
                int needed = checkRs.getInt("quantity");
                int available = checkRs.getInt("stock");
                String foodName = checkRs.getString("name");
                if (available < needed) {
                    stockAvailable = false;
                    insufficientItems += foodName + " (Need: " + needed + ", Available: " + available + "), ";
                }
            }
            
            if (stockAvailable) {
                // First, get order details for notification
                String orderSql = "SELECT o.user_id, u.email, u.name FROM orders o " +
                                  "JOIN users u ON o.user_id = u.id WHERE o.id = ?";
                PreparedStatement orderPs = conn.prepareStatement(orderSql);
                orderPs.setInt(1, orderId);
                ResultSet orderRs = orderPs.executeQuery();
                
                int userId = 0;
                String userEmail = "";
                String userName = "";
                if (orderRs.next()) {
                    userId = orderRs.getInt("user_id");
                    userEmail = orderRs.getString("email");
                    userName = orderRs.getString("name");
                }
                
                // Deduct stock
                String deductSql = "UPDATE food f JOIN order_items oi ON f.id = oi.food_id " +
                                   "SET f.stock = f.stock - oi.quantity WHERE oi.order_id = ?";
                PreparedStatement deductPs = conn.prepareStatement(deductSql);
                deductPs.setInt(1, orderId);
                deductPs.executeUpdate();
                
                // Update order status
                String updateSql = "UPDATE orders SET status = 'Completed' WHERE id = ?";
                PreparedStatement updatePs = conn.prepareStatement(updateSql);
                updatePs.setInt(1, orderId);
                updatePs.executeUpdate();
                
                // Create notification for user
                String notifySql = "INSERT INTO user_notifications (user_id, order_id, message, is_read, created_at) " +
                                   "VALUES (?, ?, 'Your order #" + orderId + " has been approved and is ready for delivery!', false, NOW())";
                PreparedStatement notifyPs = conn.prepareStatement(notifySql);
                notifyPs.setInt(1, userId);
                notifyPs.setInt(2, orderId);
                notifyPs.executeUpdate();
                
                response.sendRedirect("Admin?message=Order #" + orderId + " approved successfully! User has been notified.");
                
            } else {
                response.sendRedirect("Admin?error=Cannot approve order. Insufficient stock: " + insufficientItems);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Admin?error=Failed to approve order: " + e.getMessage());
        }
    }
}