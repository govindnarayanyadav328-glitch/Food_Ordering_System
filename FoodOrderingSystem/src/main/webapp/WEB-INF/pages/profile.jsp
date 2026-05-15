<%@ page import="java.sql.*, com.food.config.DBConfig" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    pageContext.setAttribute("pageTitle", "My Profile");
    
    String userName = (String) session.getAttribute("user");
    String userEmail = (String) session.getAttribute("userEmail");
    
    if (userName == null) {
        response.sendRedirect("Login");
        return;
    }
    
    String name = "";
    String email = "";
    String phone = "";
    String address = "";
    
    try {
        Connection conn = DBConfig.getConnection();
        String sql = "SELECT * FROM users WHERE email=? OR name=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, userEmail);
        ps.setString(2, userName);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            name = rs.getString("name");
            email = rs.getString("email");
            phone = rs.getString("phone") != null ? rs.getString("phone") : "";
            address = rs.getString("address") != null ? rs.getString("address") : "";
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - FoodieHub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .container { max-width: 800px; margin: 2rem auto; padding: 2rem; background: white; border-radius: 16px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        h1 { margin-bottom: 2rem; color: #2c3e50; }
        .form-group { margin-bottom: 1.5rem; }
        label { display: block; margin-bottom: 0.5rem; font-weight: 600; color: #2c3e50; }
        input, textarea { width: 100%; padding: 0.75rem; border: 2px solid #dee2e6; border-radius: 8px; font-size: 1rem; }
        input:focus, textarea:focus { outline: none; border-color: #ff6b35; }
        .btn { padding: 0.75rem 1.5rem; border: none; border-radius: 8px; cursor: pointer; font-size: 1rem; font-weight: 600; background: #ff6b35; color: white; }
        .btn:hover { background: #e55a2b; }
        .alert { padding: 1rem; border-radius: 8px; margin-bottom: 1rem; }
        .alert-success { background: #d4edda; color: #155724; }
        .text-center { text-align: center; }
    </style>
</head>
<body>

<div class="container">
    <h1><i class="fas fa-user-circle"></i> My Profile</h1>
    
    <% String msg = request.getParameter("msg"); %>
    <% if (msg != null) { %>
        <div class="alert alert-success"><%= msg %></div>
    <% } %>
    
    <form action="${pageContext.request.contextPath}/UpdateProfileServlet" method="post">
        <div class="form-group">
            <label>Full Name</label>
            <input type="text" name="name" value="<%= name %>" required>
        </div>
        <div class="form-group">
            <label>Email</label>
            <input type="email" name="email" value="<%= email %>" readonly style="background:#f8f9fa">
        </div>
        <div class="form-group">
            <label>Phone Number</label>
            <input type="text" name="phone" value="<%= phone %>">
        </div>
        <div class="form-group">
            <label>Address</label>
            <textarea name="address" rows="3"><%= address %></textarea>
        </div>
        <div class="text-center">
            <button type="submit" class="btn">Update Profile</button>
            <a href="${pageContext.request.contextPath}/Home" style="margin-left: 1rem; color: #6c757d;">Cancel</a>
        </div>
    </form>
</div>

</body>
</html>