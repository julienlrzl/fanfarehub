package com.example.projet_fanfarehub.controller;

import com.example.projet_fanfarehub.dao.EventDAO;
import com.example.projet_fanfarehub.dao.GroupDAO;
import com.example.projet_fanfarehub.model.Event;
import com.example.projet_fanfarehub.model.Utilisateur;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/events")
public class EventServlet extends HttpServlet {
    private final EventDAO dao = new EventDAO();

    private boolean estDansCommissionPrestation(Utilisateur utilisateur) {
        GroupDAO groupDAO = new GroupDAO();
        List<String> groupes = groupDAO.getGroupsByEmail(utilisateur.getEmail());
        return groupes.contains("commission_prestation");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Utilisateur utilisateur = (Utilisateur) req.getSession().getAttribute("utilisateur");
        if (utilisateur == null) {
            resp.sendRedirect("connexion.jsp");
            return;
        }

        // Pas de restriction ici → tout fanfaron connecté peut accéder
        List<Event> events = dao.getTousLesEvenements();
        req.setAttribute("events", events);

        // Préparation du formulaire si on veut modifier (réservé à ceux qui voient le bouton dans la JSP)
        String action = req.getParameter("action");
        if ("editForm".equals(action)) {
            int eventId = Integer.parseInt(req.getParameter("eventid"));
            for (Event e : events) {
                if (e.getId() == eventId) {
                    req.setAttribute("editEvent", e);
                    break;
                }
            }
        }

        req.getRequestDispatcher("events.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        Utilisateur utilisateur = (Utilisateur) req.getSession().getAttribute("utilisateur");
        if (utilisateur == null) {
            resp.sendRedirect("connexion.jsp");
            return;
        }

        String idStr = req.getParameter("eventid");

        try {
            if ("ajouter".equals(action) || "modifier".equals(action)) {
                String nom = req.getParameter("nom");
                String dateStr = req.getParameter("datetime");
                String dureeStr = req.getParameter("duree");
                String lieu = req.getParameter("lieu");
                String desc = req.getParameter("description");

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                Timestamp datetime = new Timestamp(sdf.parse(dateStr).getTime());
                int duree = Integer.parseInt(dureeStr);

                if ("ajouter".equals(action)) {
                    dao.ajouter(new Event(0, nom, datetime, duree, lieu, desc, utilisateur.getId()));
                } else {
                    dao.modifier(new Event(Integer.parseInt(idStr), nom, datetime, duree, lieu, desc, utilisateur.getId()));
                }

            } else if ("supprimer".equals(action)) {
                dao.supprimer(Integer.parseInt(idStr), utilisateur.getId());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        resp.sendRedirect("events");
    }
}