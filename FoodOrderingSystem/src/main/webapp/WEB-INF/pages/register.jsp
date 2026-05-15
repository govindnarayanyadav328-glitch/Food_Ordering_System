<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    pageContext.setAttribute("pageTitle", "Register");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - FoodieHub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        :root {
            --primary: #ff6b35;
            --primary-dark: #e55a2b;
            --primary-light: #ff8c5a;
            --secondary: #2c3e50;
            --success: #27ae60;
            --danger: #e74c3c;
            --white: #ffffff;
            --gray-100: #f8f9fa;
            --gray-200: #e9ecef;
            --gray-300: #dee2e6;
            --gray-600: #6c757d;
            --text-dark: #2c3e50;
            --shadow: 0 2px 4px rgba(0,0,0,0.1);
            --shadow-lg: 0 10px 15px rgba(0,0,0,0.1);
            --transition: all 0.3s ease;
            --radius: 8px;
            --radius-md: 12px;
            --radius-lg: 16px;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem;
        }
        
        .navbar {
            background: var(--white);
            box-shadow: var(--shadow-lg);
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            width: 100%;
        }
        
        .navbar-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }
        
        .logo {
            font-size: 1.5rem;
            font-weight: bold;
            color: var(--primary);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .logo:hover {
            transform: scale(1.05);
        }
        
        .nav-menu {
            display: flex;
            gap: 1.5rem;
            align-items: center;
            flex-wrap: wrap;
        }
        
        .nav-link {
            text-decoration: none;
            color: var(--text-dark);
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: var(--radius);
            transition: var(--transition);
        }
        
        .nav-link:hover {
            color: var(--primary);
            background: rgba(255, 107, 53, 0.1);
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: var(--radius);
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            transition: var(--transition);
        }
        
        .btn-primary {
            background: var(--primary);
            color: var(--white);
        }
        
        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
        }
        
        .btn-secondary {
            background: var(--secondary);
            color: var(--white);
        }
        
        .form-container {
            max-width: 500px;
            width: 100%;
            margin: 4rem auto;
            background: var(--white);
            padding: 2rem;
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-lg);
        }
        
        .form-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .form-header i {
            font-size: 3rem;
            color: var(--primary);
            margin-bottom: 1rem;
        }
        
        .form-header h2 {
            margin-bottom: 0.5rem;
            color: var(--text-dark);
        }
        
        .form-header p {
            color: var(--gray-600);
        }
        
        .form-group {
            margin-bottom: 1.2rem;
        }
        
        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: var(--text-dark);
        }
        
        .form-label i {
            margin-right: 0.5rem;
            color: var(--primary);
        }
        
        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 2px solid var(--gray-300);
            border-radius: var(--radius);
            font-size: 1rem;
            transition: var(--transition);
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(255, 107, 53, 0.1);
        }
        
        .footer {
            background: var(--secondary);
            color: var(--white);
            padding: 2rem 0 1rem;
            margin-top: 3rem;
            width: 100%;
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
        }
        
        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
            text-align: center;
        }
        
        .footer-bottom {
            text-align: center;
            padding-top: 1rem;
            margin-top: 1rem;
            border-top: 1px solid rgba(255,255,255,0.1);
            font-size: 0.75rem;
        }
        
        @media (max-width: 768px) {
            .navbar-container {
                flex-direction: column;
                text-align: center;
            }
            .nav-menu {
                flex-direction: column;
                width: 100%;
            }
            body {
                padding: 1rem;
            }
            .form-container {
                margin: 6rem auto 2rem;
                padding: 1.5rem;
            }
            .footer {
                position: relative;
            }
        }
    </style>
</head>
<body>

<nav class="navbar">
    <div class="navbar-container">
        <a href="${pageContext.request.contextPath}/Home" class="logo">
            <i class="fas fa-utensils"></i> FoodieHub
        </a>
        <div class="nav-menu">
            <a href="${pageContext.request.contextPath}/Home" class="nav-link"><i class="fas fa-home"></i> Home</a>
            <a href="${pageContext.request.contextPath}/menu" class="nav-link"><i class="fas fa-utensils"></i> Menu</a>
            <a href="${pageContext.request.contextPath}/Login" class="nav-link"><i class="fas fa-sign-in-alt"></i> Login</a>
            <a href="${pageContext.request.contextPath}/register" class="nav-link"><i class="fas fa-user-plus"></i> Register</a>
        </div>
    </div>
</nav>

<div class="form-container">
    <div class="form-header">
        <i class="fas fa-user-plus"></i>
        <h2>Create Account</h2>
        <p>Join FoodieHub today!</p>
    </div>
    
    <form action="${pageContext.request.contextPath}/register" method="post">
        <div class="form-group">
            <label class="form-label"><i class="fas fa-user"></i> Full Name</label>
            <input type="text" name="name" class="form-control" required placeholder="Enter your full name">
        </div>
        
        <div class="form-group">
            <label class="form-label"><i class="fas fa-envelope"></i> Email Address</label>
            <input type="email" name="email" class="form-control" required placeholder="Enter your email">
        </div>
        
        <div class="form-group">
            <label class="form-label"><i class="fas fa-lock"></i> Password</label>
            <input type="password" name="password" class="form-control" required placeholder="Create a password">
        </div>
        
        <button type="submit" class="btn btn-primary" style="width: 100%;">
            <i class="fas fa-user-plus"></i> Register
        </button>
    </form>
    
    <div style="text-align: center; margin-top: 1.5rem;">
        <p>Already have an account? <a href="${pageContext.request.contextPath}/Login" style="color: var(--primary);">Login here</a></p>
    </div>
</div>

<footer class="footer">
    <div class="footer-content">
        <div class="footer-bottom">
            <p>&copy; 2024 FoodieHub. All rights reserved.</p>
        </div>
    </div>
</footer>

</body>
</html>