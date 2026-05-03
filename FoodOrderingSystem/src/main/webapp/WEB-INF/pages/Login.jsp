<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    pageContext.setAttribute("pageTitle", "Login");
    String error = request.getParameter("error");
%>
<%@ include file="common/header.jsp" %>

<div class="form-container">
    <div class="text-center">
        <i class="fas fa-utensils" style="font-size: 3rem; color: var(--primary);"></i>
        <h2>Welcome Back!</h2>
        <p>Login to continue to FoodieHub</p>
    </div>
    
    <% if (error != null) { %>
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle"></i> Invalid email or password. Please try again.
        </div>
    <% } %>
    
    <form action="${pageContext.request.contextPath}/Login" method="post">
        <div class="form-group">
            <label class="form-label">
                <i class="fas fa-envelope"></i> Email Address
            </label>
            <input type="email" name="email" class="form-control" required placeholder="Enter your email">
        </div>
        
        <div class="form-group">
            <label class="form-label">
                <i class="fas fa-lock"></i> Password
            </label>
            <input type="password" name="password" class="form-control" required placeholder="Enter your password">
        </div>
        
        <button type="submit" class="btn btn-primary" style="width: 100%;">
            <i class="fas fa-sign-in-alt"></i> Login
        </button>
    </form>
    
    <div class="text-center" style="margin-top: 1.5rem;">
        <p>Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a></p>
    </div>
</div>

<%@ include file="common/footer.jsp" %>