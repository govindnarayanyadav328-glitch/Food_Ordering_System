<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    pageContext.setAttribute("pageTitle", "Home");
    
    // Get user from session - check both possible attribute names
    String loggedInUser = (String) session.getAttribute("user");
    if (loggedInUser == null) {
        loggedInUser = (String) session.getAttribute("username");
    }
    String userRole = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - FoodieHub</title>
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
            --primary-light: #ff8c5a;
            --secondary: #2c3e50;
            --secondary-dark: #1a252f;
            --success: #27ae60;
            --danger: #e74c3c;
            --warning: #f39c12;
            --white: #ffffff;
            --gray-100: #f8f9fa;
            --gray-200: #e9ecef;
            --gray-300: #dee2e6;
            --gray-600: #6c757d;
            --text-dark: #2c3e50;
            --shadow: 0 2px 4px rgba(0,0,0,0.1);
            --shadow-lg: 0 10px 15px rgba(0,0,0,0.1);
            --transition: all 0.3s ease;
            --radius: 8px;
            --radius-md: 12px;
            --radius-lg: 16px;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: var(--text-dark);
            line-height: 1.6;
        }
        
        /* Navigation Bar */
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
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .logo:hover {
            transform: scale(1.05);
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
            border-radius: var(--radius);
            transition: var(--transition);
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
            background: linear-gradient(135deg, var(--primary), var(--primary-light));
            color: var(--white);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }
        
        /* Button Styles */
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: var(--radius);
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            transition: var(--transition);
            font-family: inherit;
        }
        
        .btn-primary {
            background: var(--primary);
            color: var(--white);
        }
        
        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 107, 53, 0.4);
        }
        
        .btn-secondary {
            background: var(--secondary);
            color: var(--white);
        }
        
        .btn-secondary:hover {
            background: var(--secondary-dark);
            transform: translateY(-2px);
        }
        
        .btn-success {
            background: var(--success);
            color: var(--white);
        }
        
        .btn-danger {
            background: var(--danger);
            color: var(--white);
        }
        
        .btn-danger:hover {
            background: #c0392b;
            transform: translateY(-2px);
        }
        
        .btn-sm {
            padding: 0.4rem 0.8rem;
            font-size: 0.875rem;
        }
        
        /* Hero Section with Background Image */
        .hero-section {
            text-align: center;
            padding: 5rem 2rem;
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), 
                        url('https://images.pexels.com/photos/260922/pexels-photo-260922.jpeg?auto=compress&cs=tinysrgb&w=1260&h=500&fit=crop');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            border-radius: var(--radius-lg);
            color: var(--white);
            margin-bottom: 2rem;
        }
        
        .hero-section h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .hero-section p {
            font-size: 1.25rem;
            margin-bottom: 2rem;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
        }
        
        /* Features */
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            padding: 2rem 0;
        }
        
        .card {
            background: var(--white);
            border-radius: var(--radius-md);
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: var(--transition);
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }
        
        .card-body {
            padding: 1.5rem;
        }
        
        .text-center {
            text-align: center;
        }
        
        .feature-icon {
            font-size: 3rem;
            color: var(--primary);
            margin-bottom: 1rem;
        }
        
        /* Container */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        /* Order Icon */
        .order-icon {
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: var(--transition);
            color: var(--text-dark);
            position: relative;
        }
        
        .order-icon:hover {
            color: var(--primary);
            background: rgba(255, 107, 53, 0.1);
        }
        
        .order-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: var(--primary);
            color: white;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            font-size: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }
        
        /* Order Modal */
        .order-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.6);
            z-index: 2000;
            justify-content: center;
            align-items: center;
        }
        
        .order-modal-content {
            background: var(--white);
            border-radius: var(--radius-lg);
            width: 90%;
            max-width: 800px;
            max-height: 80vh;
            overflow: auto;
            animation: fadeInScale 0.3s ease;
        }
        
        .order-modal-header {
            background: linear-gradient(135deg, var(--primary), var(--primary-light));
            color: white;
            padding: 1rem 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .order-modal-header h3 {
            margin: 0;
        }
        
        .close-modal {
            background: none;
            border: none;
            color: white;
            font-size: 1.5rem;
            cursor: pointer;
        }
        
        .order-list {
            padding: 1.5rem;
        }
        
        .order-card {
            background: var(--gray-100);
            border-radius: var(--radius-md);
            padding: 1rem;
            margin-bottom: 1rem;
            border-left: 4px solid var(--primary);
        }
        
        .order-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.5rem;
            flex-wrap: wrap;
        }
        
        .order-id {
            font-weight: bold;
            color: var(--primary);
        }
        
        .order-status {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: bold;
        }
        
        .status-completed {
            background: var(--success);
            color: white;
        }
        
        .status-pending {
            background: var(--warning);
            color: white;
        }
        
        .status-cancelled {
            background: var(--danger);
            color: white;
        }
        
        .order-details {
            margin-top: 0.5rem;
            font-size: 0.875rem;
            color: var(--gray-600);
        }
        
        .order-details p {
            margin: 0.25rem 0;
        }
        
        .no-orders {
            text-align: center;
            padding: 2rem;
            color: var(--gray-600);
        }
        
        .no-orders i {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }
        
        .btn-danger-small {
            background: var(--danger);
            color: white;
            border: none;
            padding: 0.4rem 0.8rem;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.75rem;
            transition: var(--transition);
            margin-top: 0.5rem;
        }
        
        .btn-danger-small:hover {
            background: #c0392b;
            transform: translateY(-2px);
        }
        
        /* Footer */
        .footer {
            background: var(--secondary);
            color: var(--white);
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
            color: var(--primary);
            font-size: 1.2rem;
        }
        
        .footer-section p, .footer-section ul {
            color: var(--gray-600);
            font-size: 0.9rem;
            line-height: 1.6;
        }
        
        .footer-section ul {
            list-style: none;
            padding: 0;
        }
        
        .footer-section ul li {
            margin-bottom: 0.5rem;
        }
        
        .footer-section a {
            color: var(--gray-600);
            text-decoration: none;
            transition: var(--transition);
        }
        
        .footer-section a:hover {
            color: var(--primary);
            padding-left: 5px;
        }
        
        /* Social Media Icons - Brand Colors */
