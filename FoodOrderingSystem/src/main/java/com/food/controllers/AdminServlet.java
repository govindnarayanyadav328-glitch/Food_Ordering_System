package com.food.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.food.config.DBConfig;
import com.food.model.Food;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/Admin")
public class AdminServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Connection conn = DBConfig.getConnection();

            // 1. Get all food items
            String foodSql = "SELECT * FROM food";
            PreparedStatement foodPs = conn.prepareStatement(foodSql);
            ResultSet foodRs = foodPs.executeQuery();

            ArrayList<Food> foodList = new ArrayList<>();
            while (foodRs.next()) {
                Food f = new Food();
                f.setId(foodRs.getInt("id"));
                f.setName(foodRs.getString("name"));
                f.setCategory(foodRs.getString("category"));
                f.setPrice(foodRs.getDouble("price"));
                foodList.add(f);
            }
            
            // 2. Get all orders with user details
            String orderSql = "SELECT o.id, o.user_id, o.total_amount, o.status, o.payment_method, o.order_date, u.name as user_name " +
                              "FROM orders o LEFT JOIN users u ON o.user_id = u.id ORDER BY o.order_date DESC";
            PreparedStatement orderPs = conn.prepareStatement(orderSql);
            ResultSet orderRs = orderPs.executeQuery();
            
            ArrayList<Object> ordersList = new ArrayList<>();
            while (orderRs.next()) {
                java.util.Map<String, Object> order = new java.util.HashMap<>();
                order.put("id", orderRs.getInt("id"));
                order.put("user_id", orderRs.getInt("user_id"));
                order.put("user_name", orderRs.getString("user_name"));
                order.put("total_amount", orderRs.getDouble("total_amount"));
                order.put("status", orderRs.getString("status"));
                order.put("payment_method", orderRs.getString("payment_method"));
                order.put("order_date", orderRs.getTimestamp("order_date"));
                ordersList.add(order);
            }
            
            // 3. Get total orders count
            String countSql = "SELECT COUNT(*) as total FROM orders";
            PreparedStatement countPs = conn.prepareStatement(countSql);
            ResultSet countRs = countPs.executeQuery();
            int totalOrders = 0;
            if (countRs.next()) {
                totalOrders = countRs.getInt("total");
            }
            
            // 4. Get total users count (only regular users, not admins)
            String userSql = "SELECT COUNT(*) as total FROM users WHERE role = 'user'";
            PreparedStatement userPs = conn.prepareStatement(userSql);
            ResultSet userRs = userPs.executeQuery();
            int totalUsers = 0;
            if (userRs.next()) {
                totalUsers = userRs.getInt("total");
            }
            
            // 5. Get total revenue (sum of all order amounts)
            String revenueSql = "SELECT SUM(total_amount) as total FROM orders WHERE status != 'Cancelled'";
            PreparedStatement revenuePs = conn.prepareStatement(revenueSql);
            ResultSet revenueRs = revenuePs.executeQuery();
            double totalRevenue = 0;
            if (revenueRs.next()) {
                totalRevenue = revenueRs.getDouble("total");
            }

            // Set all attributes to pass to JSP
            request.setAttribute("foods", foodList);
            request.setAttribute("ordersList", ordersList);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalRevenue", totalRevenue);

            request.getRequestDispatcher("WEB-INF/pages/Admin.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}