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

            // Get all food items with stock
            PreparedStatement foodPs = conn.prepareStatement("SELECT * FROM food ORDER BY id");
            ResultSet foodRs = foodPs.executeQuery();

            ArrayList<Food> foodList = new ArrayList<>();
            while (foodRs.next()) {
                Food f = new Food();
                f.setId(foodRs.getInt("id"));
                f.setName(foodRs.getString("name"));
                f.setCategory(foodRs.getString("category"));
                f.setPrice(foodRs.getDouble("price"));
                f.setStock(foodRs.getInt("stock"));
                foodList.add(f);
            }
            
            // Get all orders with items (for detailed order list)
            String orderSql = "SELECT o.id, o.user_id, o.total_amount, o.status, o.payment_method, o.stock_issue, o.order_date, u.name as user_name " +
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
                order.put("stock_issue", orderRs.getString("stock_issue"));
                order.put("order_date", orderRs.getTimestamp("order_date"));
                
                // Get order items
                String itemSql = "SELECT oi.quantity, oi.price, f.name as food_name " +
                                 "FROM order_items oi JOIN food f ON oi.food_id = f.id " +
                                 "WHERE oi.order_id = ?";
                PreparedStatement itemPs = conn.prepareStatement(itemSql);
                itemPs.setInt(1, orderRs.getInt("id"));
                ResultSet itemRs = itemPs.executeQuery();
                
                ArrayList<Object> items = new ArrayList<>();
                while (itemRs.next()) {
                    java.util.Map<String, Object> item = new java.util.HashMap<>();
                    item.put("food_name", itemRs.getString("food_name"));
                    item.put("quantity", itemRs.getInt("quantity"));
                    item.put("price", itemRs.getDouble("price"));
                    items.add(item);
                }
                order.put("items", items);
                ordersList.add(order);
            }
            
            // Get pending orders count
            PreparedStatement pendingPs = conn.prepareStatement("SELECT COUNT(*) as total FROM orders WHERE status = 'Pending'");
            ResultSet pendingRs = pendingPs.executeQuery();
            int pendingOrders = 0;
            if (pendingRs.next()) pendingOrders = pendingRs.getInt("total");
            
            // Get total orders count
            PreparedStatement countPs = conn.prepareStatement("SELECT COUNT(*) as total FROM orders");
            ResultSet countRs = countPs.executeQuery();
            int totalOrders = 0;
            if (countRs.next()) totalOrders = countRs.getInt("total");
            
            // Get total users count
            PreparedStatement userPs = conn.prepareStatement("SELECT COUNT(*) as total FROM users WHERE role = 'user'");
            ResultSet userRs = userPs.executeQuery();
            int totalUsers = 0;
            if (userRs.next()) totalUsers = userRs.getInt("total");
            
            // Get total revenue
            PreparedStatement revenuePs = conn.prepareStatement("SELECT SUM(total_amount) as total FROM orders WHERE status = 'Completed'");
            ResultSet revenueRs = revenuePs.executeQuery();
            double totalRevenue = 0;
            if (revenueRs.next()) totalRevenue = revenueRs.getDouble("total");

            // Get low stock items
            PreparedStatement lowStockPs = conn.prepareStatement("SELECT * FROM food WHERE stock <= 5 ORDER BY stock ASC");
            ResultSet lowStockRs = lowStockPs.executeQuery();
            ArrayList<Food> lowStockItems = new ArrayList<>();
            while (lowStockRs.next()) {
                Food f = new Food();
                f.setId(lowStockRs.getInt("id"));
                f.setName(lowStockRs.getString("name"));
                f.setStock(lowStockRs.getInt("stock"));
                lowStockItems.add(f);
            }

            request.setAttribute("foods", foodList);
            request.setAttribute("ordersList", ordersList);
            request.setAttribute("pendingOrders", pendingOrders);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("lowStockItems", lowStockItems);

            request.getRequestDispatcher("WEB-INF/pages/Admin.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}