<%@ page import="com.food.model.Food" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    pageContext.setAttribute("pageTitle", "Edit Food");
    Food f = (Food) request.getAttribute("food");
%>
<%@ include file="common/header.jsp" %>

<style>
    .form-container {
        max-width: 600px;
        margin: 2rem auto;
        background: white;
        padding: 2rem;
        border-radius: 16px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    
    .form-group {
        margin-bottom: 1.2rem;
    }
    
    .form-label {
        display: block;
        margin-bottom: 0.5rem;
        font-weight: 600;
        color: #2c3e50;
    }
    
    .form-control {
        width: 100%;
        padding: 0.75rem;
        border: 2px solid #dee2e6;
        border-radius: 8px;
        font-size: 1rem;
    }
    
    .form-control:focus {
        outline: none;
        border-color: #ff6b35;
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
    }
    
    .btn-primary {
        background: #ff6b35;
        color: white;
    }
    
    .btn-secondary {
        background: #2c3e50;
        color: white;
    }
    
    .low-stock-note {
        background: #fff3cd;
        padding: 0.5rem;
        border-radius: 8px;
        margin-top: 0.5rem;
        font-size: 0.8rem;
        color: #856404;
    }
</style>

<div class="form-container">
    <h2 class="text-center"><i class="fas fa-edit"></i> Edit Food Item</h2>
    
    <form action="${pageContext.request.contextPath}/update-food" method="post">
        <input type="hidden" name="id" value="<%= f.getId() %>">
        
        <div class="form-group">
            <label class="form-label">Food Name</label>
            <input type="text" name="name" class="form-control" value="<%= f.getName() %>" required>
        </div>
        
        <div class="form-group">
            <label class="form-label">Category</label>
            <input type="text" name="category" class="form-control" value="<%= f.getCategory() %>" required>
        </div>
        
        <div class="form-group">
            <label class="form-label">Price</label>
            <input type="number" step="0.01" name="price" class="form-control" value="<%= f.getPrice() %>" required>
        </div>
        
        <div class="form-group">
            <label class="form-label">Stock Quantity</label>
            <input type="number" name="stock" class="form-control" value="<%= f.getStock() %>" required min="0">
            <% if (f.getStock() <= 5) { %>
                <div class="low-stock-note">
                    <i class="fas fa-exclamation-triangle"></i> Low stock warning! Only <%= f.getStock() %> items left.
                </div>
            <% } %>
        </div>
        
        <div class="form-group" style="display: flex; gap: 1rem; margin-top: 2rem;">
            <button type="submit" class="btn btn-primary" style="flex: 1;">
                <i class="fas fa-save"></i> Update Food
            </button>
            <a href="${pageContext.request.contextPath}/Admin" class="btn btn-secondary" style="flex: 1; text-align: center;">
                <i class="fas fa-times"></i> Cancel
            </a>
        </div>
    </form>
</div>

<%@ include file="common/footer.jsp" %>