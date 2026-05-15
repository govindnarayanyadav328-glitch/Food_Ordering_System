<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    pageContext.setAttribute("pageTitle", "Order Success");
    
    Boolean paymentSuccess = (Boolean) session.getAttribute("paymentSuccess");
    Integer orderId = (Integer) session.getAttribute("orderId");
    String paymentMethod = (String) session.getAttribute("paymentMethod");
    String orderStatus = (String) session.getAttribute("orderStatus");
    String orderMessage = (String) session.getAttribute("orderMessage");
    
    if (paymentSuccess == null || !paymentSuccess) {
        response.sendRedirect("Home");
        return;
    }
    
    session.removeAttribute("paymentSuccess");
    session.removeAttribute("orderMessage");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Success - FoodieHub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem;
        }
        .success-container {
            max-width: 600px;
            width: 100%;
            background: white;
            border-radius: 16px;
            padding: 2rem;
            text-align: center;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            animation: fadeIn 0.5s ease;
        }
        .success-icon { font-size: 5rem; color: #27ae60; margin-bottom: 1rem; }
        .pending-icon { font-size: 5rem; color: #f39c12; margin-bottom: 1rem; }
        h1 { margin-bottom: 0.5rem; }
        .order-details {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 1rem;
            margin: 1.5rem 0;
            text-align: left;
        }
        .btn {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            background: #ff6b35;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            margin: 0.5rem;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }
    </style>
</head>
<body>
    <div class="success-container">
        <% if ("Completed".equals(orderStatus)) { %>
            <div class="success-icon"><i class="fas fa-check-circle"></i></div>
            <h1 style="color: #27ae60;">Payment Successful!</h1>
        <% } else { %>
            <div class="pending-icon"><i class="fas fa-clock"></i></div>
            <h1 style="color: #f39c12;">Order Placed!</h1>
        <% } %>
        
        <p><%= orderMessage != null ? orderMessage : "Your order has been placed successfully!" %></p>
        
        <div class="order-details">
            <p><strong>Order ID:</strong> #<%= orderId %></p>
            <p><strong>Payment Method:</strong> 
                <% if ("khalti".equals(paymentMethod)) { %>
                    <i class="fas fa-wallet"></i> Khalti Wallet
                <% } else if ("esewa".equals(paymentMethod)) { %>
                    <i class="fas fa-rupee-sign"></i> eSewa
                <% } else if ("card".equals(paymentMethod)) { %>
                    <i class="fas fa-credit-card"></i> Credit/Debit Card
                <% } else { %>
                    <i class="fas fa-university"></i> eBanking
                <% } %>
            </p>
            <p><strong>Status:</strong> 
                <% if ("Completed".equals(orderStatus)) { %>
                    <span style="color: #27ae60;">Completed ✓</span>
                <% } else { %>
                    <span style="color: #f39c12;">Pending - You will be notified when stock is available</span>
                <% } %>
            </p>
        </div>
        
        <div>
            <a href="${pageContext.request.contextPath}/menu" class="btn">Order More</a>
            <a href="${pageContext.request.contextPath}/Home" class="btn" style="background: #6c757d;">Go Home</a>
        </div>
    </div>
</body>
</html>