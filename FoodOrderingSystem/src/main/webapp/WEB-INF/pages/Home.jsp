<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    pageContext.setAttribute("pageTitle", "Home");
%>
<%@ include file="common/header.jsp" %>

<style>
    .hero-section {
        position: relative;
        background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), 
                    url('https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2');
        background-size: cover;
        background-position: center;
        background-attachment: fixed;
        min-height: 500px;
        display: flex;
        align-items: center;
        justify-content: center;
        text-align: center;
        border-radius: 12px;
        margin-bottom: 2rem;
    }
    
    .hero-section h1 {
        font-size: 3rem;
        margin-bottom: 1rem;
        color: white;
    }
    
    .hero-section p {
        font-size: 1.25rem;
        margin-bottom: 2rem;
        color: white;
    }
</style>

<!-- Hero Section with Background Image -->
<div class="hero-section">
    <div>
        <h1>Welcome to FoodieHub</h1>
        <p>Delicious food delivered to your doorstep</p>
        
        <%
            String User = (String) session.getAttribute("User");
            if (User == null) {
        %>
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

<%@ include file="common/footer.jsp" %>