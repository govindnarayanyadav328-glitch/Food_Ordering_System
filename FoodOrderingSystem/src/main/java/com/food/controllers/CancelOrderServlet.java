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

@WebServlet("/CancelOrderServlet")
public class CancelOrderServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("userEmail");
        String name = (String) session.getAttribute("user");
        
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        
        try {
            Connection conn = DBConfig.getConnection();
            
            // Get user ID
            int userId = 0;
            String userSql = "SELECT id FROM users WHERE email=? OR name=?";
            PreparedStatement ps1 = conn.prepareStatement(userSql);
            ps1.setString(1, email);
            ps1.setString(2, name);
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) {
                userId = rs1.getInt("id");
            }
            
            // Cancel order
            String sql = "UPDATE orders SET status='Cancelled' WHERE id=? AND user_id=?";
            PreparedStatement ps2 = conn.prepareStatement(sql);
            ps2.setInt(1, orderId);
            ps2.setInt(2, userId);
            int updated = ps2.executeUpdate();
            
            if (updated > 0) {
                out.print("{\"success\": true, \"message\": \"Order cancelled\"}");
            } else {
                out.print("{\"success\": false, \"message\": \"Failed to cancel\"}");
            }
            
        } catch (Exception e) {
            out.print("{\"success\": false, \"message\": \"Error\"}");
        }
    }
}