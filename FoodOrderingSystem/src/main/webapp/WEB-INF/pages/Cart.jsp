<%@ page import="java.util.*, com.food.model.CartItem" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    pageContext.setAttribute("pageTitle", "Shopping Cart");
    ArrayList<CartItem> cart = (ArrayList<CartItem>) session.getAttribute("cart");
%>
<%@ include file="common/header.jsp" %>

<h1 class="text-center"><i class="fas fa-shopping-cart"></i> Your Cart</h1>

<div class="cart-container">
    <% if (cart != null && !cart.isEmpty()) { 
        double grandTotal = 0;
    %>
        <div class="cart-header">
            <div>Item</div>
            <div>Price</div>
            <div>Quantity</div>
            <div>Total</div>
        </div>
        
        <div class="cart-items">
            <% for (CartItem item : cart) {
                double subtotal = item.getPrice() * item.getQuantity();
                grandTotal += subtotal;
            %>
                <div class="cart-item">
                    <div class="cart-item-info">
                        <h3><%= item.getName() %></h3>
                    </div>
                    <div class="cart-item-price">
                        Rs. <%= item.getPrice() %>
                    </div>
                    <div class="cart-item-quantity">
                        <%= item.getQuantity() %>
                    </div>
                    <div class="cart-item-total">
                        Rs. <%= subtotal %>
                    </div>
                </div>
            <% } %>
        </div>
        
        <div class="cart-summary">
            <h2 class="cart-total">Grand Total: Rs. <%= grandTotal %></h2>
        </div>
        
        <!-- Buttons with gap -->
        <div class="cart-actions">
            <a href="${pageContext.request.contextPath}/menu" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Continue Shopping
            </a>
            <a href="${pageContext.request.contextPath}/payment" class="btn btn-success">
                <i class="fas fa-credit-card"></i> Proceed to Payment
            </a>
        </div>
    <% } else { %>
        <div class="empty-cart">
            <div class="empty-cart-icon">
                <i class="fas fa-shopping-cart"></i>
            </div>
            <h3>Your cart is empty</h3>
            <p>Looks like you haven't added any items to your cart yet</p>
            <a href="${pageContext.request.contextPath}/menu" class="btn btn-primary">
                <i class="fas fa-utensils"></i> Browse Menu
            </a>
        </div>
    <% } %>
</div>

<style>
    .cart-actions {
        display: flex;
        gap: 1.5rem;
        justify-content: flex-end;
        margin-top: 2rem;
    }
    
    .cart-actions .btn {
        padding: 0.75rem 1.5rem;
        font-size: 1rem;
        min-width: 200px;
        text-align: center;
    }
    
    @media (max-width: 768px) {
        .cart-actions {
            flex-direction: column;
            gap: 1rem;
        }
        
        .cart-actions .btn {
            width: 100%;
            min-width: auto;
        }
    }
</style>

<%@ include file="common/footer.jsp" %>