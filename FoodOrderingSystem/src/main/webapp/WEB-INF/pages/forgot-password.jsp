<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    pageContext.setAttribute("pageTitle", "Forgot Password");
    String error = request.getParameter("error");
    String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - FoodieHub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .container {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            width: 100%;
            max-width: 400px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        .header {
            text-align: center;
            margin-bottom: 2rem;
        }
        .header i {
            font-size: 3rem;
            color: #ff6b35;
        }
        .form-group {
            margin-bottom: 1rem;
        }
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }
        input {
            width: 100%;
            padding: 0.75rem;
            border: 2px solid #dee2e6;
            border-radius: 8px;
            font-size: 1rem;
        }
        input:focus {
            outline: none;
            border-color: #ff6b35;
        }
        .btn {
            width: 100%;
            padding: 0.75rem;
            background: #ff6b35;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
        }
        .btn:hover {
            background: #e55a2b;
        }
        .links {
            text-align: center;
            margin-top: 1rem;
        }
        .links a {
            color: #ff6b35;
            text-decoration: none;
        }
        .alert {
            padding: 0.75rem;
            border-radius: 8px;
            margin-bottom: 1rem;
        }
        .alert-danger {
            background: #f8d7da;
            color: #721c24;
        }
        .alert-success {
            background: #d4edda;
            color: #155724;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <i class="fas fa-key"></i>
            <h2>Reset Password</h2>
            <p>Enter your email and new password</p>
        </div>
        
        <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>
        <% if (msg != null) { %>
            <div class="alert alert-success"><%= msg %></div>
        <% } %>
        
        <form action="${pageContext.request.contextPath}/forgot-password" method="post">
            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" required placeholder="Enter your registered email">
            </div>
            <div class="form-group">
                <label>New Password</label>
                <input type="password" name="newPassword" required placeholder="Enter new password">
            </div>
            <button type="submit" class="btn">Reset Password</button>
        </form>
        
        <div class="links">
            <a href="${pageContext.request.contextPath}/Login">Back to Login</a>
        </div>
    </div>
</body>
</html>