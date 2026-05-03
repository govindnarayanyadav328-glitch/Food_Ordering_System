<%@ page import="java.util.*, com.food.model.Food" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    pageContext.setAttribute("pageTitle", "Admin Dashboard");
    ArrayList<Food> foods = (ArrayList<Food>) request.getAttribute("foods");
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

<% if (message != null) { %>
    <div class="alert alert-success">
        <i class="fas fa-check-circle"></i> <%= message %>
    </div>
<% } %>

<!-- Restaurant Banner Image -->
<div style="
    width: 100%;
    height: 250px;
    background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), 
                url('https://images.pexels.com/photos/260922/pexels-photo-260922.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2');
    background-size: cover;
    background-position: center;
    border-radius: 16px;
    margin-bottom: 2rem;
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
    color: white;
    position: relative;
    overflow: hidden;
">
    <div style="position: relative; z-index: 2;">
        <h1 style="font-size: 2.5rem; margin-bottom: 0.5rem;">
            <i class="fas fa-utensils"></i> Welcome Admin!
        </h1>
        <p style="font-size: 1.1rem;">Manage your restaurant efficiently</p>
    </div>
</div>

<!-- Stats Grid - 4 Clickable Columns -->
<div style="
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 1.5rem;
    margin-bottom: 2.5rem;
">
    <!-- Column 1: Total Food Items - CLICKABLE -->
    <div onclick="showFoodItemsModal()" style="background: white; padding: 1.5rem; border-radius: 12px; text-align: center; box-shadow: 0 2px 4px rgba(0,0,0,0.1); transition: all 0.3s; cursor: pointer;">
        <div style="font-size: 2.5rem; color: #ff6b35; margin-bottom: 1rem;"><i class="fas fa-utensils"></i></div>
        <div style="font-size: 2rem; font-weight: bold; color: #ff6b35;"><%= foods != null ? foods.size() : 0 %></div>
        <div style="color: #6c757d; font-size: 0.875rem; text-transform: uppercase;">Total Food Items</div>
        <div style="margin-top: 0.5rem; font-size: 0.75rem; color: #ff6b35;">
            <i class="fas fa-mouse-pointer"></i> Click to view
        </div>
    </div>
    
    <!-- Column 2: Total Orders - CLICKABLE -->
    <div onclick="showOrdersModal()" style="background: white; padding: 1.5rem; border-radius: 12px; text-align: center; box-shadow: 0 2px 4px rgba(0,0,0,0.1); transition: all 0.3s; cursor: pointer;">
        <div style="font-size: 2.5rem; color: #ff6b35; margin-bottom: 1rem;"><i class="fas fa-shopping-cart"></i></div>
        <div style="font-size: 2rem; font-weight: bold; color: #ff6b35;"><%= totalOrders %></div>
        <div style="color: #6c757d; font-size: 0.875rem; text-transform: uppercase;">Total Orders</div>
        <div style="margin-top: 0.5rem; font-size: 0.75rem; color: #ff6b35;">
            <i class="fas fa-mouse-pointer"></i> Click to view
        </div>
    </div>
    
    <!-- Column 3: Total Users - CLICKABLE -->
    <div onclick="showUsersModal()" style="background: white; padding: 1.5rem; border-radius: 12px; text-align: center; box-shadow: 0 2px 4px rgba(0,0,0,0.1); transition: all 0.3s; cursor: pointer;">
        <div style="font-size: 2.5rem; color: #ff6b35; margin-bottom: 1rem;"><i class="fas fa-users"></i></div>
        <div style="font-size: 2rem; font-weight: bold; color: #ff6b35;"><%= totalUsers %></div>
        <div style="color: #6c757d; font-size: 0.875rem; text-transform: uppercase;">Total Users</div>
        <div style="margin-top: 0.5rem; font-size: 0.75rem; color: #ff6b35;">
            <i class="fas fa-mouse-pointer"></i> Click to view
        </div>
    </div>
    
    <!-- Column 4: Total Revenue - CLICKABLE -->
    <div onclick="showRevenueModal()" style="background: white; padding: 1.5rem; border-radius: 12px; text-align: center; box-shadow: 0 2px 4px rgba(0,0,0,0.1); transition: all 0.3s; cursor: pointer;">
        <div style="font-size: 2.5rem; color: #ff6b35; margin-bottom: 1rem;"><i class="fas fa-rupee-sign"></i></div>
        <div style="font-size: 2rem; font-weight: bold; color: #ff6b35;">Rs. <%= String.format("%.0f", totalRevenue) %></div>
        <div style="color: #6c757d; font-size: 0.875rem; text-transform: uppercase;">Total Revenue</div>
        <div style="margin-top: 0.5rem; font-size: 0.75rem; color: #ff6b35;">
            <i class="fas fa-mouse-pointer"></i> Click to view
        </div>
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
                <table style="width: 100%; border-collapse: collapse; background: white; border-radius: 12px; overflow: hidden;">
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
                            <tr style="border-bottom: 1px solid #dee2e6; transition: all 0.3s;">
                                <td style="padding: 1rem; font-weight: 500;"><%= f.getId() %></td>
                                <td style="padding: 1rem;">
                                    <strong style="color: #2c3e50;"><%= f.getName() %></strong>
                                </td>
                                <td style="padding: 1rem;">
                                    <span style="background: rgba(255, 107, 53, 0.1); color: #ff6b35; padding: 0.25rem 0.75rem; border-radius: 20px; font-size: 0.875rem;">
                                        <%= f.getCategory() %>
                                    </span>
                                </td>
                                <td style="padding: 1rem;">
                                    <span style="font-weight: bold; color: #ff6b35; font-size: 1.1rem;">
                                        Rs. <%= f.getPrice() %>
                                    </span>
                                </td>
                                <td style="padding: 1rem; text-align: center;">
                                    <div style="display: flex; gap: 0.5rem; justify-content: center;">
                                        <a href="${pageContext.request.contextPath}/edit-food?id=<%= f.getId() %>" 
                                           style="background: #f39c12; color: white; padding: 0.5rem 1rem; border-radius: 6px; text-decoration: none; display: inline-flex; align-items: center; gap: 0.5rem; transition: all 0.3s;">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                        <a href="javascript:void(0)" 
                                           onclick="confirmDelete('${pageContext.request.contextPath}/delete-food?id=<%= f.getId() %>')" 
                                           style="background: #e74c3c; color: white; padding: 0.5rem 1rem; border-radius: 6px; text-decoration: none; display: inline-flex; align-items: center; gap: 0.5rem; transition: all 0.3s;">
                                            <i class="fas fa-trash"></i> Delete
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } else { %>
            <div style="text-align: center; padding: 3rem; color: #6c757d;">
                <i class="fas fa-utensils" style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.5;"></i>
                <p>No food items found. Add your first food item above!</p>
            </div>
        <% } %>
    </div>
