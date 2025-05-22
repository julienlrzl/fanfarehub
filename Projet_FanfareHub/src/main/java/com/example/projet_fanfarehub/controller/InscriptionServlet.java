package com.example.projet_fanfarehub.controller;

import com.example.projet_fanfarehub.dao.UtilisateurDAO;
import com.example.projet_fanfarehub.model.Utilisateur;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/inscription")
public class InscriptionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String emailConfirm = request.getParameter("emailConfirm");
        String mdp = request.getParameter("mdp");
        String mdpConfirm = request.getParameter("mdpConfirm");
        String prenom = request.getParameter("prenom");
        String nom = request.getParameter("nom");
        String genre = request.getParameter("genre");
        String alimentaire = request.getParameter("alimentaire");

        // Vérification de base
        if (!email.equals(emailConfirm) || !mdp.equals(mdpConfirm)) {
            request.setAttribute("erreur", "Les emails ou mots de passe ne correspondent pas.");
            request.getRequestDispatcher("inscription.jsp").forward(request, response);
            return;
        }

        // Création et insertion de l'utilisateur
        Utilisateur utilisateur = new Utilisateur(email, mdp, prenom, nom, genre, alimentaire);
        UtilisateurDAO utilisateurDAO = new UtilisateurDAO();
        utilisateurDAO.ajouter(utilisateur);

        // Connexion automatique
        HttpSession session = request.getSession();
        session.setAttribute("utilisateur", utilisateur);
        session.setAttribute("message", "Inscription réussie ! Bienvenue sur FanfareHub");

        response.sendRedirect("index.jsp");
    }
}