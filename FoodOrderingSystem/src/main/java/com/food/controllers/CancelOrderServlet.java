package com.food.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.food.config.DBConfig;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cancel-order")
public class CancelOrderServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("userEmail");
        String userName = (String) session.getAttribute("user");
        
        if ((email == null && userName == null)) {
            out.print("{\"success\": false, \"message\": \"Please login first\"}");
            return;
        }
        
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        
        try {
            Connection conn = DBConfig.getConnection();
            
            // Get user ID
            int userId = 0;
            String userSql = "SELECT id FROM users WHERE email=? OR name=?";
            PreparedStatement userPs = conn.prepareStatement(userSql);
            userPs.setString(1, email);
            userPs.setString(2, userName);
            ResultSet userRs = userPs.executeQuery();
            if (userRs.next()) {
                userId = userRs.getInt("id");
            }
            
            if (userId == 0) {
                out.print("{\"success\": false, \"message\": \"User not found\"}");
                return;
            }
            
            // Check if order belongs to user and is pending
            String checkSql = "SELECT status FROM orders WHERE id=? AND user_id=?";
            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setInt(1, orderId);
            checkPs.setInt(2, userId);
            ResultSet checkRs = checkPs.executeQuery();
            
            if (checkRs.next()) {
                String status = checkRs.getString("status");
                if (!"Pending".equals(status)) {
                    out.print("{\"success\": false, \"message\": \"Only pending orders can be cancelled\"}");
                    return;
                }
            } else {
                out.print("{\"success\": false, \"message\": \"Order not found\"}");
                return;
            }
            
            // Update order status to Cancelled
            String sql = "UPDATE orders SET status='Cancelled' WHERE id=? AND user_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.setInt(2, userId);
            int updated = ps.executeUpdate();
            
            if (updated > 0) {
                out.print("{\"success\": true, \"message\": \"Order cancelled successfully\"}");
            } else {
                out.print("{\"success\": false, \"message\": \"Failed to cancel order\"}");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
        }
    }
}