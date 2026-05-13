<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    pageContext.setAttribute("pageTitle", "Order Success");
    
    Boolean paymentSuccess = (Boolean) session.getAttribute("paymentSuccess");
    Integer orderId = (Integer) session.getAttribute("orderId");
    String paymentMethod = (String) session.getAttribute("paymentMethod");
    
    // If no payment success, redirect to home
    if (paymentSuccess == null || !paymentSuccess) {
        response.sendRedirect("Home");
        return;
    }
    
    // Clear success message after displaying
    session.removeAttribute("paymentSuccess");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Success - FoodieHub</title>
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
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            overflow: hidden;
            animation: fadeInScale 0.5s ease-out;
        }
        
        @keyframes fadeInScale {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }
        
        .success-header {
            background: linear-gradient(135deg, #27ae60, #2ecc71);
            padding: 2rem;
            text-align: center;
            color: white;
        }
        
        .success-icon {
            font-size: 5rem;
            margin-bottom: 1rem;
        }
        
        .success-header h1 {
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
        }
        
        .success-header p {
            font-size: 1rem;
            opacity: 0.9;
        }
        
        .success-body {
            padding: 2rem;
        }
        
        .order-details {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 1.5rem;
            margin: 1.5rem 0;
        }
        
        .order-details h3 {
            color: #2c3e50;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #e9ecef;
        }
        
        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 0.75rem 0;
            border-bottom: 1px solid #e9ecef;
        }
        
        .detail-row:last-child {
            border-bottom: none;
        }
        
        .detail-label {
            font-weight: 600;
            color: #6c757d;
        }
        
        .detail-value {
            color: #2c3e50;
            font-weight: 500;
        }
        
        .payment-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 600;
        }
        
        .payment-khalti {
            background: #5c2d91;
            color: white;
        }
        
        .payment-esewa {
            background: #2c8c3e;
            color: white;
        }
        
        .payment-card {
            background: #1a73e8;
            color: white;
        }
        
        .payment-ebanking {
            background: #d4af37;
            color: #2c3e50;
        }
        
        .action-buttons {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
        }
        
        .btn {
            flex: 1;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
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
        
        .confirmation-message {
            text-align: center;
            padding: 1rem;
            background: #e8f8f5;
            border-radius: 8px;
            margin-top: 1rem;
        }
        
        .confirmation-message i {
            color: #27ae60;
            margin-right: 0.5rem;
        }
        
        @media (max-width: 768px) {
            .action-buttons {
                flex-direction: column;
            }
            
            .success-header h1 {
                font-size: 1.4rem;
            }
            
            body {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="success-container">
        <div class="success-header">
            <div class="success-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <h1>Payment Successful!</h1>
            <p>Your order has been placed successfully</p>
        </div>
        
        <div class="success-body">
            <div class="order-details">
                <h3><i class="fas fa-receipt"></i> Order Details</h3>
                <div class="detail-row">
                    <span class="detail-label">Order ID:</span>
                    <span class="detail-value">#<%= orderId != null ? orderId : "N/A" %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Payment Method:</span>
                    <span class="detail-value">
                        <% if (paymentMethod != null) { 
                            if (paymentMethod.equals("khalti")) { %>
                                <span class="payment-badge payment-khalti"><i class="fas fa-wallet"></i> Khalti Wallet</span>
                        <% } else if (paymentMethod.equals("esewa")) { %>
                                <span class="payment-badge payment-esewa"><i class="fas fa-rupee-sign"></i> eSewa</span>
                        <% } else if (paymentMethod.equals("card")) { %>
                                <span class="payment-badge payment-card"><i class="fas fa-credit-card"></i> Credit/Debit Card</span>
                        <% } else { %>
                                <span class="payment-badge payment-ebanking"><i class="fas fa-university"></i> eBanking</span>
                        <% } 
                        } else { %>
                            <span>Unknown</span>
                        <% } %>
                    </span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Status:</span>
                    <span class="detail-value" style="color: #27ae60;">Completed ✓</span>
                </div>
            </div>
            
            <div class="confirmation-message">
                <i class="fas fa-envelope"></i> A confirmation has been sent to your email address.
            </div>
            
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/menu" class="btn btn-primary">
                    <i class="fas fa-utensils"></i> Order More
                </a>
                <a href="${pageContext.request.contextPath}/Home" class="btn btn-secondary">
                    <i class="fas fa-home"></i> Go to Home
                </a>
            </div>
        </div>
    </div>
</body>
</html>