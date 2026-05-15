package com.food.controllers;

import java.io.IOException;
import java.util.ArrayList;

import com.food.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/update-cart")
public class UpdateCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        @SuppressWarnings("unchecked")
        ArrayList<CartItem> cart = (ArrayList<CartItem>) session.getAttribute("cart");
        
        String itemIdParam = request.getParameter("itemId");
        String action = request.getParameter("action");
        
        if (itemIdParam != null && action != null && cart != null) {
            try {
                int itemId = Integer.parseInt(itemIdParam);
                
                for (int i = 0; i < cart.size(); i++) {
                    CartItem item = cart.get(i);
                    if (item.getId() == itemId) {
                        if ("increase".equals(action)) {
                            item.setQuantity(item.getQuantity() + 1);
                        } else if ("decrease".equals(action)) {
                            int newQty = item.getQuantity() - 1;
                            if (newQty <= 0) {
                                cart.remove(i);
                            } else {
                                item.setQuantity(newQty);
                            }
                        } else if ("remove".equals(action)) {
                            cart.remove(i);
                        }
                        break;
                    }
                }
                
                session.setAttribute("cart", cart);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/Cart");
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}