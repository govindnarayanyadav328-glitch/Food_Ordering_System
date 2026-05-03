package com.food.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.food.config.DBConfig;
import com.google.gson.Gson;

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
        PrintWriter out = response.getWriter();
        
        try {
            Connection conn = DBConfig.getConnection();
            String sql = "SELECT * FROM orders ORDER BY order_date DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            ArrayList<Map<String, Object>> orders = new ArrayList<>();
            
            while (rs.next()) {
                Map<String, Object> order = new HashMap<>();
                order.put("id", rs.getInt("id"));
                order.put("user_id", rs.getInt("user_id"));
                order.put("total_amount", rs.getDouble("total_amount"));
                order.put("status", rs.getString("status"));
                order.put("order_date", rs.getTimestamp("order_date"));
                orders.add(order);
            }
            
            Gson gson = new Gson();
            out.print(gson.toJson(orders));
            
        } catch (Exception e) {
            e.printStackTrace();
            out.print("[]");
        }
    }
}