</div>

<!-- MODAL POPUPS FOR DETAILS -->

<!-- Modal 1: Food Items Details -->
<div id="foodItemsModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 1000; justify-content: center; align-items: center;">
    <div style="background: white; border-radius: 16px; width: 90%; max-width: 800px; max-height: 80%; overflow: auto; animation: fadeInScale 0.3s ease;">
        <div style="background: linear-gradient(135deg, #ff6b35, #ff8c5a); color: white; padding: 1.5rem; display: flex; justify-content: space-between; align-items: center;">
            <h2 style="margin: 0;"><i class="fas fa-utensils"></i> Food Items Details</h2>
            <button onclick="closeModal('foodItemsModal')" style="background: none; border: none; color: white; font-size: 1.5rem; cursor: pointer;">&times;</button>
        </div>
        <div style="padding: 1.5rem;">
            <h3>Total Food Items: <%= foods != null ? foods.size() : 0 %></h3>
            <table style="width: 100%; border-collapse: collapse; margin-top: 1rem;">
                <thead>
                    <tr style="background: #f8f9fa; border-bottom: 2px solid #dee2e6;">
                        <th style="padding: 0.75rem; text-align: left;">ID</th>
                        <th style="padding: 0.75rem; text-align: left;">Food Name</th>
                        <th style="padding: 0.75rem; text-align: left;">Category</th>
                        <th style="padding: 0.75rem; text-align: left;">Price</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (foods != null) {
                        for (Food f : foods) { %>
                            <tr style="border-bottom: 1px solid #dee2e6;">
                                <td style="padding: 0.75rem;"><%= f.getId() %></td>
                                <td style="padding: 0.75rem;"><%= f.getName() %></td>
                                <td style="padding: 0.75rem;"><%= f.getCategory() %></td>
                                <td style="padding: 0.75rem;">Rs. <%= f.getPrice() %></td>
                            </tr>
                    <% } } %>
                </tbody>
            </table>
        </div>
        <div style="padding: 1rem; text-align: right; border-top: 1px solid #dee2e6;">
            <button onclick="closeModal('foodItemsModal')" class="btn btn-secondary">Close</button>
        </div>
    </div>
</div>

