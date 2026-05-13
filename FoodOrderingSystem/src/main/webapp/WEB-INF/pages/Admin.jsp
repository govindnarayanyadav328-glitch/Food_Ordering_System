<%@ page import="java.util.*, com.food.model.Food" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    pageContext.setAttribute("pageTitle", "Admin Dashboard");
    ArrayList<Food> foods = (ArrayList<Food>) request.getAttribute("foods");
    ArrayList<Object> ordersList = (ArrayList<Object>) request.getAttribute("ordersList");
    String message = request.getParameter("message");
    
    // Get real statistics from servlet
    Integer totalOrdersObj = (Integer) request.getAttribute("totalOrders");
    Integer totalUsersObj = (Integer) request.getAttribute("totalUsers");
    Double totalRevenueObj = (Double) request.getAttribute("totalRevenue");
    
    int totalOrders = (totalOrdersObj != null) ? totalOrdersObj : 0;
    int totalUsers = (totalUsersObj != null) ? totalUsersObj : 0;
    double totalRevenue = (totalRevenueObj != null) ? totalRevenueObj : 0;
%>
<%@ include file="common/header.jsp" %>

<style>
    .order-details-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 1rem;
    }
    
    .order-details-table th,
    .order-details-table td {
        padding: 0.75rem;
        text-align: left;
        border-bottom: 1px solid #dee2e6;
    }
    
    .order-details-table th {
        background: #f8f9fa;
        font-weight: 600;
    }
    
    .order-details-table tr:hover {
        background: #f8f9fa;
    }
    
    .status-badge {
        display: inline-block;
        padding: 0.25rem 0.5rem;
        border-radius: 20px;
        font-size: 0.75rem;
        font-weight: bold;
    }
    
    .status-completed {
        background: #27ae60;
        color: white;
    }
    
    .status-pending {
        background: #f39c12;
        color: white;
    }
    
    .status-cancelled {
        background: #e74c3c;
        color: white;
    }
    
    .modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0,0,0,0.5);
        z-index: 1000;
        justify-content: center;
        align-items: center;
    }
    
    .modal-content {
        background: white;
        border-radius: 16px;
        width: 90%;
        max-width: 1000px;
        max-height: 80%;
        overflow: auto;
        animation: fadeInScale 0.3s ease;
    }
    
    .modal-header {
        background: linear-gradient(135deg, #ff6b35, #ff8c5a);
        color: white;
        padding: 1rem 1.5rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .modal-header h3 {
        margin: 0;
    }
    
    .close-modal {
        background: none;
        border: none;
        color: white;
        font-size: 1.5rem;
        cursor: pointer;
    }
    
    .modal-body {
        padding: 1.5rem;
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

<% if (message != null) { %>
    <div class="alert alert-success">
        <i class="fas fa-check-circle"></i> <%= message %>
    </div>
<% } %>

<!-- Stats Grid - 4 Separate Columns -->
<div style="
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 1.5rem;
    margin-bottom: 2.5rem;
">
    <!-- Column 1: Total Food Items -->
    <div class="stat-card" style="background: white; padding: 1.5rem; border-radius: 12px; text-align: center; box-shadow: 0 2px 4px rgba(0,0,0,0.1); cursor: pointer;" onclick="showFoodItemsModal()">
        <div style="font-size: 2.5rem; color: #ff6b35; margin-bottom: 1rem;"><i class="fas fa-utensils"></i></div>
        <div style="font-size: 2rem; font-weight: bold; color: #ff6b35;"><%= foods != null ? foods.size() : 0 %></div>
        <div style="color: #6c757d; font-size: 0.875rem; text-transform: uppercase;">Total Food Items</div>
    </div>
    
    <!-- Column 2: Total Orders -->
    <div class="stat-card" style="background: white; padding: 1.5rem; border-radius: 12px; text-align: center; box-shadow: 0 2px 4px rgba(0,0,0,0.1); cursor: pointer;" onclick="showOrdersModal()">
        <div style="font-size: 2.5rem; color: #ff6b35; margin-bottom: 1rem;"><i class="fas fa-shopping-cart"></i></div>
        <div style="font-size: 2rem; font-weight: bold; color: #ff6b35;"><%= totalOrders %></div>
        <div style="color: #6c757d; font-size: 0.875rem; text-transform: uppercase;">Total Orders</div>
    </div>
    
    <!-- Column 3: Total Users -->
    <div class="stat-card" style="background: white; padding: 1.5rem; border-radius: 12px; text-align: center; box-shadow: 0 2px 4px rgba(0,0,0,0.1); cursor: pointer;" onclick="showUsersModal()">
        <div style="font-size: 2.5rem; color: #ff6b35; margin-bottom: 1rem;"><i class="fas fa-users"></i></div>
        <div style="font-size: 2rem; font-weight: bold; color: #ff6b35;"><%= totalUsers %></div>
        <div style="color: #6c757d; font-size: 0.875rem; text-transform: uppercase;">Total Users</div>
    </div>
    
    <!-- Column 4: Total Revenue -->
    <div class="stat-card" style="background: white; padding: 1.5rem; border-radius: 12px; text-align: center; box-shadow: 0 2px 4px rgba(0,0,0,0.1); cursor: pointer;" onclick="showRevenueModal()">
        <div style="font-size: 2.5rem; color: #ff6b35; margin-bottom: 1rem;"><i class="fas fa-rupee-sign"></i></div>
        <div style="font-size: 2rem; font-weight: bold; color: #ff6b35;">Rs. <%= String.format("%.0f", totalRevenue) %></div>
        <div style="color: #6c757d; font-size: 0.875rem; text-transform: uppercase;">Total Revenue</div>
    </div>
</div>

<!-- Add New Food Item Section -->
<div class="card" style="margin-bottom: 2.5rem;">
    <div class="card-header" style="background: linear-gradient(135deg, #ff6b35, #ff8c5a);">
        <h2 style="margin: 0; color: white;"><i class="fas fa-plus-circle"></i> Add New Food Item</h2>
    </div>
    <div class="card-body" style="padding: 2rem;">
        <form action="${pageContext.request.contextPath}/add-food" method="post">
            <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 1.5rem; margin-bottom: 1.5rem;">
                <div>
                    <label style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #2c3e50;">
                        <i class="fas fa-utensils"></i> Food Name
                    </label>
                    <input type="text" name="name" class="form-control" placeholder="Enter food name" required style="width: 100%; padding: 0.75rem; border: 2px solid #dee2e6; border-radius: 8px;">
                </div>
                <div>
                    <label style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #2c3e50;">
                        <i class="fas fa-tag"></i> Category
                    </label>
                    <input type="text" name="category" class="form-control" placeholder="Enter category" required style="width: 100%; padding: 0.75rem; border: 2px solid #dee2e6; border-radius: 8px;">
                </div>
                <div>
                    <label style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #2c3e50;">
                        <i class="fas fa-rupee-sign"></i> Price
                    </label>
                    <input type="number" step="0.01" name="price" class="form-control" placeholder="Enter price" required style="width: 100%; padding: 0.75rem; border: 2px solid #dee2e6; border-radius: 8px;">
                </div>
            </div>
            <div style="text-align: right;">
                <button type="submit" class="btn btn-primary" style="padding: 0.75rem 2rem;">
                    <i class="fas fa-plus"></i> Add Food Item
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Manage Food Items Section -->
<div class="card" style="margin-bottom: 2rem;">
    <div class="card-header" style="background: linear-gradient(135deg, #ff6b35, #ff8c5a);">
        <h2 style="margin: 0; color: white;"><i class="fas fa-list"></i> Manage Food Items</h2>
    </div>
    <div class="card-body" style="padding: 2rem;">
        <% if (foods != null && !foods.isEmpty()) { %>
            <div style="overflow-x: auto;">
                <table class="data-table" style="width: 100%; border-collapse: collapse; background: white; border-radius: 12px; overflow: hidden;">
                    <thead>
                        <tr style="background: linear-gradient(135deg, #ff6b35, #ff8c5a); color: white;">
                            <th style="padding: 1rem; text-align: left;">ID</th>
                            <th style="padding: 1rem; text-align: left;">Food Name</th>
                            <th style="padding: 1rem; text-align: left;">Category</th>
                            <th style="padding: 1rem; text-align: left;">Price</th>
                            <th style="padding: 1rem; text-align: center;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Food f : foods) { %>
                            <tr style="border-bottom: 1px solid #dee2e6;">
                                <td style="padding: 1rem;"><%= f.getId() %></td>
                                <td style="padding: 1rem;"><strong><%= f.getName() %></strong></td>
                                <td style="padding: 1rem;"><%= f.getCategory() %></td>
                                <td style="padding: 1rem;">Rs. <%= f.getPrice() %></td>
                                <td style="padding: 1rem; text-align: center;">
                                    <a href="${pageContext.request.contextPath}/edit-food?id=<%= f.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                                    <a href="javascript:void(0)" onclick="confirmDelete('${pageContext.request.contextPath}/delete-food?id=<%= f.getId() %>')" class="btn btn-danger btn-sm">Delete</a>
                                </td>
                             </tr>
                        <% } %>
                    </tbody>
                 </table>
            </div>
        <% } else { %>
            <div class="empty-state">No food items found. Add your first food item above!</div>
        <% } %>
    </div>
</div>

<!-- Modal for Food Items -->
<div id="foodItemsModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3><i class="fas fa-utensils"></i> Food Items List</h3>
            <button class="close-modal" onclick="closeModal('foodItemsModal')">&times;</button>
        </div>
        <div class="modal-body">
            <table class="order-details-table">
                <thead>
                    <tr><th>ID</th><th>Food Name</th><th>Category</th><th>Price</th></tr>
                </thead>
                <tbody>
                    <% if (foods != null) {
                        for (Food f : foods) { %>
                            <tr>
                                <td><%= f.getId() %></td>
                                <td><%= f.getName() %></td>
                                <td><%= f.getCategory() %></td>
                                <td>Rs. <%= f.getPrice() %></td>
                            </tr>
                    <% } } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Modal for Orders -->
<div id="ordersModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3><i class="fas fa-shopping-cart"></i> Orders List</h3>
            <button class="close-modal" onclick="closeModal('ordersModal')">&times;</button>
        </div>
        <div class="modal-body">
            <% if (ordersList != null && !ordersList.isEmpty()) { %>
                <table class="order-details-table">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>User</th>
                            <th>Amount</th>
                            <th>Payment</th>
                            <th>Status</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Object obj : ordersList) {
                            java.util.Map<String, Object> order = (java.util.Map<String, Object>) obj;
                        %>
                            <tr>
                                <td>#<%= order.get("id") %></td>
                                <td><%= order.get("user_name") != null ? order.get("user_name") : "User " + order.get("user_id") %></td>
                                <td>Rs. <%= order.get("total_amount") %></td>
                                <td><%= order.get("payment_method") %></td>
                                <td>
                                    <% String status = (String) order.get("status"); %>
                                    <span class="status-badge status-<%= status.toLowerCase() %>"><%= status %></span>
                                </td>
                                <td><%= order.get("order_date") %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <div class="empty-state">No orders found</div>
            <% } %>
        </div>
    </div>
</div>

<!-- Modal for Users -->
<div id="usersModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3><i class="fas fa-users"></i> Users List</h3>
            <button class="close-modal" onclick="closeModal('usersModal')">&times;</button>
        </div>
        <div class="modal-body">
            <div id="usersList">Loading users...</div>
        </div>
    </div>
</div>

<!-- Modal for Revenue -->
<div id="revenueModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3><i class="fas fa-rupee-sign"></i> Revenue Details</h3>
            <button class="close-modal" onclick="closeModal('revenueModal')">&times;</button>
        </div>
        <div class="modal-body" style="text-align: center;">
            <h2>Total Revenue: Rs. <%= String.format("%.0f", totalRevenue) %></h2>
            <p>Total Orders: <%= totalOrders %></p>
            <p>Average Order Value: Rs. <%= totalOrders > 0 ? String.format("%.0f", totalRevenue / totalOrders) : 0 %></p>
        </div>
    </div>
</div>

<script>
    function confirmDelete(url) {
        if (confirm('Are you sure you want to delete this item?')) {
            window.location.href = url;
        }
    }
    
    function showFoodItemsModal() {
        document.getElementById('foodItemsModal').style.display = 'flex';
    }
    
    function showOrdersModal() {
        document.getElementById('ordersModal').style.display = 'flex';
    }
    
    function showUsersModal() {
        document.getElementById('usersModal').style.display = 'flex';
        fetchUsers();
    }
    
    function showRevenueModal() {
        document.getElementById('revenueModal').style.display = 'flex';
    }
    
    function closeModal(modalId) {
        document.getElementById(modalId).style.display = 'none';
    }
    
    function fetchUsers() {
        fetch('${pageContext.request.contextPath}/api/users')
            .then(response => response.json())
            .then(data => {
                let html = '<table class="order-details-table"><thead><tr><th>ID</th><th>Name</th><th>Email</th><th>Role</th></tr></thead><tbody>';
                data.forEach(user => {
                    html += '<tr>';
                    html += '<td>' + user.id + '</td>';
                    html += '<td>' + user.name + '</td>';
                    html += '<td>' + user.email + '</td>';
                    html += '<td>' + user.role + '</td>';
                    html += '</tr>';
                });
                html += '</tbody></table>';
                document.getElementById('usersList').innerHTML = html;
            })
            .catch(error => {
                document.getElementById('usersList').innerHTML = '<p class="empty-state">Error loading users</p>';
            });
    }
    
    // Close modal when clicking outside
    window.onclick = function(event) {
        if (event.target.classList.contains('modal')) {
            event.target.style.display = 'none';
        }
    }
</script>

<%@ include file="common/footer.jsp" %>