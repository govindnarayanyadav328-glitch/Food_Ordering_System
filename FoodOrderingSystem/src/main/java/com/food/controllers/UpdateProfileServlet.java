package com.food.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.food.config.DBConfig;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("userEmail");
        String userName = (String) session.getAttribute("user");
        
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        try {
            Connection conn = DBConfig.getConnection();
            String sql = "UPDATE users SET name=?, phone=?, address=? WHERE email=? OR name=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setString(3, address);
            ps.setString(4, userEmail);
            ps.setString(5, userName);
            ps.executeUpdate();
            
            session.setAttribute("user", name);
            conn.close();
            
            response.sendRedirect("profile?msg=Profile updated successfully");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("profile?msg=Error updating profile");
        }
    }
}