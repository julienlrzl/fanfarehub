<%@ page import="java.util.List, java.text.SimpleDateFormat, com.example.projet_fanfarehub.model.Event, com.example.projet_fanfarehub.model.Utilisateur, com.example.projet_fanfarehub.dao.GroupDAO" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
  List<Event> events = (List<Event>) request.getAttribute("events");
  Event editEvent = (Event) request.getAttribute("editEvent");
  boolean edition = (editEvent != null);
  SimpleDateFormat affichageFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
  Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
  GroupDAO groupDAO = new GroupDAO();
  List<String> groupes = groupDAO.getGroupsByEmail(utilisateur.getEmail());
  boolean estPrestation = groupes.contains("commission_prestation");
  Map<Integer, String> mesInstruments = (Map<Integer, String>) request.getAttribute("mesInstruments");
  Map<Integer, String> mesStatuts = (Map<Integer, String>) request.getAttribute("mesStatuts");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Mes événements</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="components/navbar.jsp" />

<main class="container my-5">
  <h2 class="mb-4">Mes événements</h2>

  <% if (estPrestation) { %>
  <!-- Formulaire d'ajout/modification -->
  <form method="post" action="events" class="mb-4">
    <input type="hidden" name="action" value="<%= edition ? "modifier" : "ajouter" %>">
    <% if (edition) { %>
    <input type="hidden" name="eventid" value="<%= editEvent.getId() %>">
    <% } %>
    <div class="row g-2 align-items-end">
      <div class="col-md-3">
        <label class="form-label">Nom</label>
        <input class="form-control" name="nom" value="<%= edition ? editEvent.getNom() : "" %>" required>
      </div>
      <div class="col-md-3">
        <label class="form-label">Date et heure</label>
        <input class="form-control" name="datetime" value="<%= edition ? affichageFormat.format(editEvent.getDatetime()) : "" %>" placeholder="25/04/2025 18:00" required>
      </div>
      <div class="col-md-1">
        <label class="form-label">Durée</label>
        <input class="form-control" name="duree" type="number" placeholder="min" value="<%= edition ? editEvent.getDuree() : "" %>" required>
      </div>
      <div class="col-md-2">
        <label class="form-label">Lieu</label>
        <input class="form-control" name="lieu" value="<%= edition ? editEvent.getLieu() : "" %>">
      </div>
      <div class="col-md-3">
        <label class="form-label">Description</label>
        <input class="form-control" name="description" value="<%= edition ? editEvent.getDescription() : "" %>">
      </div>
    </div>
    <button type="submit" class="btn btn-primary mt-3"><%= edition ? "Modifier" : "Ajouter" %></button>
  </form>
  <% } %>

  <!-- Table des événements -->
  <table class="table table-hover table-bordered">
    <thead class="table-dark">
    <tr>
      <th>Nom</th>
      <th>Date</th>
      <th>Durée</th>
      <th>Lieu</th>
      <th>Description</th>
      <th>Mon instrument</th>
      <th>Mon statut</th>
      <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <% if (events != null && !events.isEmpty()) {
      for (Event e : events) { %>
    <tr>
      <td><%= e.getNom() %></td>
      <td><%= affichageFormat.format(e.getDatetime()) %></td>
      <td><%= e.getDuree() %> min</td>
      <td><%= e.getLieu() %></td>
      <td><%= e.getDescription() %></td>
      <td>
        <%= (mesInstruments != null && mesInstruments.get(e.getId()) != null)
                ? mesInstruments.get(e.getId()) : "" %>
      </td>

      <td>
        <%= (mesStatuts != null && mesStatuts.get(e.getId()) != null)
                ? mesStatuts.get(e.getId()) : "" %>
      </td>
      <td>
        <% if (estPrestation) { %>
        <form method="post" action="events" class="d-inline">
          <input type="hidden" name="action" value="supprimer">
          <input type="hidden" name="eventid" value="<%= e.getId() %>">
          <button class="btn btn-outline-danger btn-sm" onclick="return confirm('Supprimer cet événement ?')">Supprimer</button>
        </form>
        <form method="get" action="events" class="d-inline">
          <input type="hidden" name="action" value="editForm">
          <input type="hidden" name="eventid" value="<%= e.getId() %>">
          <button class="btn btn-outline-secondary btn-sm">Modifier</button>
        </form>
        <% } %>
        <a href="evenement?id=<%= e.getId() %>" class="btn btn-outline-info btn-sm">Participer</a>
      </td>
    </tr>
    <%   }
    } else { %>
    <tr>
      <td colspan="8" class="text-center text-muted">Aucun événement trouvé.</td>
    </tr>
    <% } %>
    </tbody>
  </table>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>