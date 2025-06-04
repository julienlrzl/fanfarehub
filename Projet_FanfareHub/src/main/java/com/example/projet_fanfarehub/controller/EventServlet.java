package com.example.projet_fanfarehub.controller;

import com.example.projet_fanfarehub.dao.EventDAO;
import com.example.projet_fanfarehub.dao.GroupDAO;
import com.example.projet_fanfarehub.dao.ParticipationDAO;
import com.example.projet_fanfarehub.model.Event;
import com.example.projet_fanfarehub.model.Utilisateur;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

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

        List<Event> events = dao.getTousLesEvenements();

        ParticipationDAO participationDAO = new ParticipationDAO();
        Map<Integer, String> mesInstruments = new HashMap<>();
        Map<Integer, String> mesStatuts = new HashMap<>();

        for (Event e : events) {
            String instrument = participationDAO.getInstrument(utilisateur.getEmail(), e.getId());
            String statut = participationDAO.getStatut(utilisateur.getEmail(), e.getId());
            mesInstruments.put(e.getId(), instrument != null ? instrument : "");
            mesStatuts.put(e.getId(), statut != null ? statut : "");
        }

        // Filtre “participe / ne participe pas”
        String filtre = req.getParameter("filtreParticipation");
        if (filtre != null && !"tous".equals(filtre)) {
            Iterator<Event> iterator = events.iterator();
            while (iterator.hasNext()) {
                Event e = iterator.next();
                boolean estInscrit = mesStatuts.get(e.getId()) != null && !mesStatuts.get(e.getId()).isEmpty();
                if ("participe".equals(filtre) && !estInscrit) {
                    iterator.remove();
                } else if ("nonParticipe".equals(filtre) && estInscrit) {
                    iterator.remove();
                }
            }
        }

        req.setAttribute("events", events);
        req.setAttribute("mesInstruments", mesInstruments);
        req.setAttribute("mesStatuts", mesStatuts);

        // Préparation du formulaire si on veut modifier
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