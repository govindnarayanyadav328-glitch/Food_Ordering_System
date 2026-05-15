package com.food.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.food.config.DBConfig;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/pages/forgot-password.jsp")
               .forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        
        try {
            Connection conn = DBConfig.getConnection();
            
            // Check if email exists
            String checkSql = "SELECT * FROM users WHERE email=?";
            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setString(1, email);
            ResultSet rs = checkPs.executeQuery();
            
            if (rs.next()) {
                // Update password
                String updateSql = "UPDATE users SET password=? WHERE email=?";
                PreparedStatement updatePs = conn.prepareStatement(updateSql);
                updatePs.setString(1, newPassword);
                updatePs.setString(2, email);
                updatePs.executeUpdate();
                
                response.sendRedirect("Login?msg=Password reset successfully");
            } else {
                response.sendRedirect("forgot-password?error=Email not found");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("forgot-password?error=Something went wrong");
        }
    }
}