<%@ page import="java.util.*, com.food.model.Food" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    pageContext.setAttribute("pageTitle", "Menu");
    ArrayList<Food> foods = (ArrayList<Food>) request.getAttribute("foods");
    String success = request.getParameter("success");
    
    // Get user and role from session
    String loggedInUser = (String) session.getAttribute("user");
    String userRole = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu - FoodieHub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
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
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .nav-menu {
            display: flex;
            gap: 1.5rem;
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
        
        .nav-link:hover {
            color: #ff6b35;
            background: rgba(255,107,53,0.1);
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
            background: linear-gradient(135deg, #ff6b35, #ff8c5a);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
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
            background: #ff6b35;
            color: white;
        }
        
        .btn-primary:hover {
            background: #e55a2b;
            transform: translateY(-2px);
        }
        
        .btn-secondary {
            background: #2c3e50;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #1a252f;
            transform: translateY(-2px);
        }
        
        .btn-danger {
            background: #e74c3c;
            color: white;
            padding: 0.5rem 1rem;
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
        
        .menu-page-wrapper {
            background: linear-gradient(rgba(0, 0, 0, 0.65), rgba(0, 0, 0, 0.65)), 
                        url('https://images.pexels.com/photos/260922/pexels-photo-260922.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            border-radius: 20px;
            padding: 2rem;
            margin: 0 0 1rem 0;
        }
        
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 2rem;
            padding: 2rem 0;
        }
        
        .food-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            transition: all 0.3s ease;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        
        .food-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.25);
            background: white;
        }
        
        .food-image {
            height: 200px;
            overflow: hidden;
        }
        
        .food-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        
        .food-card:hover .food-image img {
            transform: scale(1.1);
        }
        
        .food-info {
            padding: 1.5rem;
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        
        .food-title {
            font-size: 1.25rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
            color: #2c3e50;
        }
        
        .food-category {
            color: #ff6b35;
            font-size: 0.875rem;
            display: inline-block;
            padding: 0.25rem 0.75rem;
            background: rgba(255, 107, 53, 0.15);
            border-radius: 20px;
            margin-bottom: 1rem;
            align-self: flex-start;
        }
        
        .food-price {
            font-size: 1.5rem;
            font-weight: bold;
            color: #ff6b35;
            margin: 0.5rem 0 1rem;
        }
        
        .food-price::before {
            content: 'Rs. ';
            font-size: 1rem;
            font-weight: normal;
        }
        
        .food-actions {
            margin-top: auto;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }
        
        .view-only {
            text-align: center;
            padding: 0.75rem;
            background: rgba(0,0,0,0.05);
            border-radius: 8px;
            color: #6c757d;
            font-size: 0.875rem;
        }
        
        .menu-title {
            text-align: center;
            color: white;
            margin-bottom: 1rem;
        }
        
        .menu-title h1 {
            font-size: 3rem;
            margin-bottom: 0.5rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .menu-title p {
            font-size: 1.1rem;
            opacity: 0.9;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
        }
        
        .alert {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
        }
        
        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .footer {
            background: #2c3e50;
            color: white;
            padding: 3rem 0 1.5rem;
            margin-top: 3rem;
            width: 100%;
        }
        
        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 2rem;
        }
        
        .footer-section h3 {
            margin-bottom: 1rem;
            color: #ff6b35;
            font-size: 1.25rem;
        }
        
        .footer-section p, .footer-section ul {
            color: #adb5bd;
        }
        
        .footer-section ul {
            list-style: none;
            padding: 0;
        }
        
        .footer-section ul li {
            margin-bottom: 0.5rem;
        }
        
        .footer-section a {
            color: #adb5bd;
            text-decoration: none;
        }
        
        .footer-section a:hover {
            color: #ff6b35;
        }
        
        .footer-bottom {
            text-align: center;
            padding-top: 2rem;
            margin-top: 2rem;
            border-top: 1px solid rgba(255,255,255,0.1);
        }
        
        @media (max-width: 1200px) {
            .menu-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 1.5rem;
            }
        }
        
        @media (max-width: 768px) {
            .menu-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }
            .menu-page-wrapper {
                padding: 1rem;
            }
            .menu-title h1 {
                font-size: 2rem;
            }
            .footer-content {
                grid-template-columns: 1fr;
                text-align: center;
            }
            .navbar-container {
                flex-direction: column;
            }
            .nav-menu {
                flex-direction: column;
                width: 100%;
            }
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar">
    <div class="navbar-container">
        <a href="${pageContext.request.contextPath}/Home" class="logo">
            <i class="fas fa-utensils"></i> FoodieHub
        </a>
        
        <div class="nav-menu">
            <a href="${pageContext.request.contextPath}/Home" class="nav-link">
                <i class="fas fa-home"></i> Home
            </a>
            
            <% if (loggedInUser != null && "admin".equals(userRole)) { %>
                <a href="${pageContext.request.contextPath}/Admin" class="nav-link">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/menu" class="nav-link">
                    <i class="fas fa-utensils"></i> Menu
                </a>
            <% } else if (loggedInUser != null) { %>
                <a href="${pageContext.request.contextPath}/menu" class="nav-link">
                    <i class="fas fa-utensils"></i> Menu
                </a>
                <a href="${pageContext.request.contextPath}/Cart" class="nav-link">
                    <i class="fas fa-shopping-cart"></i> Cart
                </a>
            <% } %>
            
            <% if (loggedInUser == null) { %>
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
                    <span>Welcome, <%= loggedInUser %></span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            <% } %>
        </div>
    </div>
</nav>

<div class="container">
    <div class="menu-page-wrapper">
        <% if (success != null) { %>
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> Item added to cart successfully!
            </div>
        <% } %>
        
        <div class="menu-title">
            <h1><i class="fas fa-utensils"></i> Our Delicious Menu</h1>
            <p>Freshly prepared with love ❤️ | Authentic taste | Quick delivery</p>
        </div>
        
        <div class="menu-grid">
            <% if (foods != null && !foods.isEmpty()) { 
                for (Food f : foods) {
                    String foodName = f.getName().toLowerCase().trim();
                    String imgUrl = "";
                    
                    // Exact image mapping based on food name
                    if (foodName.equals("chowmein")) {
                        imgUrl = "https://images.pexels.com/photos/1279330/pexels-photo-1279330.jpeg?auto=compress&cs=tinysrgb&w=500&h=300&fit=crop";
                    } 
                    else if (foodName.equals("cheese pizza")) {
                        imgUrl = "https://images.pexels.com/photos/803290/pexels-photo-803290.jpeg?auto=compress&cs=tinysrgb&w=500&h=300&fit=crop";
                    } 
                    else if (foodName.equals("chicken pizza")) {
                        imgUrl = "https://images.pexels.com/photos/825661/pexels-photo-825661.jpeg?auto=compress&cs=tinysrgb&w=500&h=300&fit=crop";
                    } 
                    else if (foodName.equals("mojito")) {
                        imgUrl = "https://images.pexels.com/photos/2109099/pexels-photo-2109099.jpeg?auto=compress&cs=tinysrgb&w=500&h=300&fit=crop";
                    } 
                    else if (foodName.equals("pizza")) {
                        imgUrl = "https://images.pexels.com/photos/825661/pexels-photo-825661.jpeg?auto=compress&cs=tinysrgb&w=500&h=300&fit=crop";
                    }
                    else if (foodName.contains("pizza")) {
                        imgUrl = "https://images.pexels.com/photos/825661/pexels-photo-825661.jpeg?auto=compress&cs=tinysrgb&w=500&h=300&fit=crop";
                    }
                    else {
                        imgUrl = "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=500&h=300&fit=crop";
                    }
            %>
                <div class="food-card">
                    <div class="food-image">
                        <img src="<%= imgUrl %>" alt="<%= f.getName() %>">
                    </div>
                    <div class="food-info">
                        <h3 class="food-title"><%= f.getName() %></h3>
                        <span class="food-category">
                            <i class="fas fa-tag"></i> <%= f.getCategory() %>
                        </span>
                        <div class="food-price">Rs. <%= String.format("%.0f", f.getPrice()) %></div>
                        
                        <div class="food-actions">
                            <% if (loggedInUser != null && !"admin".equals(userRole)) { %>
                                <form action="${pageContext.request.contextPath}/add-to-cart" method="post">
                                    <input type="hidden" name="id" value="<%= f.getId() %>">
                                    <input type="hidden" name="name" value="<%= f.getName() %>">
                                    <input type="hidden" name="price" value="<%= f.getPrice() %>">
                                    <button type="submit" class="btn btn-primary" style="width: 100%;">
                                        <i class="fas fa-cart-plus"></i> Add to Cart
                                    </button>
                                </form>
                                <a href="${pageContext.request.contextPath}/Cart" class="btn btn-secondary" style="width: 100%; text-align: center;">
                                    <i class="fas fa-shopping-cart"></i> View Cart
                                </a>
                            <% } else if (loggedInUser != null && "admin".equals(userRole)) { %>
                                <div class="view-only">
                                    <i class="fas fa-eye"></i> View Only - Admin Access
                                </div>
                            <% } else { %>
                                <a href="${pageContext.request.contextPath}/Login" class="btn btn-primary" style="width: 100%; text-align: center;">
                                    <i class="fas fa-sign-in-alt"></i> Login to Order
                                </a>
                            <% } %>
                        </div>
                    </div>
                </div>
            <% 
                }
            } else { 
            %>
                <div style="grid-column: 1 / -1; text-align: center; padding: 3rem; background: rgba(255,255,255,0.9); border-radius: 16px;">
                    <i class="fas fa-utensils" style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.5;"></i>
                    <h3>No items in menu</h3>
                    <p>Check back later for delicious items!</p>
                </div>
            <% } %>
        </div>
    </div>
</div>

<!-- Footer -->
    </div>
    
    <footer class="footer">
        <div class="footer-content">
            <!-- Column 1: About FoodieHub -->
            <div class="footer-section">
                <h3><i class="fas fa-utensils"></i> About FoodieHub</h3>
                <p>Your favorite food delivery service. Fresh, fast, and delicious meals delivered to your doorstep.</p>
                <div class="footer-social" style="margin-top: 1rem;">
                    <a href="#" style="margin-right: 1rem;"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" style="margin-right: 1rem;"><i class="fab fa-instagram"></i></a>
                    <a href="#" style="margin-right: 1rem;"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-youtube"></i></a>
                </div>
            </div>
            
            <!-- Column 2: Quick Links -->
            <div class="footer-section">
                <h3><i class="fas fa-link"></i> Quick Links</h3>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/Home"><i class="fas fa-chevron-right"></i> Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/menu"><i class="fas fa-chevron-right"></i> Menu</a></li>
                    <% if (session.getAttribute("user") == null) { %>
                        <li><a href="${pageContext.request.contextPath}/Login"><i class="fas fa-chevron-right"></i> Login</a></li>
                        <li><a href="${pageContext.request.contextPath}/register"><i class="fas fa-chevron-right"></i> Register</a></li>
                    <% } else { %>
                        <li><a href="${pageContext.request.contextPath}/Cart"><i class="fas fa-chevron-right"></i> Cart</a></li>
                    <% } %>
                    <li><a href="#"><i class="fas fa-chevron-right"></i> Offers</a></li>
                    <li><a href="#"><i class="fas fa-chevron-right"></i> Blog</a></li>
                </ul>
            </div>
            
            <!-- Column 3: Contact Us -->
            <div class="footer-section">
                <h3><i class="fas fa-headset"></i> Contact Us</h3>
                <ul class="contact-info">
                    <li><i class="fas fa-phone-alt"></i> <a href="tel:+9779800000000">+977 9800000000</a></li>
                    <li><i class="fas fa-envelope"></i> <a href="mailto:info@foodiehub.com">info@foodiehub.com</a></li>
                    <li><i class="fas fa-map-marker-alt"></i> Kathmandu, Nepal</li>
                    <li><i class="fas fa-clock"></i> Mon-Sun: 10:00 AM - 10:00 PM</li>
                </ul>
            </div>
            
            <!-- Column 4: Newsletter Subscription -->
            <div class="footer-section">
                <h3><i class="fas fa-envelope-open-text"></i> Subscribe to Our Daily Newsletter</h3>
                <p style="margin-bottom: 1rem;">Get latest updates about new dishes, offers and events!</p>
                
                <form id="newsletterForm" onsubmit="return subscribeNewsletter(event)">
                    <div style="display: flex; gap: 0.5rem; margin-bottom: 0.5rem;">
                        <input type="email" id="newsletterEmail" placeholder="Your email address" required 
                               style="flex: 1; padding: 0.75rem; border: none; border-radius: 8px; background: #f8f9fa;">
                        <button type="submit" style="padding: 0.75rem 1.5rem; background: #ff6b35; color: white; border: none; border-radius: 8px; cursor: pointer; transition: all 0.3s;">
                            <i class="fas fa-paper-plane"></i> Subscribe
                        </button>
                    </div>
                    <div id="newsletterMessage" style="font-size: 0.75rem; margin-top: 0.5rem;"></div>
                </form>
                
                <div style="margin-top: 1rem; font-size: 0.75rem; color: #adb5bd;">
                    <i class="fas fa-lock"></i> We never share your email with anyone
                </div>
            </div>
        </div>
        
        <!-- Footer Bottom -->
        <div class="footer-bottom">
            <p>&copy; 2024 FoodieHub. All rights reserved. | <a href="#">Privacy Policy</a> | <a href="#">Terms of Service</a></p>
        </div>
    </footer>
    
    <script>
        // Auto-hide alerts after 3 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                alert.style.transition = 'opacity 0.5s ease';
                alert.style.opacity = '0';
                setTimeout(function() {
                    alert.remove();
                }, 500);
            });
        }, 3000);
        
        // Confirm delete function
        function confirmDelete(url) {
            if (confirm('Are you sure you want to delete this item?')) {
                window.location.href = url;
            }
        }
        
        // Newsletter Subscription Function
        function subscribeNewsletter(event) {
            event.preventDefault();
            const email = document.getElementById('newsletterEmail').value;
            const messageDiv = document.getElementById('newsletterMessage');
            
            if (!email) {
                messageDiv.innerHTML = '<span style="color: #e74c3c;"><i class="fas fa-exclamation-circle"></i> Please enter your email address</span>';
                return false;
            }
            
            if (!email.includes('@') || !email.includes('.')) {
                messageDiv.innerHTML = '<span style="color: #e74c3c;"><i class="fas fa-exclamation-circle"></i> Please enter a valid email address</span>';
                return false;
            }
            
            // Simulate subscription (in real implementation, this would call a servlet)
            messageDiv.innerHTML = '<span style="color: #27ae60;"><i class="fas fa-spinner fa-spin"></i> Subscribing...</span>';
            
            setTimeout(function() {
                messageDiv.innerHTML = '<span style="color: #27ae60;"><i class="fas fa-check-circle"></i> Thank you for subscribing! Check your inbox.</span>';
                document.getElementById('newsletterEmail').value = '';
                
                setTimeout(function() {
                    messageDiv.innerHTML = '';
                }, 5000);
            }, 1500);
            
            return false;
        }
        
        // Order Modal Functions (if exists)
        function showOrderModal() {
            const modal = document.getElementById('orderModal');
            if (modal) {
                modal.style.display = 'flex';
                if (typeof fetchOrders === 'function') fetchOrders();
            }
        }
        
        function closeOrderModal() {
            const modal = document.getElementById('orderModal');
            if (modal) modal.style.display = 'none';
        }
        
        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('orderModal');
            if (event.target === modal) {
                closeOrderModal();
            }
        }
    </script>
</body>
</html>

</body>
</html>