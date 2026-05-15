<%@ page import="java.util.*, com.food.model.CartItem" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    pageContext.setAttribute("pageTitle", "Shopping Cart");
    ArrayList<CartItem> cart = (ArrayList<CartItem>) session.getAttribute("cart");
    String user = (String) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart - FoodieHub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        :root {
            --primary: #ff6b35;
            --primary-dark: #e55a2b;
            --secondary: #2c3e50;
            --success: #27ae60;
            --danger: #e74c3c;
            --white: #ffffff;
            --gray-100: #f8f9fa;
            --gray-300: #dee2e6;
            --text-dark: #2c3e50;
            --shadow: 0 2px 4px rgba(0,0,0,0.1);
            --shadow-lg: 0 10px 15px rgba(0,0,0,0.1);
            --radius: 8px;
            --radius-lg: 16px;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        
        .navbar {
            background: var(--white);
            box-shadow: var(--shadow-lg);
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
            color: var(--primary);
            text-decoration: none;
        }
        
        .nav-menu {
            display: flex;
            gap: 1.5rem;
            align-items: center;
            flex-wrap: wrap;
        }
        
        .nav-link {
            text-decoration: none;
            color: var(--text-dark);
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.3s;
        }
        
        .nav-link:hover {
            color: var(--primary);
            background: rgba(255, 107, 53, 0.1);
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), #ff8c5a);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .btn-primary {
            background: var(--primary);
            color: white;
        }
        
        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
        }
        
        .btn-secondary {
            background: var(--secondary);
            color: white;
        }
        
        .btn-success {
            background: var(--success);
            color: white;
        }
        
        .btn-danger {
            background: var(--danger);
            color: white;
        }
        
        .btn-sm {
            padding: 0.4rem 0.8rem;
            font-size: 0.875rem;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .cart-container {
            background: white;
            border-radius: var(--radius-lg);
            padding: 2rem;
            box-shadow: var(--shadow-lg);
        }
        
        .cart-header {
            display: flex;
            justify-content: space-between;
            padding: 1rem;
            background: var(--gray-100);
            border-radius: 8px;
            margin-bottom: 1rem;
            font-weight: bold;
        }
        
        .cart-header > div:first-child { flex: 2; }
        .cart-header > div { flex: 1; text-align: center; }
        .cart-header > div:last-child { text-align: right; }
        
        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem;
            border-bottom: 1px solid var(--gray-300);
        }
        
        .cart-item-info { flex: 2; }
        .cart-item-price { flex: 1; text-align: center; }
        .cart-item-quantity { flex: 1; text-align: center; }
        .cart-item-total { flex: 1; text-align: right; font-weight: bold; }
        
        .quantity-form {
            display: inline-flex;
            gap: 0.5rem;
            align-items: center;
        }
        
        .quantity-btn {
            background: var(--gray-100);
            border: 1px solid var(--gray-300);
            width: 30px;
            height: 30px;
            border-radius: 50%;
            cursor: pointer;
            font-size: 1rem;
            font-weight: bold;
            transition: all 0.3s;
        }
        
        .quantity-btn:hover {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
        }
        
        .remove-btn {
            background: var(--danger);
            color: white;
            border: none;
            padding: 0.25rem 0.75rem;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.7rem;
            margin-left: 0.5rem;
        }
        
        .cart-summary {
            margin-top: 2rem;
            padding-top: 1rem;
            border-top: 2px solid var(--primary);
            text-align: right;
        }
        
        .cart-total {
            font-size: 1.5rem;
            font-weight: bold;
            color: var(--primary);
        }
        
        .cart-actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            margin-top: 2rem;
        }
        
        .empty-cart {
            text-align: center;
            padding: 3rem;
        }
        
        .footer {
            background: var(--secondary);
            color: white;
            padding: 2rem 0 1rem;
            margin-top: 3rem;
            width: 100%;
        }
        
        .footer-bottom {
            text-align: center;
            padding-top: 1rem;
            border-top: 1px solid rgba(255,255,255,0.1);
            font-size: 0.75rem;
        }
        
        @media (max-width: 768px) {
            .navbar-container, .nav-menu {
                flex-direction: column;
                text-align: center;
            }
            .cart-header {
                display: none;
            }
            .cart-item {
                flex-direction: column;
                text-align: center;
                gap: 0.5rem;
            }
            .cart-actions {
                flex-direction: column;
            }
            .cart-actions .btn {
                width: 100%;
            }
            .container {
                padding: 1rem;
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
            <a href="${pageContext.request.contextPath}/Home" class="nav-link"><i class="fas fa-home"></i> Home</a>
            <a href="${pageContext.request.contextPath}/menu" class="nav-link"><i class="fas fa-utensils"></i> Menu</a>
            <a href="${pageContext.request.contextPath}/Cart" class="nav-link"><i class="fas fa-shopping-cart"></i> Cart</a>
            <% if (user == null) { %>
                <a href="${pageContext.request.contextPath}/Login" class="nav-link"><i class="fas fa-sign-in-alt"></i> Login</a>
                <a href="${pageContext.request.contextPath}/register" class="nav-link"><i class="fas fa-user-plus"></i> Register</a>
            <% } else { %>
                <div class="user-info">
                    <div class="user-avatar"><i class="fas fa-user"></i></div>
                    <span>Welcome, <%= user %></span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            <% } %>
        </div>
    </div>
</nav>

<div class="container">
    <h1 style="text-align: center; margin-bottom: 2rem;"><i class="fas fa-shopping-cart"></i> Your Cart</h1>
    
    <div class="cart-container">
        <% if (cart != null && !cart.isEmpty()) { 
            double grandTotal = 0;
        %>
            <div class="cart-header">
                <div>Item</div>
                <div>Price</div>
                <div>Quantity</div>
                <div>Total</div>
            </div>
            
            <% for (CartItem item : cart) {
                double subtotal = item.getPrice() * item.getQuantity();
                grandTotal += subtotal;
            %>
                <div class="cart-item">
                    <div class="cart-item-info">
                        <h3><%= item.getName() %></h3>
                    </div>
                    <div class="cart-item-price">
                        Rs. <%= item.getPrice() %>
                    </div>
                    <div class="cart-item-quantity">
                        <form action="${pageContext.request.contextPath}/update-cart" method="get" class="quantity-form">
                            <input type="hidden" name="itemId" value="<%= item.getId() %>">
                            <button type="submit" name="action" value="decrease" class="quantity-btn">-</button>
                            <span style="min-width: 30px; text-align: center;"><%= item.getQuantity() %></span>
                            <button type="submit" name="action" value="increase" class="quantity-btn">+</button>
                            <button type="submit" name="action" value="remove" class="remove-btn"><i class="fas fa-trash"></i> Remove</button>
                        </form>
                    </div>
                    <div class="cart-item-total">
                        Rs. <%= subtotal %>
                    </div>
                </div>
            <% } %>
            
            <div class="cart-summary">
                <h2 class="cart-total">Grand Total: Rs. <%= grandTotal %></h2>
            </div>
            
            <div class="cart-actions">
                <a href="${pageContext.request.contextPath}/menu" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Continue Shopping
                </a>
                <a href="${pageContext.request.contextPath}/payment" class="btn btn-success">
                    <i class="fas fa-credit-card"></i> Proceed to Payment
                </a>
            </div>
        <% } else { %>
            <div class="empty-cart">
                <i class="fas fa-shopping-cart" style="font-size: 4rem; color: #adb5bd; margin-bottom: 1rem;"></i>
                <h3>Your cart is empty</h3>
                <p>Looks like you haven't added any items to your cart yet</p>
                <a href="${pageContext.request.contextPath}/menu" class="btn btn-primary" style="margin-top: 1rem;">
                    <i class="fas fa-utensils"></i> Browse Menu
                </a>
            </div>
        <% } %>
    </div>
</div>

<footer class="footer">
    <div class="footer-bottom">
        <p>&copy; 2024 FoodieHub. All rights reserved.</p>
    </div>
</footer>

</body>
</html>