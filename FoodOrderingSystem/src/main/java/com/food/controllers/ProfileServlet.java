package com.food.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.food.config.DBConfig;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("userEmail");
        String name = (String) session.getAttribute("user");
        
        if (email == null && name == null) {
            response.sendRedirect("Login");
            return;
        }
        
        try {
            Connection conn = DBConfig.getConnection();
            String sql = "SELECT * FROM users WHERE email=? OR name=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, name);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                request.setAttribute("userName", rs.getString("name"));
                request.setAttribute("userEmail", rs.getString("email"));
                request.setAttribute("userPhone", rs.getString("phone"));
                request.setAttribute("userAddress", rs.getString("address"));
            }
            conn.close();
            
            request.getRequestDispatcher("WEB-INF/pages/profile.jsp")
                   .forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Home");
        }
    }
}