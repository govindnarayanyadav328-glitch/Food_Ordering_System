<%@ page import="java.util.*, com.food.model.Food" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    pageContext.setAttribute("pageTitle", "Admin Dashboard");
    ArrayList<Food> foods = (ArrayList<Food>) request.getAttribute("foods");
    ArrayList<Object> ordersList = (ArrayList<Object>) request.getAttribute("ordersList");
    ArrayList<Food> lowStockItems = (ArrayList<Food>) request.getAttribute("lowStockItems");
    String message = request.getParameter("message");
    String error = request.getParameter("error");
    
    Integer totalOrdersObj = (Integer) request.getAttribute("totalOrders");
    Integer pendingOrdersObj = (Integer) request.getAttribute("pendingOrders");
    Integer totalUsersObj = (Integer) request.getAttribute("totalUsers");
    Double totalRevenueObj = (Double) request.getAttribute("totalRevenue");
    
    int totalOrders = (totalOrdersObj != null) ? totalOrdersObj : 0;
    int pendingOrders = (pendingOrdersObj != null) ? pendingOrdersObj : 0;
    int totalUsers = (totalUsersObj != null) ? totalUsersObj : 0;
    double totalRevenue = (totalRevenueObj != null) ? totalRevenueObj : 0;
%>
<%@ include file="common/header.jsp" %>