<!-- Modal 2: Orders Details -->
<div id="ordersModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 1000; justify-content: center; align-items: center;">
    <div style="background: white; border-radius: 16px; width: 90%; max-width: 800px; max-height: 80%; overflow: auto; animation: fadeInScale 0.3s ease;">
        <div style="background: linear-gradient(135deg, #ff6b35, #ff8c5a); color: white; padding: 1.5rem; display: flex; justify-content: space-between; align-items: center;">
            <h2 style="margin: 0;"><i class="fas fa-shopping-cart"></i> Orders Details</h2>
            <button onclick="closeModal('ordersModal')" style="background: none; border: none; color: white; font-size: 1.5rem; cursor: pointer;">&times;</button>
        </div>
        <div style="padding: 1.5rem;">
            <h3>Total Orders: <%= totalOrders %></h3>
            <div id="ordersList" style="margin-top: 1rem;">
                <p><i class="fas fa-spinner fa-spin"></i> Loading orders...</p>
            </div>
        </div>
        <div style="padding: 1rem; text-align: right; border-top: 1px solid #dee2e6;">
            <button onclick="closeModal('ordersModal')" class="btn btn-secondary">Close</button>
        </div>
    </div>
</div>

<!-- Modal 3: Users Details -->
<div id="usersModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 1000; justify-content: center; align-items: center;">
    <div style="background: white; border-radius: 16px; width: 90%; max-width: 800px; max-height: 80%; overflow: auto; animation: fadeInScale 0.3s ease;">
        <div style="background: linear-gradient(135deg, #ff6b35, #ff8c5a); color: white; padding: 1.5rem; display: flex; justify-content: space-between; align-items: center;">
            <h2 style="margin: 0;"><i class="fas fa-users"></i> Users Details</h2>
            <button onclick="closeModal('usersModal')" style="background: none; border: none; color: white; font-size: 1.5rem; cursor: pointer;">&times;</button>
        </div>
        <div style="padding: 1.5rem;">
            <h3>Total Users: <%= totalUsers %></h3>
            <div id="usersList" style="margin-top: 1rem;">
                <p><i class="fas fa-spinner fa-spin"></i> Loading users...</p>
            </div>
        </div>
        <div style="padding: 1rem; text-align: right; border-top: 1px solid #dee2e6;">
            <button onclick="closeModal('usersModal')" class="btn btn-secondary">Close</button>
        </div>
    </div>
</div>

<!-- Modal 4: Revenue Details -->
<div id="revenueModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 1000; justify-content: center; align-items: center;">
    <div style="background: white; border-radius: 16px; width: 90%; max-width: 600px; max-height: 80%; overflow: auto; animation: fadeInScale 0.3s ease;">
        <div style="background: linear-gradient(135deg, #ff6b35, #ff8c5a); color: white; padding: 1.5rem; display: flex; justify-content: space-between; align-items: center;">
            <h2 style="margin: 0;"><i class="fas fa-rupee-sign"></i> Revenue Details</h2>
            <button onclick="closeModal('revenueModal')" style="background: none; border: none; color: white; font-size: 1.5rem; cursor: pointer;">&times;</button>
        </div>
        <div style="padding: 1.5rem;">
            <div style="text-align: center; padding: 2rem;">
                <div style="font-size: 4rem; color: #ff6b35; margin-bottom: 1rem;">
                    <i class="fas fa-chart-line"></i>
                </div>
                <h2 style="color: #2c3e50;">Total Revenue</h2>
                <div style="font-size: 3rem; font-weight: bold; color: #ff6b35;">Rs. <%= String.format("%.0f", totalRevenue) %></div>
                <div style="margin-top: 1rem; color: #6c757d;">
                    <p>Total Orders: <%= totalOrders %></p>
                    <p>Average Order Value: Rs. <%= totalOrders > 0 ? String.format("%.0f", totalRevenue / totalOrders) : 0 %></p>
                </div>
            </div>
        </div>
        <div style="padding: 1rem; text-align: right; border-top: 1px solid #dee2e6;">
            <button onclick="closeModal('revenueModal')" class="btn btn-secondary">Close</button>
        </div>
    </div>
</div>

<style>
    .stat-card:hover {
        transform: translateY(-5px);
        cursor: pointer;
    }
    
    .data-table tbody tr:hover {
        background: #f8f9fa;
    }
    
    .form-control:focus {
        outline: none;
        border-color: #ff6b35 !important;
        box-shadow: 0 0 0 3px rgba(255, 107, 53, 0.1) !important;
    }
    
    /* Banner animation */
    @keyframes fadeInScale {
        from {
            opacity: 0;
            transform: scale(0.95);
        }
        to {
            opacity: 1;
            transform: scale(1);
        }
    }
    
    .banner-image {
        animation: fadeInScale 0.5s ease-out;
    }
    
    /* Modal animation */
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

