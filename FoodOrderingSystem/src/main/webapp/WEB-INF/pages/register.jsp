<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    pageContext.setAttribute("pageTitle", "Register");
%>
<%@ include file="common/header.jsp" %>

<div class="form-container">
    <div class="text-center">
        <i class="fas fa-user-plus" style="font-size: 3rem; color: var(--primary);"></i>
        <h2>Create Account</h2>
        <p>Join FoodieHub today!</p>
    </div>
    
    <form action="${pageContext.request.contextPath}/register" method="post">
        <div class="form-group">
            <label class="form-label">
                <i class="fas fa-user"></i> Full Name
            </label>
            <input type="text" name="name" class="form-control" required placeholder="Enter your full name">
        </div>
        
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
            <input type="password" name="password" class="form-control" required placeholder="Create a password">
        </div>
        
        <button type="submit" class="btn btn-primary" style="width: 100%;">
            <i class="fas fa-user-plus"></i> Register
        </button>
    </form>
    
    <div class="text-center" style="margin-top: 1.5rem;">
        <p>Already have an account? <a href="${pageContext.request.contextPath}/Login">Login here</a></p>
    </div>
</div>

<%@ include file="common/footer.jsp" %>