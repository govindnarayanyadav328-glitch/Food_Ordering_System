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

@WebServlet("/api/my-orders")
public class OrderApiServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("userEmail");
        String userName = (String) session.getAttribute("user");
        
        if (email == null && userName == null) {
            out.print("[]");
            return;
        }
        
        try {
            Connection conn = DBConfig.getConnection();
            
            // Get user ID using email
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
                out.print("[]");
                return;
            }
            
            // Get user orders
            String sql = "SELECT id, total_amount, status, payment_method, order_date FROM orders WHERE user_id=? ORDER BY order_date DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            StringBuilder json = new StringBuilder();
            json.append("[");
            
            boolean first = true;
            while (rs.next()) {
                if (!first) {
                    json.append(",");
                }
                first = false;
                
                json.append("{");
                json.append("\"id\":").append(rs.getInt("id")).append(",");
                json.append("\"total_amount\":").append(rs.getDouble("total_amount")).append(",");
                json.append("\"status\":\"").append(rs.getString("status")).append("\",");
                json.append("\"payment_method\":\"").append(rs.getString("payment_method") != null ? rs.getString("payment_method") : "N/A").append("\",");
                json.append("\"order_date\":\"").append(rs.getTimestamp("order_date")).append("\"");
                json.append("}");
            }
            
            json.append("]");
            out.print(json.toString());
            
        } catch (Exception e) {
            e.printStackTrace();
            out.print("[]");
        }
    }
}