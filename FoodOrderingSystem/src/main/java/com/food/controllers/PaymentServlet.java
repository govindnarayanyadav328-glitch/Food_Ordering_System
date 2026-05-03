package com.food.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession();
        String user = (String) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("Login");
            return;
        }
        
        // Check if cart is not empty
        Object cart = session.getAttribute("cart");
        if (cart == null) {
            response.sendRedirect("Cart");
            return;
        }
        
        // Forward to payment page
        request.getRequestDispatcher("WEB-INF/pages/payment.jsp")
               .forward(request, response);
    }
}