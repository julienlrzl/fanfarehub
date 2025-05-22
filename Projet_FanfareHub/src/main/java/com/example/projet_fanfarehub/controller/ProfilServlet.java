package com.example.projet_fanfarehub.controller;

import com.example.projet_fanfarehub.dao.GroupDAO;
import com.example.projet_fanfarehub.dao.InstrumentSectionDAO;
import com.example.projet_fanfarehub.model.Utilisateur;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/profil")
public class ProfilServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");

        if (utilisateur == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String[] sections = request.getParameterValues("sections");
        String[] groupes = request.getParameterValues("groupes");

        InstrumentSectionDAO sectionDAO = new InstrumentSectionDAO();
        GroupDAO groupDAO = new GroupDAO();

        sectionDAO.mettreAJourPupitres(utilisateur.getEmail(), sections);
        groupDAO.mettreAJourGroupes(utilisateur.getEmail(), groupes);

        session.setAttribute("message", "Profil mis à jour avec succès !");
        response.sendRedirect("profil.jsp");
    }
}