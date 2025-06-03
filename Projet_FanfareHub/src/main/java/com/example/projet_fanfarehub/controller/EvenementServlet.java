package com.example.projet_fanfarehub.controller;

import com.example.projet_fanfarehub.dao.EventDAO;
import com.example.projet_fanfarehub.dao.InstrumentSectionDAO;
import com.example.projet_fanfarehub.dao.ParticipationDAO;
import com.example.projet_fanfarehub.model.Event;
import com.example.projet_fanfarehub.model.Utilisateur;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/evenement")
public class EvenementServlet extends HttpServlet {
    private final EventDAO eventDAO = new EventDAO();
    private final ParticipationDAO participationDAO = new ParticipationDAO();
    private final InstrumentSectionDAO instrumentDAO = new InstrumentSectionDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Utilisateur user = (Utilisateur) req.getSession().getAttribute("utilisateur");
        if (user == null) {
            resp.sendRedirect("connexion.jsp");
            return;
        }

        try {
            int eventId = Integer.parseInt(req.getParameter("id"));
            Event event = eventDAO.getById(eventId);
            List<String> instruments = instrumentDAO.getAllSections();
            String instrument = participationDAO.getInstrument(user.getEmail(), eventId);
            String statut = participationDAO.getStatut(user.getEmail(), eventId);

            req.setAttribute("event", event);
            req.setAttribute("instruments", instruments);
            req.setAttribute("instrumentChoisi", instrument);
            req.setAttribute("statutChoisi", statut);
            Map<String, Map<String, List<String>>> participants = participationDAO.getParticipantsParInstrumentEtStatut(eventId);
            System.out.println("DEBUG participants=" + participants);
            req.setAttribute("participants", participationDAO.getParticipantsParInstrumentEtStatut(eventId));

            req.getRequestDispatcher("evenement.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Utilisateur user = (Utilisateur) req.getSession().getAttribute("utilisateur");
        if (user == null) {
            resp.sendRedirect("connexion.jsp");
            return;
        }

        try {
            int eventId = Integer.parseInt(req.getParameter("eventid"));
            String action = req.getParameter("action");

            if ("desinscrire".equals(action)) {
                participationDAO.supprimerParticipation(user.getEmail(), eventId);
                System.out.println("Participation supprimée pour " + user.getEmail());
            } else {
                String instrument = req.getParameter("instrument");
                String statut = req.getParameter("statut");
                participationDAO.enregistrerParticipation(user.getEmail(), eventId, instrument, statut);
                System.out.println("Participation enregistrée pour " + user.getEmail());
            }
            resp.sendRedirect("evenement?id=" + eventId);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("evenement?id=" + req.getParameter("eventid")); // fallback
        }
    }
}