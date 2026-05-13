package com.food.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/order-success")
public class OrderSuccessServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Forward to the JSP page
        request.getRequestDispatcher("WEB-INF/pages/order-success.jsp")
               .forward(request, response);
    }
}