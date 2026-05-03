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

@WebServlet("/menu")
public class FoodServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<Food> foodList = new ArrayList<>();

        try {
            Connection conn = DBConfig.getConnection();

            String sql = "SELECT * FROM food";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Food f = new Food();
                f.setId(rs.getInt("id"));
                f.setName(rs.getString("name"));
                f.setCategory(rs.getString("category"));
                f.setPrice(rs.getDouble("price"));

                foodList.add(f);
            }

            request.setAttribute("foods", foodList);
            request.getRequestDispatcher("WEB-INF/pages/menu.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}