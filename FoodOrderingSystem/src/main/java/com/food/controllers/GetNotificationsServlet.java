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

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/api/notifications")
public class GetNotificationsServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("userEmail");
        String name = (String) session.getAttribute("user");
        
        if (email == null && name == null) {
            out.print("[]");
            return;
        }
        
        try {
            Connection conn = DBConfig.getConnection();
            
            // Get user ID
            int userId = 0;
            String userSql = "SELECT id FROM users WHERE email=? OR name=?";
            PreparedStatement ps1 = conn.prepareStatement(userSql);
            ps1.setString(1, email);
            ps1.setString(2, name);
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) userId = rs1.getInt("id");
            
            if (userId == 0) {
                out.print("[]");
                return;
            }
            
            // Get notifications
            String sql = "SELECT id, message, is_read, created_at FROM user_notifications WHERE user_id=? ORDER BY created_at DESC";
            PreparedStatement ps2 = conn.prepareStatement(sql);
            ps2.setInt(1, userId);
            ResultSet rs2 = ps2.executeQuery();
            
            ArrayList<Map<String, Object>> notifications = new ArrayList<>();
            while (rs2.next()) {
                Map<String, Object> notif = new HashMap<>();
                notif.put("id", rs2.getInt("id"));
                notif.put("message", rs2.getString("message"));
                notif.put("is_read", rs2.getBoolean("is_read"));
                notif.put("created_at", rs2.getTimestamp("created_at").toString());
                notifications.add(notif);
            }
            
            // Manual JSON
            StringBuilder json = new StringBuilder();
            json.append("[");
            for (int i = 0; i < notifications.size(); i++) {
                if (i > 0) json.append(",");
                json.append("{");
                json.append("\"id\":").append(notifications.get(i).get("id")).append(",");
                json.append("\"message\":\"").append(notifications.get(i).get("message")).append("\",");
                json.append("\"is_read\":").append(notifications.get(i).get("is_read")).append(",");
                json.append("\"created_at\":\"").append(notifications.get(i).get("created_at")).append("\"");
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