package com.food.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.food.config.DBConfig;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("userEmail");
        String name = (String) session.getAttribute("user");
        
        // If not logged in, redirect to login
        if (email == null && name == null) {
            response.sendRedirect("Login");
            return;
        }
        
        try {
            Connection conn = DBConfig.getConnection();
            
            // Get user ID
            int userId = 0;
            String userSql = "SELECT id FROM users WHERE email = ? OR name = ?";
            PreparedStatement userPs = conn.prepareStatement(userSql);
            userPs.setString(1, email);
            userPs.setString(2, name);
            ResultSet userRs = userPs.executeQuery();
            
            if (userRs.next()) {
                userId = userRs.getInt("id");
            }
            
            if (userId == 0) {
                response.sendRedirect("Login");
                return;
            }
            
            // Get all orders for this user
            String orderSql = "SELECT o.id, o.total_amount, o.status, o.payment_method, o.stock_issue, o.order_date " +
                              "FROM orders o WHERE o.user_id = ? ORDER BY o.order_date DESC";
            PreparedStatement orderPs = conn.prepareStatement(orderSql);
            orderPs.setInt(1, userId);
            ResultSet orderRs = orderPs.executeQuery();
            
            ArrayList<Map<String, Object>> orders = new ArrayList<>();
            
            while (orderRs.next()) {
                Map<String, Object> order = new HashMap<>();
                order.put("id", orderRs.getInt("id"));
                order.put("total_amount", orderRs.getDouble("total_amount"));
                order.put("status", orderRs.getString("status"));
                order.put("payment_method", orderRs.getString("payment_method"));
                order.put("stock_issue", orderRs.getString("stock_issue"));
                order.put("order_date", orderRs.getTimestamp("order_date"));
                
                // Get order items for this order
                String itemSql = "SELECT oi.quantity, oi.price, f.name as food_name " +
                                 "FROM order_items oi JOIN food f ON oi.food_id = f.id " +
                                 "WHERE oi.order_id = ?";
                PreparedStatement itemPs = conn.prepareStatement(itemSql);
                itemPs.setInt(1, orderRs.getInt("id"));
                ResultSet itemRs = itemPs.executeQuery();
                
                ArrayList<Map<String, Object>> items = new ArrayList<>();
                while (itemRs.next()) {
                    Map<String, Object> item = new HashMap<>();
                    item.put("food_name", itemRs.getString("food_name"));
                    item.put("quantity", itemRs.getInt("quantity"));
                    item.put("price", itemRs.getDouble("price"));
                    items.add(item);
                }
                order.put("items", items);
                orders.add(order);
            }
            
            conn.close();
            
            // Send orders to JSP
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("WEB-INF/pages/orders.jsp")
                   .forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}