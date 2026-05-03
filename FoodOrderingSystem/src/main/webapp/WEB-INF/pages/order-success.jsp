<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    pageContext.setAttribute("pageTitle", "Order Success");
    
    Boolean paymentSuccess = (Boolean) session.getAttribute("paymentSuccess");
    Integer orderId = (Integer) session.getAttribute("orderId");
    String paymentMethod = (String) session.getAttribute("paymentMethod");
    
    if (paymentSuccess == null || !paymentSuccess) {
        response.sendRedirect("Home");
        return;
    }
    
    // Clear success message after displaying
    session.removeAttribute("paymentSuccess");
%>
<%@ include file="common/header.jsp" %>

<style>
    .success-container {
        text-align: center;
        padding: 3rem;
        background: white;
        border-radius: 16px;
        margin: 2rem auto;
        max-width: 600px;
        animation: fadeInScale 0.5s ease;
    }
    
    .success-icon {
        font-size: 5rem;
        color: #27ae60;
        margin-bottom: 1rem;
    }
    
    .order-details {
        background: #f8f9fa;
        border-radius: 12px;
        padding: 1.5rem;
        margin: 2rem 0;
        text-align: left;
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
</style>

<div class="success-container">
    <div class="success-icon">
        <i class="fas fa-check-circle"></i>
    </div>
    
    <h1 style="color: #27ae60;">Payment Successful!</h1>
    <p>Your order has been placed successfully.</p>
    
    <div class="order-details">
        <h3><i class="fas fa-receipt"></i> Order Details</h3>
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
        <p><strong>Status:</strong> <span style="color: #27ae60;">Completed</span></p>
    </div>
    
    <p>Thank you for your order! You will receive a confirmation email shortly.</p>
    
    <div style="margin-top: 2rem; display: flex; gap: 1rem; justify-content: center;">
        <a href="${pageContext.request.contextPath}/menu" class="btn btn-primary">
            <i class="fas fa-utensils"></i> Order More
        </a>
        <a href="${pageContext.request.contextPath}/Home" class="btn btn-secondary">
            <i class="fas fa-home"></i> Go Home
        </a>
    </div>
</div>

<%@ include file="common/footer.jsp" %>