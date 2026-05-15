<%@ page import="java.util.*, com.food.model.Food" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    pageContext.setAttribute("pageTitle", "Search Results");
    ArrayList<Food> foods = (ArrayList<Food>) request.getAttribute("foods");
    String keyword = (String) request.getAttribute("searchKeyword");
    Integer resultCount = (Integer) request.getAttribute("resultCount");
    
    String loggedInUser = (String) session.getAttribute("user");
    String userRole = (String) session.getAttribute("role");
%>
<%@ include file="common/header.jsp" %>

<style>
    .search-header {
        background: white;
        border-radius: 12px;
        padding: 1.5rem;
        margin-bottom: 2rem;
        text-align: center;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    
    .search-keyword {
        color: #ff6b35;
        font-weight: bold;
    }
    
    .result-count {
        color: #6c757d;
        font-size: 0.9rem;
    }
    
    .back-link {
        display: inline-block;
        margin-top: 1rem;
        color: #ff6b35;
        text-decoration: none;
    }
</style>

<div class="search-header">
    <h2><i class="fas fa-search"></i> Search Results</h2>
    <p>Showing results for: <span class="search-keyword">"<%= keyword %>"</span></p>
    <p class="result-count">Found <%= resultCount %> item(s)</p>
    <a href="${pageContext.request.contextPath}/menu" class="back-link">
        <i class="fas fa-arrow-left"></i> Back to Menu
    </a>
</div>

<% if (foods != null && !foods.isEmpty()) { %>
    <div class="menu-grid">
        <% for (Food f : foods) { %>
            <div class="food-card">
                <div class="food-image">
                    <i class="fas fa-hamburger"></i>
                </div>
                <div class="food-info">
                    <h3 class="food-title"><%= f.getName() %></h3>
                    <span class="food-category"><i class="fas fa-tag"></i> <%= f.getCategory() %></span>
                    <div class="food-price">Rs. <%= String.format("%.0f", f.getPrice()) %></div>
                    
                    <div class="food-actions">
                        <% if (loggedInUser != null && !"admin".equals(userRole)) { %>
                            <form action="${pageContext.request.contextPath}/add-to-cart" method="post">
                                <input type="hidden" name="id" value="<%= f.getId() %>">
                                <input type="hidden" name="name" value="<%= f.getName() %>">
                                <input type="hidden" name="price" value="<%= f.getPrice() %>">
                                <button type="submit" class="btn btn-primary" style="width: 100%;">
                                    <i class="fas fa-cart-plus"></i> Add to Cart
                                </button>
                            </form>
                            <a href="${pageContext.request.contextPath}/Cart" class="btn btn-secondary" style="width: 100%; text-align: center;">
                                <i class="fas fa-shopping-cart"></i> View Cart
                            </a>
                        <% } else if (loggedInUser != null && "admin".equals(userRole)) { %>
                            <div class="view-only"><i class="fas fa-eye"></i> View Only - Admin Access</div>
                        <% } else { %>
                            <a href="${pageContext.request.contextPath}/Login" class="btn btn-primary" style="width: 100%;">
                                <i class="fas fa-sign-in-alt"></i> Login to Order
                            </a>
                        <% } %>
                    </div>
                </div>
            </div>
        <% } %>
    </div>
<% } else { %>
    <div class="empty-state">
        <i class="fas fa-search" style="font-size: 4rem; margin-bottom: 1rem; opacity: 0.5;"></i>
        <h3>No items found</h3>
        <p>Try searching with different keywords or browse our full menu.</p>
        <a href="${pageContext.request.contextPath}/menu" class="btn btn-primary mt-2">Browse All Items</a>
    </div>
<% } %>

<%@ include file="common/footer.jsp" %>