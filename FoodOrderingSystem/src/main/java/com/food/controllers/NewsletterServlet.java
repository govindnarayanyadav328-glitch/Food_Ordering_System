package com.food.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.food.config.DBConfig;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/subscribe-newsletter")
public class NewsletterServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        String email = request.getParameter("email");
        
        if (email == null || email.trim().isEmpty()) {
            out.print("{\"success\": false, \"message\": \"Email is required\"}");
            return;
        }
        
        try {
            Connection conn = DBConfig.getConnection();
            String sql = "INSERT INTO newsletter_subscribers (email) VALUES (?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.executeUpdate();
            
            out.print("{\"success\": true, \"message\": \"Subscribed successfully!\"}");
            
        } catch (Exception e) {
            if (e.getMessage().contains("Duplicate")) {
                out.print("{\"success\": false, \"message\": \"This email is already subscribed!\"}");
            } else {
                out.print("{\"success\": false, \"message\": \"Subscription failed. Please try again.\"}");
            }
        }
    }
}