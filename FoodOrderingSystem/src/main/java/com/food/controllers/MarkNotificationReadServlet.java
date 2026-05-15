package com.food.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.food.config.DBConfig;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/api/mark-notification-read")
public class MarkNotificationReadServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        int notificationId = Integer.parseInt(request.getParameter("notificationId"));
        
        try {
            Connection conn = DBConfig.getConnection();
            String sql = "UPDATE user_notifications SET is_read = true WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, notificationId);
            ps.executeUpdate();
            
            out.print("{\"success\": true}");
            
        } catch (Exception e) {
            out.print("{\"success\": false}");
        }
    }
}