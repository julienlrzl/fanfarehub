package com.example.projet_fanfarehub.controller;

import com.example.projet_fanfarehub.dao.UtilisateurDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin-action")
public class AdminActionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String action = request.getParameter("action");

        if (email == null || action == null) {
            response.sendRedirect("admin.jsp");
            return;
        }

        UtilisateurDAO dao = new UtilisateurDAO();

        switch (action) {
            case "delete":
                dao.supprimerParEmail(email);
                break;

            case "toggleAdmin":
                dao.toggleAdminParEmail(email);
                break;

            default:
                System.out.println("[AdminActionServlet] Action inconnue : " + action);
        }

        response.sendRedirect("admin.jsp");
    }
}