.footer-social {
    display: flex;
    gap: 1rem;
    margin-top: 1rem;
}

.footer-social a {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 38px;
    height: 38px;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 50%;
    transition: all 0.3s ease;
    color: #ffffff;
    text-decoration: none;
}

/* Facebook */
.footer-social a:hover .fa-facebook-f {
    color: #1877f2;
}
.footer-social a:hover:nth-child(1) {
    background: #ffffff;
    transform: translateY(-3px);
}

/* Instagram */
.footer-social a:hover .fa-instagram {
    color: #e4405f;
}
.footer-social a:hover:nth-child(2) {
    background: #ffffff;
    transform: translateY(-3px);
}

/* Twitter */
.footer-social a:hover .fa-twitter {
    color: #1da1f2;
}
.footer-social a:hover:nth-child(3) {
    background: #ffffff;
    transform: translateY(-3px);
}

/* YouTube */
.footer-social a:hover .fa-youtube {
    color: #ff0000;
}
.footer-social a:hover:nth-child(4) {
    background: #ffffff;
    transform: translateY(-3px);
}
        
        .newsletter-form {
            display: flex;
            gap: 0.5rem;
            margin-top: 0.5rem;
        }
        
        .newsletter-input {
            flex: 1;
            padding: 0.6rem 0.8rem;
            border: none;
            border-radius: var(--radius);
            font-size: 0.85rem;
            background: var(--gray-100);
        }
        
        .newsletter-input:focus {
            outline: none;
            box-shadow: 0 0 0 2px var(--primary);
        }
        
        .newsletter-btn {
            padding: 0.6rem 1rem;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: var(--radius);
            cursor: pointer;
            transition: var(--transition);
        }
        
        .newsletter-btn:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
        }
        
        .footer-bottom {
            text-align: center;
            padding-top: 2rem;
            margin-top: 2rem;
            border-top: 1px solid rgba(255,255,255,0.1);
            font-size: 0.8rem;
            color: var(--gray-600);
        }
        
        .footer-bottom a {
            color: var(--gray-600);
            text-decoration: none;
        }
        
        .footer-bottom a:hover {
            color: var(--primary);
        }
        
        /* Animations */
        @keyframes fadeInScale {
            from {
                opacity: 0;
                transform: scale(0.95);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }
        
        /* Responsive */
        @media (max-width: 992px) {
            .footer-content {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        
        @media (max-width: 768px) {
            .navbar-container {
                flex-direction: column;
                text-align: center;
            }
            .nav-menu {
                flex-direction: column;
                width: 100%;
            }
            .container {
                padding: 1rem;
            }
            .hero-section h1 {
                font-size: 2rem;
            }
            .hero-section p {
                font-size: 1rem;
            }
            .footer-content {
                grid-template-columns: 1fr;
                text-align: center;
            }
            .features {
                grid-template-columns: 1fr;
            }
            .hero-section {
                padding: 2rem 1rem;
            }
            .btn {
                padding: 0.6rem 1rem;
                font-size: 0.875rem;
            }
            .footer-social {
                justify-content: center;
            }
            .newsletter-form {
                flex-direction: column;
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
            
            <%
                // Check if user is logged in
                boolean isLoggedIn = (loggedInUser != null && !loggedInUser.isEmpty());
                
                if (isLoggedIn && "admin".equals(userRole)) {
            %>
                <a href="${pageContext.request.contextPath}/Admin" class="nav-link">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/menu" class="nav-link">
                    <i class="fas fa-utensils"></i> Menu
                </a>
            <% } else if (isLoggedIn) { %>
                <a href="${pageContext.request.contextPath}/menu" class="nav-link">
                    <i class="fas fa-utensils"></i> Menu
                </a>
                <a href="${pageContext.request.contextPath}/Cart" class="nav-link">
                    <i class="fas fa-shopping-cart"></i> Cart
                </a>
                <div class="order-icon" onclick="showOrderModal()">
                    <i class="fas fa-receipt"></i> Orders
                    <span id="orderCountBadge" class="order-badge" style="display: none;">0</span>
                </div>
            <% } %>
            
            <% if (!isLoggedIn) { %>
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
                    <span>Welcome, <strong><%= loggedInUser %></strong></span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            <% } %>
        </div>
    </div>
</nav>

<!-- Order Modal -->
<div id="orderModal" class="order-modal">
    <div class="order-modal-content">
        <div class="order-modal-header">
            <h3><i class="fas fa-receipt"></i> My Orders</h3>
            <button class="close-modal" onclick="closeOrderModal()">&times;</button>
        </div>
        <div id="orderListContainer" class="order-list">
            <div class="no-orders">
                <i class="fas fa-spinner fa-spin"></i>
                <p>Loading orders...</p>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <!-- Hero Section with Background Image -->
    <div class="hero-section">
        <h1>Welcome to FoodieHub</h1>
        <p>Delicious food delivered to your doorstep</p>
        
        <% if (!isLoggedIn) { %>
            <a href="${pageContext.request.contextPath}/Login" class="btn btn-primary">
                <i class="fas fa-sign-in-alt"></i> Login to Order
            </a>
            <a href="${pageContext.request.contextPath}/register" class="btn btn-secondary">
                <i class="fas fa-user-plus"></i> Register Now
            </a>
        <% } else { %>
            <a href="${pageContext.request.contextPath}/menu" class="btn btn-primary">
                <i class="fas fa-utensils"></i> Explore Menu
            </a>
        <% } %>
    </div>

    <!-- Features Section -->
    <div class="features">
        <div class="card">
            <div class="card-body text-center">
                <i class="fas fa-motorcycle feature-icon"></i>
                <h3>Fast Delivery</h3>
                <p>Get your food delivered within 30 minutes</p>
            </div>
        </div>
        
        <div class="card">
            <div class="card-body text-center">
                <i class="fas fa-utensils feature-icon"></i>
                <h3>Quality Food</h3>
                <p>Prepared with fresh ingredients</p>
            </div>
        </div>
        
        <div class="card">
            <div class="card-body text-center">
                <i class="fas fa-tags feature-icon"></i>
                <h3>Best Prices</h3>
                <p>Affordable prices with great offers</p>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <div class="footer-content">
        <!-- Column 1: About FoodieHub -->
        <div class="footer-section">
            <h3><i class="fas fa-utensils"></i> About FoodieHub</h3>
            <p>Your favorite food delivery service. Fresh, fast, and delicious meals delivered to your doorstep.</p>
            <div class="footer-social">
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
                <a href="#"><i class="fab fa-youtube"></i></a>
            </div>
        </div>
        
        <!-- Column 2: Quick Links -->
        <div class="footer-section">
            <h3><i class="fas fa-link"></i> Quick Links</h3>
            <ul>
                <li><a href="${pageContext.request.contextPath}/Home"><i class="fas fa-chevron-right"></i> Home</a></li>
                <li><a href="${pageContext.request.contextPath}/menu"><i class="fas fa-chevron-right"></i> Menu</a></li>
                <% if (!isLoggedIn) { %>
                    <li><a href="${pageContext.request.contextPath}/Login"><i class="fas fa-chevron-right"></i> Login</a></li>
                    <li><a href="${pageContext.request.contextPath}/register"><i class="fas fa-chevron-right"></i> Register</a></li>
                <% } else { %>
                    <li><a href="${pageContext.request.contextPath}/Cart"><i class="fas fa-chevron-right"></i> Cart</a></li>
                <% } %>
                <li><a href="#"><i class="fas fa-chevron-right"></i> Offers</a></li>
            </ul>
        </div>
        
        <!-- Column 3: Contact Us -->
        <div class="footer-section">
            <h3><i class="fas fa-headset"></i> Contact Us</h3>
            <ul>
                <li><i class="fas fa-phone-alt"></i> +977 9800000000</li>
                <li><i class="fas fa-envelope"></i> info@foodiehub.com</li>
                <li><i class="fas fa-map-marker-alt"></i> Kathmandu, Nepal</li>
                <li><i class="fas fa-clock"></i> Mon-Sun: 10AM - 10PM</li>
            </ul>
        </div>
        
        <!-- Column 4: Newsletter Subscription -->
        <div class="footer-section">
            <h3><i class="fas fa-envelope-open-text"></i> Subscribe to Our Daily Newsletter</h3>
            <p>Get latest updates about new dishes, offers and events!</p>
            <form class="newsletter-form" onsubmit="subscribeNewsletter(event)">
                <input type="email" id="newsletterEmail" class="newsletter-input" placeholder="Your email address" required>
                <button type="submit" class="newsletter-btn">
                    <i class="fas fa-paper-plane"></i> Subscribe
                </button>
            </form>
            <div id="newsletterMessage" style="font-size: 0.7rem; margin-top: 0.5rem;"></div>
            <div style="margin-top: 0.8rem; font-size: 0.7rem; color: var(--gray-600);">
                <i class="fas fa-lock"></i> We never share your email
            </div>
        </div>
    </div>
    
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
            messageDiv.innerHTML = '<span style="color: #e74c3c;"><i class="fas fa-exclamation-circle"></i> Please enter your email</span>';
            return false;
        }
        
        if (!email.includes('@') || !email.includes('.')) {
            messageDiv.innerHTML = '<span style="color: #e74c3c;"><i class="fas fa-exclamation-circle"></i> Enter a valid email</span>';
            return false;
        }
        
        messageDiv.innerHTML = '<span style="color: #27ae60;"><i class="fas fa-spinner fa-spin"></i> Subscribing...</span>';
        
        // Simulate subscription (replace with actual API call)
        setTimeout(function() {
            messageDiv.innerHTML = '<span style="color: #27ae60;"><i class="fas fa-check-circle"></i> Subscribed successfully!</span>';
            document.getElementById('newsletterEmail').value = '';
            
            setTimeout(function() {
                messageDiv.innerHTML = '';
            }, 5000);
        }, 1500);
        
        return false;
    }
    
    // Order Modal Functions
    function showOrderModal() {
        var modal = document.getElementById('orderModal');
        if (modal) {
            modal.style.display = 'flex';
            fetchOrders();
        }
    }
    
    function closeOrderModal() {
        var modal = document.getElementById('orderModal');
        if (modal) {
            modal.style.display = 'none';
        }
    }
    
    function fetchOrders() {
        var container = document.getElementById('orderListContainer');
        if (!container) return;
        
        container.innerHTML = '<div class="no-orders"><i class="fas fa-spinner fa-spin"></i><p>Loading orders...</p></div>';
        
        fetch('${pageContext.request.contextPath}/api/my-orders')
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                if (!data || data.length === 0) {
                    container.innerHTML = '<div class="no-orders"><i class="fas fa-receipt"></i><p>No orders found</p></div>';
                    var badge = document.getElementById('orderCountBadge');
                    if (badge) badge.style.display = 'none';
                    return;
                }
                
                var badge = document.getElementById('orderCountBadge');
                if (badge) {
                    badge.style.display = 'flex';
                    badge.textContent = data.length;
                }
                
                var html = '';
                for (var i = 0; i < data.length; i++) {
                    var order = data[i];
                    var statusClass = '';
                    if (order.status === 'Completed') statusClass = 'status-completed';
                    else if (order.status === 'Pending') statusClass = 'status-pending';
                    else if (order.status === 'Cancelled') statusClass = 'status-cancelled';
                    
                    html += '<div class="order-card">';
                    html += '<div class="order-card-header">';
                    html += '<span class="order-id">Order #' + order.id + '</span>';
                    html += '<span class="order-status ' + statusClass + '">' + order.status + '</span>';
                    html += '</div>';
                    html += '<div class="order-details">';
                    html += '<p><strong>Total Amount:</strong> Rs. ' + order.total_amount + '</p>';
                    html += '<p><strong>Payment Method:</strong> ' + (order.payment_method || 'N/A') + '</p>';
                    html += '<p><strong>Date:</strong> ' + order.order_date + '</p>';
                    html += '</div>';
                    
                    if (order.status === 'Pending') {
                        html += '<button class="btn-danger-small" onclick="cancelOrder(' + order.id + ')"><i class="fas fa-times"></i> Cancel Order</button>';
                    }
                    
                    html += '</div>';
                }
                container.innerHTML = html;
            })
            .catch(function(error) {
                container.innerHTML = '<div class="no-orders"><i class="fas fa-exclamation-circle"></i><p>Error loading orders</p></div>';
            });
    }
    
    function cancelOrder(orderId) {
        if (confirm('Are you sure you want to cancel this order?')) {
            fetch('${pageContext.request.contextPath}/cancel-order', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'orderId=' + orderId
            })
            .then(function(response) { return response.json(); })
            .then(function(data) {
                if (data.success) {
                    alert('Order cancelled successfully!');
                    fetchOrders();
                } else {
                    alert('Failed to cancel order: ' + data.message);
                }
            })
            .catch(function(error) { alert('Error cancelling order'); });
        }
    }
    
    window.onclick = function(event) {
        var modal = document.getElementById('orderModal');
        if (event.target === modal) closeOrderModal();
    }
</script>

</body>
</html>