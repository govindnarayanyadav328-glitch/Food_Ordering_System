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

@WebServlet("/api/orders")
public class OrderApiServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            Connection conn = DBConfig.getConnection();
            String sql = "SELECT id, user_id, total_amount, status, order_date FROM orders ORDER BY order_date DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            // Manually create JSON without Gson
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
                json.append("\"user_id\":").append(rs.getInt("user_id")).append(",");
                json.append("\"total_amount\":").append(rs.getDouble("total_amount")).append(",");
                json.append("\"status\":\"").append(escapeJson(rs.getString("status"))).append("\",");
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
    
    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
    }
}