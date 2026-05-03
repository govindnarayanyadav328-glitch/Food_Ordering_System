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
            
            // 2. Get total orders count
            String orderSql = "SELECT COUNT(*) as total FROM orders";
            PreparedStatement orderPs = conn.prepareStatement(orderSql);
            ResultSet orderRs = orderPs.executeQuery();
            int totalOrders = 0;
            if (orderRs.next()) {
                totalOrders = orderRs.getInt("total");
            }
            
            // 3. Get total users count (only regular users, not admins)
            String userSql = "SELECT COUNT(*) as total FROM users WHERE role = 'user'";
            PreparedStatement userPs = conn.prepareStatement(userSql);
            ResultSet userRs = userPs.executeQuery();
            int totalUsers = 0;
            if (userRs.next()) {
                totalUsers = userRs.getInt("total");
            }
            
            // 4. Get total revenue (sum of all order amounts)
            String revenueSql = "SELECT SUM(total_amount) as total FROM orders WHERE status != 'Cancelled'";
            PreparedStatement revenuePs = conn.prepareStatement(revenueSql);
            ResultSet revenueRs = revenuePs.executeQuery();
            double totalRevenue = 0;
            if (revenueRs.next()) {
                totalRevenue = revenueRs.getDouble("total");
            }

            // Set all attributes to pass to JSP
            request.setAttribute("foods", foodList);
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