<script>
    function confirmDelete(url) {
        if (confirm('Are you sure you want to delete this food item?')) {
            window.location.href = url;
        }
    }
    
    // Modal functions
    function showFoodItemsModal() {
        document.getElementById('foodItemsModal').style.display = 'flex';
    }
    
    function showOrdersModal() {
        document.getElementById('ordersModal').style.display = 'flex';
        // Fetch orders via AJAX
        fetchOrders();
    }
    
    function showUsersModal() {
        document.getElementById('usersModal').style.display = 'flex';
        // Fetch users via AJAX
        fetchUsers();
    }
    
    function showRevenueModal() {
        document.getElementById('revenueModal').style.display = 'flex';
    }
    
    function closeModal(modalId) {
        document.getElementById(modalId).style.display = 'none';
    }
    
    // Close modal when clicking outside
    window.onclick = function(event) {
        if (event.target.classList.contains('modal-overlay')) {
            event.target.style.display = 'none';
        }
    }
    
    // Fetch orders via AJAX
    function fetchOrders() {
        fetch('${pageContext.request.contextPath}/api/orders')
            .then(response => response.json())
            .then(data => {
                let html = '<table style="width: 100%; border-collapse: collapse;">';
                html += '<thead><tr style="background: #f8f9fa; border-bottom: 2px solid #dee2e6;">';
                html += '<th style="padding: 0.75rem; text-align: left;">Order ID</th>';
                html += '<th style="padding: 0.75rem; text-align: left;">User ID</th>';
                html += '<th style="padding: 0.75rem; text-align: left;">Total Amount</th>';
                html += '<th style="padding: 0.75rem; text-align: left;">Status</th>';
                html += '<th style="padding: 0.75rem; text-align: left;">Date</th>';
                html += '</tr></thead><tbody>';
                
                data.forEach(order => {
                    html += '<tr style="border-bottom: 1px solid #dee2e6;">';
                    html += '<td style="padding: 0.75rem;">' + order.id + '</td>';
                    html += '<td style="padding: 0.75rem;">' + order.user_id + '</td>';
                    html += '<td style="padding: 0.75rem;">Rs. ' + order.total_amount + '</td>';
                    html += '<td style="padding: 0.75rem;"><span style="background: ' + (order.status === 'Completed' ? '#27ae60' : '#f39c12') + '; color: white; padding: 0.25rem 0.5rem; border-radius: 20px;">' + order.status + '</span></td>';
                    html += '<td style="padding: 0.75rem;">' + order.order_date + '</td>';
                    html += '</tr>';
                });
                
                html += '</tbody></table>';
                document.getElementById('ordersList').innerHTML = html;
            })
            .catch(error => {
                document.getElementById('ordersList').innerHTML = '<p style="color: red;">Error loading orders. Please try again.</p>';
            });
    }
    
    // Fetch users via AJAX
    function fetchUsers() {
        fetch('${pageContext.request.contextPath}/api/users')
            .then(response => response.json())
            .then(data => {
                let html = '<table style="width: 100%; border-collapse: collapse;">';
                html += '<thead><tr style="background: #f8f9fa; border-bottom: 2px solid #dee2e6;">';
                html += '<th style="padding: 0.75rem; text-align: left;">User ID</th>';
                html += '<th style="padding: 0.75rem; text-align: left;">Name</th>';
                html += '<th style="padding: 0.75rem; text-align: left;">Email</th>';
                html += '<th style="padding: 0.75rem; text-align: left;">Role</th>';
                html += '</tr></thead><tbody>';
                
                data.forEach(user => {
                    html += '<tr style="border-bottom: 1px solid #dee2e6;">';
                    html += '<td style="padding: 0.75rem;">' + user.id + '</td>';
                    html += '<td style="padding: 0.75rem;">' + user.name + '</td>';
                    html += '<td style="padding: 0.75rem;">' + user.email + '</td>';
                    html += '<td style="padding: 0.75rem;"><span style="background: ' + (user.role === 'admin' ? '#e74c3c' : '#27ae60') + '; color: white; padding: 0.25rem 0.5rem; border-radius: 20px;">' + user.role + '</span></td>';
                    html += '</tr>';
                });
                
                html += '</tbody></table>';
                document.getElementById('usersList').innerHTML = html;
            })
            .catch(error => {
                document.getElementById('usersList').innerHTML = '<p style="color: red;">Error loading users. Please try again.</p>';
            });
    }
</script>

<%@ include file="common/footer.jsp" %>