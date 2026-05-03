<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'Food Ordering System'} - FoodieHub</title>
    
    <!-- Try multiple path options (one will work) -->
    <!-- Option 1: Using context path -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
    
    <!-- Fallback: Direct path -->
    <link rel="stylesheet" href="/FoodOrderingSystem/css/base.css">
    <link rel="stylesheet" href="/FoodOrderingSystem/css/layout.css">
    <link rel="stylesheet" href="/FoodOrderingSystem/css/components.css">
    
    <!-- Conditional CSS -->
    <% 
        String requestURI = request.getRequestURI();
        if (requestURI.contains("/Admin") || requestURI.contains("/edit-food")) {
    %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <% } %>
    
    <% if (requestURI.contains("/Cart")) { %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css">
    <% } %>
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        /* Emergency fallback CSS in case external CSS fails */
        body { 
            font-family: Arial, sans-serif; 
            margin: 0; 
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .container { max-width: 1200px; margin: auto; }
        .btn { 
            display: inline-block; 
            padding: 10px 20px; 
            background: #ff6b35; 
            color: white; 
            text-decoration: none; 
            border-radius: 5px;
        }
    /* Complete CSS - Copy paste all CSS content here temporarily */
    :root {
        --primary: #ff6b35;
        --secondary: #2c3e50;
        --success: #27ae60;
        --danger: #e74c3c;
    }
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
    }
    .navbar {
        background: white;
        padding: 1rem 2rem;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    .navbar-container {
        max-width: 1200px;
        margin: auto;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .logo {
        font-size: 1.5rem;
        font-weight: bold;
        color: var(--primary);
        text-decoration: none;
    }
    .nav-menu {
        display: flex;
        gap: 1.5rem;
        align-items: center;
    }
    .nav-link {
        text-decoration: none;
        color: #333;
        padding: 0.5rem 1rem;
    }
    .btn {
        display: inline-block;
        padding: 0.75rem 1.5rem;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        text-decoration: none;
        font-weight: 600;
    }
    .btn-primary {
        background: var(--primary);
        color: white;
    }
    .btn-danger {
        background: var(--danger);
        color: white;
        padding: 0.5rem 1rem;
    }
    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 2rem;
    }
    .hero-section {
        text-align: center;
        padding: 4rem;
        background: linear-gradient(135deg, var(--primary), #ff8c5a);
        border-radius: 12px;
        color: white;
    }
    .card {
        background: white;
        border-radius: 12px;
        padding: 1.5rem;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    .form-container {
        max-width: 500px;
        margin: 2rem auto;
        background: white;
        padding: 2rem;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.15);
    }
    .form-control {
        width: 100%;
        padding: 0.75rem;
        border: 2px solid #ddd;
        border-radius: 8px;
        margin-bottom: 1rem;
    }
    .alert {
        padding: 1rem;
        border-radius: 8px;
        margin-bottom: 1rem;
    }
    .alert-success {
        background: #d4edda;
        color: #155724;
    }
    .alert-danger {
        background: #f8d7da;
        color: #721c24;
    }
    .menu-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 2rem;
        padding: 2rem 0;
    }
    .food-card {
        background: white;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    .food-info {
        padding: 1.5rem;
    }
    .food-price {
        font-size: 1.5rem;
        font-weight: bold;
        color: var(--primary);
        margin: 1rem 0;
    }
    @media (max-width: 768px) {
        .navbar-container {
            flex-direction: column;
        }
        .nav-menu {
            flex-direction: column;
            width: 100%;
        }
        .menu-grid {
            grid-template-columns: 1fr;
        }
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
                <a href="${pageContext.request.contextPath}/Home" class="nav-link">
                    <i class="fas fa-home"></i> Home
                </a>
                
                <%
                    String user = (String) session.getAttribute("user");
                    String role = (String) session.getAttribute("role");
                    
                    if (user != null && "admin".equals(role)) {
                %>
                    <a href="${pageContext.request.contextPath}/Admin" class="nav-link">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/menu" class="nav-link">
                        <i class="fas fa-utensils"></i> Menu
                    </a>
                <% } else if (user != null) { %>
                    <a href="${pageContext.request.contextPath}/menu" class="nav-link">
                        <i class="fas fa-utensils"></i> Menu
                    </a>
                    <a href="${pageContext.request.contextPath}/Cart" class="nav-link">
                        <i class="fas fa-shopping-cart"></i> Cart
                    </a>
                <% } %>
                
                <% if (user == null) { %>
                    <a href="${pageContext.request.contextPath}/Login" class="nav-link">
                        <i class="fas fa-sign-in-alt"></i> Login
                    </a>
                    <a href="${pageContext.request.contextPath}/register" class="nav-link">
                        <i class="fas fa-user-plus"></i> Register
                    </a>
                <% } else { %>
                    <div class="user-info">
                        <div class="user-avatar">
                            <i class="fas fa-user"></i>
                        </div>
                        <span>Welcome, <%= user %></span>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </div>
                <% } %>
            </div>
        </div>
    </nav>
    <div class="container fade-in">