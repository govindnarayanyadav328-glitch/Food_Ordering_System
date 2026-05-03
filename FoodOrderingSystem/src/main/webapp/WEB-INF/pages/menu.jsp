<%@ page import="java.util.*, com.food.model.Food" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    pageContext.setAttribute("pageTitle", "Menu");
    ArrayList<Food> foods = (ArrayList<Food>) request.getAttribute("foods");
    String success = request.getParameter("success");
    
    // Get user and role from session - DECLARE ONLY ONCE
    String loggedInUser = (String) session.getAttribute("user");
    String userRole = (String) session.getAttribute("role");
%>
<%@ include file="common/header.jsp" %>

<style>
    /* Menu Page Background */
    .menu-page-wrapper {
        position: relative;
        background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), 
                    url('https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2');
        background-size: cover;
        background-position: center;
        background-attachment: fixed;
        border-radius: 20px;
        padding: 2rem;
        margin: -1rem 0 1rem 0;
    }
    
    .menu-title {
        text-align: center;
        color: white;
        margin-bottom: 2rem;
        text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
    }
    
    .menu-title h1 {
        font-size: 3rem;
        margin-bottom: 0.5rem;
    }
    
    .menu-title p {
        font-size: 1.2rem;
        opacity: 0.9;
    }
    
    /* Food cards become more visible */
    .food-card {
        background: white;
        backdrop-filter: blur(0px);
    }
    
    .alert-success {
        z-index: 10;
        position: relative;
    }
</style>

<% if (success != null) { %>
    <div class="alert alert-success">
        <i class="fas fa-check-circle"></i> Item added to cart successfully!
    </div>
<% } %>

<div class="menu-page-wrapper">
    <div class="menu-title">
        <h1><i class="fas fa-utensils"></i> Our Delicious Menu</h1>
        <p>Freshly prepared with love ❤️</p>
    </div>

    <div class="menu-grid">
        <% if (foods != null && !foods.isEmpty()) { 
            for (Food f : foods) {
        %>
            <div class="food-card">
                <div class="food-image">
                    <i class="fas fa-hamburger"></i>
                </div>
                <div class="food-info">
                    <h3 class="food-title"><%= f.getName() %></h3>
                    <span class="food-category">
                        <i class="fas fa-tag"></i> <%= f.getCategory() %>
                    </span>
                    <div class="food-price">Rs. <%= f.getPrice() %></div>
                    
                    <!-- Show Add to Cart ONLY for normal users (not admin) -->
                    <% if (loggedInUser != null && !"admin".equals(userRole)) { %>
                        <form action="${pageContext.request.contextPath}/add-to-cart" method="post">
                            <input type="hidden" name="id" value="<%= f.getId() %>">
                            <input type="hidden" name="name" value="<%= f.getName() %>">
                            <input type="hidden" name="price" value="<%= f.getPrice() %>">
                            
                            <button type="submit" class="btn btn-primary" style="width: 100%; margin-bottom: 0.5rem;">
                                <i class="fas fa-cart-plus"></i> Add to Cart
                            </button>
                        </form>
                        
                        <a href="${pageContext.request.contextPath}/Cart" class="btn btn-secondary" style="width: 100%; text-align: center;">
                            <i class="fas fa-shopping-cart"></i> View Cart
                        </a>
                    <% } else if (loggedInUser != null && "admin".equals(userRole)) { %>
                        <!-- Admin sees only view-only message -->
                        <div style="text-align: center; padding: 0.5rem; background: #f8f9fa; border-radius: 8px; color: #6c757d;">
                            <i class="fas fa-eye"></i> View Only - Admin Access
                        </div>
                    <% } else { %>
                        <!-- Not logged in users see login prompt -->
                        <a href="${pageContext.request.contextPath}/Login" class="btn btn-primary" style="width: 100%; text-align: center;">
                            <i class="fas fa-sign-in-alt"></i> Login to Order
                        </a>
                    <% } %>
                </div>
            </div>
        <% 
            }
        } else { 
        %>
            <div class="empty-state">
                <div class="empty-state-icon">
                    <i class="fas fa-utensils"></i>
                </div>
                <h3>No items in menu</h3>
                <p>Check back later for delicious items!</p>
            </div>
        <% } %>
    </div>
</div>

<%@ include file="common/footer.jsp" %>