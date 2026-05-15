<%@ page import="java.util.*, java.sql.*, com.food.config.DBConfig" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    pageContext.setAttribute("pageTitle", "My Orders");
    
    // Get logged in user
    String loggedInUserEmail = (String) session.getAttribute("userEmail");
    String loggedInUserName = (String) session.getAttribute("user");
    String loggedInUserRole = (String) session.getAttribute("role");
    
    if (loggedInUserEmail == null && loggedInUserName == null) {
        response.sendRedirect("Login");
        return;
    }
    
    boolean isAdmin = "admin".equals(loggedInUserRole);
    
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    ArrayList<Map<String, Object>> orders = new ArrayList<>();
    
    try {
        conn = DBConfig.getConnection();
        
        int userId = 0;
        
        // Get user ID
        if (!isAdmin) {
            String userSql = "SELECT id FROM users WHERE email = ? OR name = ?";
            PreparedStatement userPs = conn.prepareStatement(userSql);
            userPs.setString(1, loggedInUserEmail);
            userPs.setString(2, loggedInUserName);
            ResultSet userRs = userPs.executeQuery();
            if (userRs.next()) {
                userId = userRs.getInt("id");
            }
        }
        
        // Get orders - For admin: get all orders, for user: get only their orders
        String orderSql;
        if (isAdmin) {
            orderSql = "SELECT o.id, o.user_id, o.total_amount, o.status, o.payment_method, o.stock_issue, o.order_date, u.name as user_name " +
                       "FROM orders o LEFT JOIN users u ON o.user_id = u.id ORDER BY o.order_date DESC";
            ps = conn.prepareStatement(orderSql);
        } else {
            orderSql = "SELECT id, total_amount, status, payment_method, stock_issue, order_date FROM orders WHERE user_id = ? ORDER BY order_date DESC";
            ps = conn.prepareStatement(orderSql);
            ps.setInt(1, userId);
        }
        
        rs = ps.executeQuery();
        
        while (rs.next()) {
            Map<String, Object> order = new HashMap<>();
            order.put("id", rs.getInt("id"));
            order.put("total_amount", rs.getDouble("total_amount"));
            order.put("status", rs.getString("status"));
            order.put("payment_method", rs.getString("payment_method"));
            order.put("stock_issue", rs.getString("stock_issue"));
            order.put("order_date", rs.getTimestamp("order_date"));
            
            if (isAdmin) {
                order.put("user_id", rs.getInt("user_id"));
                order.put("user_name", rs.getString("user_name"));
            }
            
            // Get order items
            String itemSql = "SELECT oi.quantity, oi.price, f.name as food_name FROM order_items oi JOIN food f ON oi.food_id = f.id WHERE oi.order_id = ?";
            PreparedStatement itemPs = conn.prepareStatement(itemSql);
            itemPs.setInt(1, rs.getInt("id"));
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
            itemRs.close();
        }
        
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch(Exception e) {}
        if (ps != null) try { ps.close(); } catch(Exception e) {}
        if (conn != null) try { conn.close(); } catch(Exception e) {}
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= isAdmin ? "All Orders - Admin" : "My Orders" %> - FoodieHub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .navbar {
            background: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
            width: 100%;
        }
        .navbar-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }
        .logo {
            font-size: 1.5rem;
            font-weight: bold;
            color: #ff6b35;
            text-decoration: none;
        }
        .nav-menu {
            display: flex;
            gap: 1rem;
            align-items: center;
            flex-wrap: wrap;
        }
        .nav-link {
            text-decoration: none;
            color: #2c3e50;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.3s;
        }
        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        .user-avatar {
            width: 38px;
            height: 38px;
            border-radius: 50%;
            background: linear-gradient(135deg, #ff6b35, #ff8c5a);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .btn {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 0.875rem;
            font-weight: 600;
            text-decoration: none;
        }
        .btn-danger { background: #e74c3c; color: white; }
        .btn-primary { background: #ff6b35; color: white; display: inline-block; }
        .container { max-width: 1200px; margin: 0 auto; padding: 2rem; }
        .orders-container {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 { margin-bottom: 2rem; color: #2c3e50; }
        .order-card {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 1rem;
            margin-bottom: 1rem;
            border-left: 4px solid #ff6b35;
        }
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.5rem;
            flex-wrap: wrap;
        }
        .order-id { font-weight: bold; color: #ff6b35; }
        .order-status {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: bold;
        }
        .status-completed { background: #27ae60; color: white; }
        .status-pending { background: #f39c12; color: white; }
        .status-cancelled { background: #e74c3c; color: white; }
        .order-details { margin-top: 0.5rem; }
        .order-details p { margin: 0.25rem 0; font-size: 0.875rem; }
        .items-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 0.5rem;
        }
        .items-table th, .items-table td {
            padding: 0.5rem;
            text-align: left;
            border-bottom: 1px solid #dee2e6;
        }
        .items-table th { background: #e9ecef; font-weight: 600; font-size: 0.8rem; }
        .stock-issue {
            background: #fff3cd;
            padding: 0.5rem;
            border-radius: 8px;
            margin-top: 0.5rem;
            font-size: 0.8rem;
            color: #856404;
        }
        .empty-orders { text-align: center; padding: 3rem; color: #6c757d; }
        .empty-orders i { font-size: 3rem; margin-bottom: 1rem; opacity: 0.5; }
        .footer {
            background: #2c3e50;
            color: white;
            text-align: center;
            padding: 1.5rem;
            margin-top: 3rem;
        }
        @media (max-width: 768px) {
            .navbar-container, .nav-menu { flex-direction: column; text-align: center; }
            .order-header { flex-direction: column; gap: 0.5rem; align-items: flex-start; }
        }
    </style>
</head>
<body>

<nav class="navbar">
    <div class="navbar-container">
        <a href="${pageContext.request.contextPath}/Home" class="logo">
            <i class="fas fa-utensils"></i> FoodieHub
        </a>
        <div class="nav-menu">
            <a href="${pageContext.request.contextPath}/Home" class="nav-link">Home</a>
            <a href="${pageContext.request.contextPath}/menu" class="nav-link">Menu</a>
            <a href="${pageContext.request.contextPath}/Cart" class="nav-link">Cart</a>
            <a href="${pageContext.request.contextPath}/OrderServlet" class="nav-link">Orders</a>
            <% if (loggedInUserName != null) { %>
                <div class="user-info">
                    <div class="user-avatar"><i class="fas fa-user"></i></div>
                    <span>Welcome, <%= loggedInUserName %></span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">Logout</a>
                </div>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/Login" class="nav-link">Login</a>
                <a href="${pageContext.request.contextPath}/register" class="nav-link">Register</a>
            <% } %>
        </div>
    </div>
</nav>

<div class="container">
    <div class="orders-container">
        <h1><i class="fas fa-receipt"></i> <%= isAdmin ? "All Customer Orders" : "My Orders" %></h1>
        
        <% if (orders != null && !orders.isEmpty()) { 
            for (Map<String, Object> order : orders) { 
                String status = (String) order.get("status");
                String statusClass = "";
                if ("Completed".equals(status)) statusClass = "status-completed";
                else if ("Pending".equals(status)) statusClass = "status-pending";
                else if ("Cancelled".equals(status)) statusClass = "status-cancelled";
        %>
            <div class="order-card">
                <div class="order-header">
                    <span class="order-id">Order #<%= order.get("id") %></span>
                    <span class="order-status <%= statusClass %>"><%= status %></span>
                </div>
                <div class="order-details">
                    <p><strong>Order Date:</strong> <%= order.get("order_date") %></p>
                    <% if (isAdmin && order.get("user_name") != null) { %>
                        <p><strong>Customer:</strong> <%= order.get("user_name") %></p>
                    <% } %>
                    <p><strong>Payment Method:</strong> <%= order.get("payment_method") != null ? order.get("payment_method") : "N/A" %></p>
                    <p><strong>Total Amount:</strong> Rs. <%= order.get("total_amount") %></p>
                    
                    <% if (order.get("stock_issue") != null) { %>
                        <div class="stock-issue">
                            <i class="fas fa-exclamation-triangle"></i> <%= order.get("stock_issue") %>
                        </div>
                    <% } %>
                    
                    <table class="items-table">
                        <thead>
                            <tr><th>Item</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>
                        </thead>
                        <tbody>
                            <% ArrayList<Map<String, Object>> items = (ArrayList<Map<String, Object>>) order.get("items");
                               for (Map<String, Object> item : items) { %>
                                <td><%= item.get("food_name") %></td>
                                <td><%= item.get("quantity") %></td>
                                <td>Rs. <%= item.get("price") %></td>
                                <td>Rs. <%= (double)item.get("price") * (int)item.get("quantity") %></td>
                              </tr>
                            <% } %>
                        </tbody>
                     </table>
                </div>
            </div>
        <% } 
        } else { %>
            <div class="empty-orders">
                <i class="fas fa-receipt"></i>
                <p>No orders found</p>
                <a href="${pageContext.request.contextPath}/menu" class="btn btn-primary" style="margin-top: 1rem;">Start Ordering</a>
            </div>
        <% } %>
    </div>
</div>

<footer class="footer">
    <p>&copy; 2024 FoodieHub. All rights reserved.</p>
</footer>

</body>
</html>