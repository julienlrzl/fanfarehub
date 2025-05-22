package com.example.projet_fanfarehub.controller;

import com.example.projet_fanfarehub.dao.UtilisateurDAO;
import com.example.projet_fanfarehub.model.Utilisateur;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/connexion")
public class ConnexionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String mdp = request.getParameter("mdp");

        UtilisateurDAO dao = new UtilisateurDAO();
        Utilisateur utilisateur = dao.trouverParEmailEtMotDePasse(email, mdp);

        if (utilisateur != null) {
            HttpSession session = request.getSession();
            session.setAttribute("utilisateur", utilisateur);
            response.sendRedirect("index.jsp");
        } else {
            request.setAttribute("erreur", "Identifiants incorrects.");
            request.getRequestDispatcher("connexion.jsp").forward(request, response);
        }
    }
}