<style>
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 1.5rem;
        margin-bottom: 2rem;
    }
    
    .stat-card {
        background: white;
        padding: 1.2rem;
        border-radius: 12px;
        text-align: center;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        cursor: pointer;
        transition: all 0.3s;
    }
    
    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 15px rgba(0,0,0,0.1);
    }
    
    .stat-icon {
        font-size: 2rem;
        color: #ff6b35;
        margin-bottom: 0.5rem;
    }
    
    .stat-number {
        font-size: 1.8rem;
        font-weight: bold;
        color: #ff6b35;
    }
    
    .stat-label {
        color: #6c757d;
        font-size: 0.75rem;
        margin-top: 0.25rem;
    }
    
    .card {
        background: white;
        border-radius: 16px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        margin-bottom: 2rem;
        overflow: hidden;
    }
    
    .card-header {
        background: linear-gradient(135deg, #ff6b35, #ff8c5a);
        color: white;
        padding: 1rem 1.5rem;
    }
    
    .card-header h2 {
        margin: 0;
        font-size: 1.2rem;
    }
    
    .card-body {
        padding: 1.5rem;
    }
    
    .form-row {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 1rem;
        margin-bottom: 1rem;
    }
    
    .form-group {
        margin-bottom: 0;
    }
    
    .form-label {
        display: block;
        margin-bottom: 0.25rem;
        font-weight: 600;
        font-size: 0.8rem;
    }
    
    .form-control {
        width: 100%;
        padding: 0.6rem;
        border: 2px solid #dee2e6;
        border-radius: 8px;
        font-size: 0.85rem;
    }
    
    .form-control:focus {
        outline: none;
        border-color: #ff6b35;
    }
    
    .btn {
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        padding: 0.6rem 1.2rem;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-size: 0.85rem;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.3s;
    }
    
    .btn-primary {
        background: #ff6b35;
        color: white;
    }
    
    .btn-primary:hover {
        background: #e55a2b;
        transform: translateY(-2px);
    }
    
    .btn-success {
        background: #27ae60;
        color: white;
    }
    
    .btn-success:hover {
        background: #219a52;
        transform: translateY(-2px);
    }
    
    .btn-warning {
        background: #f39c12;
        color: white;
    }
    
    .btn-danger {
        background: #e74c3c;
        color: white;
    }
    
    .btn-sm {
        padding: 0.3rem 0.6rem;
        font-size: 0.7rem;
    }
    
    .table-container {
        overflow-x: auto;
    }
    
    .data-table {
        width: 100%;
        border-collapse: collapse;
    }
    
    .data-table th,
    .data-table td {
        padding: 0.75rem;
        text-align: left;
        border-bottom: 1px solid #dee2e6;
    }
    
    .data-table th {
        background: #f8f9fa;
        font-weight: 600;
    }
    
    .data-table tr:hover {
        background: #f8f9fa;
    }
    
    .alert {
        padding: 0.75rem 1rem;
        border-radius: 8px;
        margin-bottom: 1rem;
    }
    
    .alert-success {
        background: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }
    
    .alert-warning {
        background: #fff3cd;
        color: #856404;
        border: 1px solid #ffeeba;
    }
    
    .alert-danger {
        background: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }
    
    .low-stock {
        background: #fff3cd !important;
    }
    
    .low-stock-badge {
        background: #ff6b35;
        color: white;
        padding: 0.2rem 0.5rem;
        border-radius: 20px;
        font-size: 0.65rem;
        font-weight: bold;
        margin-left: 0.5rem;
    }
    
    .status-badge {
        display: inline-block;
        padding: 0.2rem 0.5rem;
        border-radius: 20px;
        font-size: 0.7rem;
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
    
    .order-card {
        border: 1px solid #dee2e6;
        border-radius: 8px;
        padding: 1rem;
        margin-bottom: 1rem;
    }
    
    .order-card-pending {
        border-left: 4px solid #f39c12;
        background: #fff8e7;
    }
    
    .order-details-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 0.5rem;
    }
    
    .order-details-table th,
    .order-details-table td {
        padding: 0.5rem;
        text-align: left;
        border-bottom: 1px solid #dee2e6;
    }
    
    .modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0,0,0,0.5);
        z-index: 2000;
        justify-content: center;
        align-items: center;
    }
    
    .modal-content {
        background: white;
        border-radius: 16px;
        width: 90%;
        max-width: 1000px;
        max-height: 80vh;
        overflow: auto;
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
    
    @media (max-width: 992px) {
        .stats-grid {
            grid-template-columns: repeat(2, 1fr);
        }
        .form-row {
            grid-template-columns: repeat(2, 1fr);
        }
    }
    
    @media (max-width: 768px) {
        .stats-grid {
            grid-template-columns: 1fr;
        }
        .form-row {
            grid-template-columns: 1fr;
        }
    }
</style>

<% if (message != null) { %>
    <div class="alert alert-success">
        <i class="fas fa-check-circle"></i> <%= message %>
    </div>
<% } %>
<% if (error != null) { %>
    <div class="alert alert-danger">
        <i class="fas fa-exclamation-circle"></i> <%= error %>
    </div>
<% } %>

<!-- Pending Orders Alert -->
<% if (pendingOrders > 0) { %>
    <div class="alert alert-warning">
        <i class="fas fa-clock"></i> <strong><%= pendingOrders %> Pending Order(s)!</strong> 
        These orders are waiting for stock approval. Please add stock and approve them.
    </div>
<% } %>

<!-- Low Stock Alert -->
<% if (lowStockItems != null && !lowStockItems.isEmpty()) { %>
    <div class="alert alert-warning">
        <i class="fas fa-exclamation-triangle"></i> <strong>Low Stock Alert!</strong> 
        The following items have low stock (5 or less):
        <% for (Food item : lowStockItems) { %>
            <span class="low-stock-badge"><%= item.getName() %>: <%= item.getStock() %> left</span>
        <% } %>
    </div>
<% } %>

<!-- Stats Grid -->
<div class="stats-grid">
    <div class="stat-card" onclick="showFoodItemsModal()">
        <div class="stat-icon"><i class="fas fa-utensils"></i></div>
        <div class="stat-number"><%= foods != null ? foods.size() : 0 %></div>
        <div class="stat-label">Total Food Items</div>
    </div>
    <div class="stat-card" onclick="showOrdersModal()">
        <div class="stat-icon"><i class="fas fa-shopping-cart"></i></div>
        <div class="stat-number"><%= totalOrders %></div>
        <div class="stat-label">Total Orders</div>
    </div>
    <div class="stat-card" onclick="showUsersModal()">
        <div class="stat-icon"><i class="fas fa-users"></i></div>
        <div class="stat-number"><%= totalUsers %></div>
        <div class="stat-label">Total Users</div>
    </div>
    <div class="stat-card" onclick="showRevenueModal()">
        <div class="stat-icon"><i class="fas fa-rupee-sign"></i></div>
        <div class="stat-number">Rs. <%= String.format("%.0f", totalRevenue) %></div>
        <div class="stat-label">Total Revenue</div>
    </div>
</div>

<!-- Add New Food Item -->
<div class="card">
    <div class="card-header">
        <h2><i class="fas fa-plus-circle"></i> Add New Food Item</h2>
    </div>
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/add-food" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label class="form-label">Food Name</label>
                    <input type="text" name="name" class="form-control" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Category</label>
                    <input type="text" name="category" class="form-control" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Price</label>
                    <input type="number" step="0.01" name="price" class="form-control" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Initial Stock</label>
                    <input type="number" name="stock" class="form-control" value="0" required>
                </div>
            </div>
            <button type="submit" class="btn btn-primary">Add Food Item</button>
        </form>
    </div>
</div>

<!-- Pending Orders Section (Needs Stock Approval) -->
<% if (pendingOrders > 0) { %>
<div class="card" style="margin-top: 2rem;">
    <div class="card-header" style="background: linear-gradient(135deg, #f39c12, #e67e22);">
        <h2><i class="fas fa-clock"></i> Pending Orders (Need Stock Approval) - <%= pendingOrders %> orders</h2>
    </div>
    <div class="card-body">
        <% for (Object obj : ordersList) {
            java.util.Map<String, Object> order = (java.util.Map<String, Object>) obj;
            if ("Pending".equals(order.get("status"))) {
        %>
            <div class="order-card order-card-pending" style="margin-bottom: 1rem; padding: 1rem;">
                <h4>Order #<%= order.get("id") %> | <%= order.get("order_date") %></h4>
                <p><strong>Customer:</strong> <%= order.get("user_name") != null ? order.get("user_name") : "User " + order.get("user_id") %></p>
                <p><strong>Payment Method:</strong> <%= order.get("payment_method") %></p>
                <p><strong>Stock Issue:</strong> <span style="color: #e74c3c;"><%= order.get("stock_issue") != null ? order.get("stock_issue") : "Insufficient stock" %></span></p>
                <p><strong>Total Amount:</strong> Rs. <%= order.get("total_amount") %></p>
                
                <h5>Items Requested:</h5>
                <table class="order-details-table">
                    <thead>
                        <tr>
                            <th>Item Name</th>
                            <th>Requested Quantity</th>
                            <th>Price</th>
                            <th>Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% java.util.ArrayList<Object> items = (java.util.ArrayList<Object>) order.get("items");
                           for (Object itemObj : items) {
                               java.util.Map<String, Object> item = (java.util.Map<String, Object>) itemObj;
                        %>
                            <tr>
                                <td><%= item.get("food_name") %></td>
                                <td><%= item.get("quantity") %></td>
                                <td>Rs. <%= item.get("price") %></td>
                                <td>Rs. <%= (double)item.get("price") * (int)item.get("quantity") %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
                
                <form action="${pageContext.request.contextPath}/approve-order" method="post" style="margin-top: 1rem;">
                    <input type="hidden" name="orderId" value="<%= order.get("id") %>">
                    <button type="submit" class="btn btn-success" onclick="return confirm('Approve this order? Stock will be deducted from inventory.')">
                        <i class="fas fa-check-circle"></i> Approve Order
                    </button>
                </form>
            </div>
        <% } } %>
    </div>
</div>
<% } %>

<!-- Manage Food Items -->
<div class="card">
    <div class="card-header">
        <h2><i class="fas fa-list"></i> Manage Food Items</h2>
    </div>
    <div class="card-body">
        <div class="table-container">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (foods != null && !foods.isEmpty()) {
                        for (Food f : foods) {
                            String rowClass = (f.getStock() <= 5) ? "low-stock" : "";
                    %>
                        <tr class="<%= rowClass %>">
                            <td><%= f.getId() %></td>
                            <td><strong><%= f.getName() %></strong></td>
                            <td><%= f.getCategory() %></td>
                            <td>Rs. <%= f.getPrice() %></td>
                            <td>
                                <%= f.getStock() %>
                                <% if (f.getStock() <= 5) { %>
                                    <span class="low-stock-badge">Low Stock!</span>
                                <% } %>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/edit-food?id=<%= f.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                                <a href="javascript:void(0)" onclick="confirmDelete('${pageContext.request.contextPath}/delete-food?id=<%= f.getId() %>')" class="btn btn-danger btn-sm">Delete</a>
                            </td>
                        </tr>
                    <% } } else { %>
                        <tr><td colspan="6" style="text-align: center;">No food items found</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Food Items Modal -->
<div id="foodItemsModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3><i class="fas fa-utensils"></i> Food Items List</h3>
            <button class="close-modal" onclick="closeModal('foodItemsModal')">&times;</button>
        </div>
        <div class="modal-body">
            <table class="order-details-table">
                <thead><tr><th>ID</th><th>Name</th><th>Category</th><th>Price</th><th>Stock</th></tr></thead>
                <tbody>
                    <% if (foods != null) {
                        for (Food f : foods) { %>
                            <tr>
                                <td><%= f.getId() %></td>
                                <td><%= f.getName() %></td>
                                <td><%= f.getCategory() %></td>
                                <td>Rs. <%= f.getPrice() %></td>
                                <td><%= f.getStock() %></td>
                            </tr>
                    <% } } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Orders Modal -->
<div id="ordersModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3><i class="fas fa-shopping-cart"></i> All Orders</h3>
            <button class="close-modal" onclick="closeModal('ordersModal')">&times;</button>
        </div>
        <div class="modal-body">
            <% if (ordersList != null && !ordersList.isEmpty()) { 
                for (Object obj : ordersList) {
                    java.util.Map<String, Object> order = (java.util.Map<String, Object>) obj;
                    String statusClass = "";
                    if ("Completed".equals(order.get("status"))) statusClass = "status-completed";
                    else if ("Pending".equals(order.get("status"))) statusClass = "status-pending";
                    else if ("Cancelled".equals(order.get("status"))) statusClass = "status-cancelled";
            %>
                <div class="order-card">
                    <h4>Order #<%= order.get("id") %> | <%= order.get("order_date") %></h4>
                    <p>Customer: <%= order.get("user_name") != null ? order.get("user_name") : "User " + order.get("user_id") %></p>
                    <p>Status: <span class="status-badge <%= statusClass %>"><%= order.get("status") %></span> | Payment: <%= order.get("payment_method") %></p>
                    <p>Total: Rs. <%= order.get("total_amount") %></p>
                    <% if (order.get("stock_issue") != null) { %>
                        <p style="color: #e74c3c;"><strong>Stock Issue:</strong> <%= order.get("stock_issue") %></p>
                    <% } %>
                    <h5>Items:</h5>
                    <table class="order-details-table">
                        <thead><tr><th>Item</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr></thead>
                        <tbody>
                            <% java.util.ArrayList<Object> items = (java.util.ArrayList<Object>) order.get("items");
                               for (Object itemObj : items) {
                                   java.util.Map<String, Object> item = (java.util.Map<String, Object>) itemObj;
                            %>
                                <tr>
                                    <td><%= item.get("food_name") %></td>
                                    <td><%= item.get("quantity") %></td>
                                    <td>Rs. <%= item.get("price") %></td>
                                    <td>Rs. <%= (double)item.get("price") * (int)item.get("quantity") %></td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } } else { %>
                <p>No orders found</p>
            <% } %>
        </div>
    </div>
</div>

<!-- Users Modal -->
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

<!-- Revenue Modal -->
<div id="revenueModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3><i class="fas fa-rupee-sign"></i> Revenue Details</h3>
            <button class="close-modal" onclick="closeModal('revenueModal')">&times;</button>
        </div>
        <div class="modal-body" style="text-align: center;">
            <h2>Total Revenue: Rs. <%= String.format("%.0f", totalRevenue) %></h2>
            <p>Total Orders: <%= totalOrders %></p>
            <p>Completed Orders: <%= totalOrders - pendingOrders %></p>
            <p>Pending Orders: <%= pendingOrders %></p>
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
    
    function showFoodItemsModal() { document.getElementById('foodItemsModal').style.display = 'flex'; }
    function showOrdersModal() { document.getElementById('ordersModal').style.display = 'flex'; }
    function showUsersModal() { document.getElementById('usersModal').style.display = 'flex'; fetchUsers(); }
    function showRevenueModal() { document.getElementById('revenueModal').style.display = 'flex'; }
    
    function closeModal(modalId) {
        document.getElementById(modalId).style.display = 'none';
    }
    
    function fetchUsers() {
        fetch('${pageContext.request.contextPath}/api/users')
            .then(response => response.json())
            .then(data => {
                let html = '<table class="order-details-table"><thead><tr><th>ID</th><th>Name</th><th>Email</th><th>Role</th></tr></thead><tbody>';
                data.forEach(user => {
                    html += '<tr><td>' + user.id + '</td><td>' + user.name + '</td><td>' + user.email + '</td><td>' + user.role + '</td></tr>';
                });
                html += '</tbody></table>';
                document.getElementById('usersList').innerHTML = html;
            })
            .catch(error => {
                document.getElementById('usersList').innerHTML = '<p>Error loading users</p>';
            });
    }
    
    window.onclick = function(event) {
        if (event.target.classList.contains('modal')) {
            event.target.style.display = 'none';
        }
    }
</script>

<%@ include file="common/footer.jsp" %>