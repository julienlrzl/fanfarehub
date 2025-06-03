<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.projet_fanfarehub.model.Event" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.example.projet_fanfarehub.model.Utilisateur" %>

<%
  Event event = (Event) request.getAttribute("event");
  List<String> instruments = (List<String>) request.getAttribute("instruments");
  String instrumentChoisi = (String) request.getAttribute("instrumentChoisi");
  String statutChoisi = (String) request.getAttribute("statutChoisi");
  Map<String, Map<String, List<String>>> participants = (Map<String, Map<String, List<String>>>) request.getAttribute("participants");
  Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
  SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Participation à l'événement</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<jsp:include page="components/navbar.jsp" />

<main class="container my-5">
  <h2 class="mb-4">Participation à : <%= event.getNom() %></h2>

  <p><strong>Date :</strong> <%= sdf.format(event.getDatetime()) %></p>
  <p><strong>Durée :</strong> <%= event.getDuree() %> min</p>
  <p><strong>Lieu :</strong> <%= event.getLieu() %></p>
  <p><strong>Description :</strong> <%= event.getDescription() %></p>

  <form method="post" action="evenement">
    <input type="hidden" name="eventid" value="<%= event.getId() %>">

    <div class="mb-3">
      <label class="form-label">Instrument</label>
      <select class="form-select" name="instrument" required>
        <% for (String inst : instruments) { %>
        <option value="<%= inst %>" <%= inst.equals(instrumentChoisi) ? "selected" : "" %>>
          <%= inst.substring(0, 1).toUpperCase() + inst.substring(1).replace("_", " ") %>
        </option>
        <% } %>
      </select>
    </div>

    <div class="mb-3">
      <label class="form-label">Statut</label>
      <select class="form-select" name="statut" required>
        <option value="present" <%= "present".equals(statutChoisi) ? "selected" : "" %>>Présent</option>
        <option value="absent" <%= "absent".equals(statutChoisi) ? "selected" : "" %>>Absent</option>
        <option value="uncertain" <%= "uncertain".equals(statutChoisi) ? "selected" : "" %>>Incertain</option>
      </select>
    </div>

    <button type="submit" class="btn btn-success">Enregistrer ma participation</button>
  </form>

  <hr class="my-5">

  <h4>Participants</h4>
  <% if (participants != null && !participants.isEmpty()) { %>
  <% for (String instrument : participants.keySet()) { %>
  <h5 class="mt-4">
    <%= instrument.substring(0, 1).toUpperCase() + instrument.substring(1).replace("_", " ") %>
  </h5>
  <div class="row">
    <% Map<String, List<String>> statutMap = participants.get(instrument); %>
    <% for (String statut : statutMap.keySet()) { %>
    <div class="col-md-4">
      <div class="card mb-3">
        <div class="card-header bg-light">
          <strong><%= statut.equals("present") ? "Présents" :
                  (statut.equals("absent") ? "Absents" : "Incertains") %></strong>
        </div>
        <ul class="list-group list-group-flush">
          <% for (String nom : statutMap.get(statut)) { %>
          <li class="list-group-item d-flex justify-content-between align-items-center">
            <%= nom %>
            <% if ((utilisateur.getPrenom() + " " + utilisateur.getNom()).equals(nom)) { %>
            <form method="post" action="evenement" class="d-inline">
              <input type="hidden" name="eventid" value="<%= event.getId() %>">
              <input type="hidden" name="action" value="desinscrire">
              <button class="btn btn-outline-danger btn-sm">Se désinscrire</button>
            </form>
            <% } %>
          </li>
          <% } %>
        </ul>
      </div>
    </div>
    <% } %>
  </div>
  <% } %>
  <% } else { %>
  <p class="text-muted">Aucun participant enregistré.</p>
  <% } %>

</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>