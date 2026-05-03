package com.food.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.food.config.DBConfig;
import com.food.model.Food;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/edit-food")
public class EditFoodServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Connection conn = DBConfig.getConnection();

            String sql = "SELECT * FROM food WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Food f = new Food();
                f.setId(rs.getInt("id"));
                f.setName(rs.getString("name"));
                f.setCategory(rs.getString("category"));
                f.setPrice(rs.getDouble("price"));

                request.setAttribute("food", f);
                request.getRequestDispatcher("WEB-INF/pages/editFood.jsp")
                       .forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}