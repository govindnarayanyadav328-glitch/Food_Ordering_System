<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'Food Ordering System'} - FoodieHub</title>
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        /* ============================================
           COMPLETE CSS - All styles in one place
        ============================================ */
        
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
            --shadow-xl: 0 20px 25px rgba(0,0,0,0.15);
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
        
        /* ========== NAVIGATION BAR ========== */
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
        
        /* ========== USER INFO ========== */
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
        
        /* ========== BUTTONS ========== */
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
        }
        
        .btn-primary {
            background: var(--primary);
            color: var(--white);
        }
        
        .btn-primary:hover {
            background: var(--primary-dark);
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
        
        .btn-danger-small {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.8rem;
            font-weight: 600;
            transition: all 0.3s;
            margin-top: 0.5rem;
        }
        
        .btn-danger-small:hover {
            background: #c0392b;
            transform: translateY(-2px);
        }
        
        /* ========== CONTAINER ========== */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        /* ========== ORDER ICON STYLES ========== */
        .order-icon {
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.3s;
            color: #2c3e50;
            text-decoration: none;
            position: relative;
        }
        
        .order-icon:hover {
            color: #ff6b35;
            background: rgba(255, 107, 53, 0.1);
        }
        
        .order-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #ff6b35;
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
        
        /* ========== ORDER MODAL STYLES ========== */
        .order-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
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
            box-shadow: var(--shadow-xl);
        }
        
        .order-modal-header {
            background: linear-gradient(135deg, var(--primary), var(--primary-light));
            color: var(--white);
            padding: 1.2rem 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
        }
        
        .order-modal-header h3 {
            margin: 0;
            font-size: 1.3rem;
        }
        
        .close-modal {
            background: none;
            border: none;
            color: var(--white);
            font-size: 1.8rem;
            cursor: pointer;
            transition: var(--transition);
        }
        
        .close-modal:hover {
            transform: scale(1.1);
        }
        
        .order-list {
            padding: 1.5rem;
        }
        
        .order-card {
            background: var(--gray-100);
            border-radius: var(--radius-md);
            padding: 1rem 1.2rem;
            margin-bottom: 1rem;
            border-left: 4px solid var(--primary);
            transition: var(--transition);
        }
        
        .order-card:hover {
            background: var(--white);
            box-shadow: var(--shadow);
        }
        
        .order-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.8rem;
            flex-wrap: wrap;
            gap: 0.5rem;
        }
        
        .order-id {
            font-weight: bold;
            color: var(--primary);
            font-size: 1rem;
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
            font-size: 0.85rem;
            color: var(--gray-600);
        }
        
        .order-details p {
            margin: 0.3rem 0;
        }
        
        .order-actions {
            margin-top: 0.75rem;
        }
        
        .no-orders {
            text-align: center;
            padding: 2.5rem;
            color: var(--gray-600);
        }
        
        .no-orders i {
            font-size: 3.5rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }
        
        /* ========== CARDS ========== */
        .card {
            background: var(--white);
            border-radius: var(--radius-md);
            box-shadow: var(--shadow);
            overflow: hidden;
            transition: var(--transition);
            margin-bottom: 1.5rem;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }
        
        .card-header {
            background: linear-gradient(135deg, var(--primary), var(--primary-light));
            color: var(--white);
            padding: 1.2rem 1.5rem;
        }
        
        .card-header h2 {
            margin: 0;
            font-size: 1.3rem;
        }
        
        .card-body {
            padding: 1.5rem;
        }
        
        /* ========== FORMS ========== */
        .form-container {
            max-width: 500px;
            margin: 2rem auto;
            background: var(--white);
            padding: 2rem;
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-xl);
        }
        
        .form-group {
            margin-bottom: 1.2rem;
        }
        
        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: var(--text-dark);
        }
        
        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 2px solid var(--gray-300);
            border-radius: var(--radius);
            font-size: 1rem;
            transition: var(--transition);
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(255, 107, 53, 0.1);
        }
        
        /* ========== ALERTS ========== */
        .alert {
            padding: 1rem 1.2rem;
            border-radius: var(--radius);
            margin-bottom: 1rem;
        }
        
        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .alert-danger {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        /* ========== TABLES ========== */
        .table-container {
            overflow-x: auto;
            background: var(--white);
            border-radius: var(--radius-md);
            padding: 1rem;
        }
        
        .data-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .data-table th,
        .data-table td {
            padding: 0.8rem;
            text-align: left;
            border-bottom: 1px solid var(--gray-300);
        }
        
        .data-table th {
            background: var(--gray-100);
            font-weight: 600;
        }
        
        /* ========== FOOTER ========== */
        .footer {
            background: var(--secondary);
            color: var(--white);
            padding: 2.5rem 0 1rem;
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
            font-size: 1.1rem;
        }
        
        .footer-section p, .footer-section ul {
            color: var(--gray-600);
            font-size: 0.85rem;
        }
        
        .footer-section ul {
            list-style: none;
            padding: 0;
        }
        
        .footer-section ul li {
            margin-bottom: 0.4rem;
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
        
        .footer-bottom {
            text-align: center;
            padding: 1.5rem 0;
            margin-top: 1.5rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            font-size: 0.75rem;
            color: var(--gray-600);
        }
        
        /* ========== UTILITIES ========== */
        .text-center { text-align: center; }
        .mt-2 { margin-top: 0.5rem; }
        .mb-2 { margin-bottom: 0.5rem; }
        .mt-3 { margin-top: 1rem; }
        .mb-3 { margin-bottom: 1rem; }
        
        /* ========== ANIMATIONS ========== */
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
        
        /* ========== RESPONSIVE ========== */
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
            .footer-content {
                grid-template-columns: 1fr;
                text-align: center;
            }
            .order-card-header {
                flex-direction: column;
                align-items: flex-start;
            }
            .order-modal-content {
                width: 95%;
            }
        }
        
        @media (max-width: 480px) {
            .order-modal-header h3 {
                font-size: 1rem;
            }
            .order-card {
                padding: 0.8rem;
            }
            .order-id {
                font-size: 0.85rem;
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
                    String userName = (String) session.getAttribute("user");
                    String role = (String) session.getAttribute("role");
                    
                    if (userName != null && "admin".equals(role)) {
                %>
                    <a href="${pageContext.request.contextPath}/Admin" class="nav-link">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/menu" class="nav-link">
                        <i class="fas fa-utensils"></i> Menu
                    </a>
                <% } else if (userName != null) { %>
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
                
                <% if (userName == null) { %>
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
                        <span>Welcome, <strong><%= userName %></strong></span>
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