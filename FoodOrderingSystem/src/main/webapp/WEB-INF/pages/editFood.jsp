<%@ page import="com.food.model.Food" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    pageContext.setAttribute("pageTitle", "Edit Food");
    Food f = (Food) request.getAttribute("food");
%>
<%@ include file="common/header.jsp" %>

<div class="form-container">
    <div class="text-center">
        <i class="fas fa-edit" style="font-size: 3rem; color: var(--primary);"></i>
        <h2>Edit Food Item</h2>
    </div>
    
    <form action="${pageContext.request.contextPath}/update-food" method="post">
        <input type="hidden" name="id" value="<%= f.getId() %>">
        
        <div class="form-group">
            <label class="form-label">
                <i class="fas fa-utensils"></i> Food Name
            </label>
            <input type="text" name="name" class="form-control" value="<%= f.getName() %>" required>
        </div>
        
        <div class="form-group">
            <label class="form-label">
                <i class="fas fa-tag"></i> Category
            </label>
            <input type="text" name="category" class="form-control" value="<%= f.getCategory() %>" required>
        </div>
        
        <div class="form-group">
            <label class="form-label">
                <i class="fas fa-rupee-sign"></i> Price
            </label>
            <input type="number" step="0.01" name="price" class="form-control" value="<%= f.getPrice() %>" required>
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