package com.food.controllers;

import java.io.IOException;
import java.util.ArrayList;

import com.food.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));

        HttpSession session = request.getSession();

        ArrayList<CartItem> cart = (ArrayList<CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        boolean found = false;

        for (CartItem item : cart) {
            if (item.getId() == id) {
                item.setQuantity(item.getQuantity() + 1);
                found = true;
                break;
            }
        }

        if (!found) {
            CartItem item = new CartItem();
            item.setId(id);
            item.setName(name);
            item.setPrice(price);
            item.setQuantity(1);
            cart.add(item);
        }

        session.setAttribute("cart", cart);

        response.sendRedirect("menu?success=true");
    }
}