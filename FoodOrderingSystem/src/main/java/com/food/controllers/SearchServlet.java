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

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String keyword = request.getParameter("keyword");
        
        if (keyword == null || keyword.trim().isEmpty()) {
            response.sendRedirect("menu");
            return;
        }
        
        try {
            Connection conn = DBConfig.getConnection();
            String sql = "SELECT * FROM food WHERE name LIKE ? OR category LIKE ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ResultSet rs = ps.executeQuery();
            
            ArrayList<Food> foods = new ArrayList<>();
            while (rs.next()) {
                Food f = new Food();
                f.setId(rs.getInt("id"));
                f.setName(rs.getString("name"));
                f.setCategory(rs.getString("category"));
                f.setPrice(rs.getDouble("price"));
                foods.add(f);
            }
            
            request.setAttribute("foods", foods);
            request.setAttribute("searchKeyword", keyword);
            request.getRequestDispatcher("WEB-INF/pages/menu.jsp")
                   .forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("menu");
        }
    }
}