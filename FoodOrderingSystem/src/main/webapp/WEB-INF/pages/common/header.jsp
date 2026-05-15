<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'Food Ordering System'} - FoodieHub</title>
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
        .nav-link:hover {
            color: #ff6b35;
            background: rgba(255,107,53,0.1);
        }
        .search-form {
            display: flex;
            align-items: center;
            background: #f8f9fa;
            border-radius: 30px;
            padding: 0.25rem 0.75rem;
            border: 1px solid #dee2e6;
        }
        .search-input {
            padding: 0.5rem;
            border: none;
            background: transparent;
            outline: none;
            width: 180px;
        }
        .search-btn {
            background: none;
            border: none;
            color: #ff6b35;
            cursor: pointer;
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
        .btn-danger {
            background: #e74c3c;
            color: white;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        /* Notification Styles */
        .notification-icon {
            position: relative;
            cursor: pointer;
            padding: 0.5rem;
            border-radius: 50%;
            transition: all 0.3s;
            color: #2c3e50;
        }
        .notification-icon:hover {
            background: rgba(255,107,53,0.1);
            color: #ff6b35;
        }
        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #e74c3c;
            color: white;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            font-size: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .notification-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 2000;
            justify-content: center;
            align-items: center;
        }
        .notification-modal-content {
            background: white;
            border-radius: 16px;
            width: 90%;
            max-width: 500px;
            max-height: 70vh;
            overflow: auto;
        }
        .notification-modal-header {
            background: linear-gradient(135deg, #ff6b35, #ff8c5a);
            color: white;
            padding: 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .notification-list {
            padding: 1rem;
        }
        .notification-item {
            padding: 0.75rem;
            border-bottom: 1px solid #dee2e6;
            cursor: pointer;
            transition: all 0.3s;
        }
        .notification-item:hover {
            background: #f8f9fa;
        }
        .notification-item.unread {
            background: #fff8f5;
            border-left: 3px solid #ff6b35;
        }
        .notification-message {
            font-size: 0.85rem;
            margin-bottom: 0.25rem;
        }
        .notification-time {
            font-size: 0.7rem;
            color: #6c757d;
        }
        .no-notifications {
            text-align: center;
            padding: 2rem;
            color: #6c757d;
        }
        .mark-read-btn {
            background: none;
            border: none;
            color: #ff6b35;
            cursor: pointer;
            font-size: 0.7rem;
            margin-top: 0.25rem;
        }
        
        @media (max-width: 768px) {
            .navbar-container, .nav-menu { flex-direction: column; text-align: center; }
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
                String loggedUser = (String) session.getAttribute("user");
                String loggedRole = (String) session.getAttribute("role");
                boolean isLogged = (loggedUser != null && !loggedUser.isEmpty());
                
                String currentURI = request.getRequestURI();
                boolean isPaymentPage = currentURI.contains("payment");
                
                if (isLogged && "admin".equals(loggedRole)) {
            %>
                <a href="${pageContext.request.contextPath}/Admin" class="nav-link">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/menu" class="nav-link">
                    <i class="fas fa-utensils"></i> Menu
                </a>
            <% } else if (isLogged) { %>
                <% if (!isPaymentPage) { %>
                    <form action="${pageContext.request.contextPath}/search" method="get" class="search-form">
                        <input type="text" name="keyword" class="search-input" placeholder="Search food..." required>
                        <button type="submit" class="search-btn">
                            <i class="fas fa-search"></i>
                        </button>
                    </form>
                <% } %>
                <a href="${pageContext.request.contextPath}/menu" class="nav-link">
                    <i class="fas fa-utensils"></i> Menu
                </a>
                <a href="${pageContext.request.contextPath}/Cart" class="nav-link">
                    <i class="fas fa-shopping-cart"></i> Cart
                </a>
                <a href="${pageContext.request.contextPath}/ProfileServlet" class="nav-link">
                    <i class="fas fa-user-circle"></i> My Profile
                </a>
                <a href="${pageContext.request.contextPath}/OrderServlet" class="nav-link">
                    <i class="fas fa-receipt"></i> Orders
                </a>
                <!-- Notification Bell -->
                <div class="notification-icon" onclick="showNotifications()">
                    <i class="fas fa-bell"></i>
                    <span id="notificationBadge" class="notification-badge" style="display: none;">0</span>
                </div>
            <% } %>
            
            <% if (!isLogged) { %>
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
                    <span>Welcome, <%= loggedUser %></span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            <% } %>
        </div>
    </div>
</nav>

<!-- Notifications Modal -->
<div id="notificationModal" class="notification-modal">
    <div class="notification-modal-content">
        <div class="notification-modal-header">
            <h3><i class="fas fa-bell"></i> Notifications</h3>
            <button class="close-modal" onclick="closeNotificationModal()">&times;</button>
        </div>
        <div id="notificationsList" class="notification-list">
            <div class="no-notifications">Loading notifications...</div>
        </div>
    </div>
</div>

<div class="container">

<script>
    // Notification Functions
    function showNotifications() {
        document.getElementById('notificationModal').style.display = 'flex';
        fetchNotifications();
    }
    
    function closeNotificationModal() {
        document.getElementById('notificationModal').style.display = 'none';
    }
    
    function fetchNotifications() {
        fetch('${pageContext.request.contextPath}/api/notifications')
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                var html = '';
                if (data.length === 0) {
                    html = '<div class="no-notifications"><i class="fas fa-bell-slash"></i><p>No notifications</p></div>';
                } else {
                    var unreadCount = 0;
                    for (var i = 0; i < data.length; i++) {
                        var notif = data[i];
                        var unreadClass = notif.is_read ? '' : 'unread';
                        if (!notif.is_read) unreadCount++;
                        html += '<div class="notification-item ' + unreadClass + '" onclick="markAsRead(' + notif.id + ')">';
                        html += '<div class="notification-message">' + notif.message + '</div>';
                        html += '<div class="notification-time">' + notif.created_at + '</div>';
                        if (!notif.is_read) {
                            html += '<button class="mark-read-btn" onclick="event.stopPropagation(); markAsRead(' + notif.id + ')">Mark as read</button>';
                        }
                        html += '</div>';
                    }
                    // Update badge
                    var badge = document.getElementById('notificationBadge');
                    if (unreadCount > 0) {
                        badge.style.display = 'flex';
                        badge.textContent = unreadCount;
                    } else {
                        badge.style.display = 'none';
                    }
                }
                document.getElementById('notificationsList').innerHTML = html;
            })
            .catch(function(error) {
                document.getElementById('notificationsList').innerHTML = '<div class="no-notifications">Error loading notifications</div>';
            });
    }
    
    function markAsRead(notificationId) {
        fetch('${pageContext.request.contextPath}/api/mark-notification-read', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'notificationId=' + notificationId
        })
        .then(function() {
            fetchNotifications();
        });
    }
    
    // Close modal when clicking outside
    window.onclick = function(event) {
        var modal = document.getElementById('notificationModal');
        if (event.target === modal) {
            closeNotificationModal();
        }
    }
</script>