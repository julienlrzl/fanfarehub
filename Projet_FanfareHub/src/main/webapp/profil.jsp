<%@ page import="java.util.*, com.example.projet_fanfarehub.model.*, com.example.projet_fanfarehub.dao.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
  Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
  if (utilisateur == null) {
    response.sendRedirect("index.jsp");
    return;
  }

  InstrumentSectionDAO sectionDAO = new InstrumentSectionDAO();
  GroupDAO groupDAO = new GroupDAO();
  List<String> sections = sectionDAO.getAllSections();
  List<String> groupes = groupDAO.getAllGroups();

  List<String> sectionsUser = sectionDAO.getSectionsByEmail(utilisateur.getEmail());
  List<String> groupesUser = groupDAO.getGroupsByEmail(utilisateur.getEmail());
%>

<!DOCTYPE html>
<html>
<head>
  <title>Profil - FanfareHub</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex flex-column min-vh-100">
<jsp:include page="components/navbar.jsp" />

<main class="container my-5">
  <h1 class="mb-4">Mon profil</h1>

  <!-- FORMULAIRE DE BASE -->
  <form method="post" action="profil">
    <h4>Pupitres</h4>
    <div class="mb-3">
      <% for (String s : sections) { %>
      <div class="form-check">
        <input class="form-check-input" type="checkbox" name="sections" value="<%= s %>"
          <%= sectionsUser.contains(s) ? "checked" : "" %>>
        <%
          String label = s.replace("_", " ");
          label = label.substring(0, 1).toUpperCase() + label.substring(1);
        %>
        <label class="form-check-label"><%= label %></label>
      </div>
      <% } %>
    </div>
    <% if (utilisateur.isAdmin()) { %>
    <!-- Gestion des pupitres par l'admin -->
    <div class="mb-3 mt-4">
      <h5>Ajouter un nouveau pupitre</h5>
      <div class="input-group">
        <input type="text" name="nouveauPupitre" class="form-control" placeholder="Nom du pupitre à ajouter">
        <button class="btn btn-outline-success" type="submit">Ajouter</button>
      </div>
    </div>

    <div class="mb-3 mt-4">
      <h5>Supprimer un pupitre</h5>
      <div class="input-group">
        <select name="supprimerPupitre" class="form-select">
          <option value="">-- Sélectionner un pupitre --</option>
          <% for (String s : sections) { %>
          <option value="<%= s %>"><%= s.replace("_", " ") %></option>
          <% } %>
        </select>
        <button class="btn btn-outline-danger" type="submit">Supprimer</button>
      </div>
    </div>
    <% } %>





    <h4>Groupes</h4>
    <div class="mb-3">
      <% for (String g : groupes) { %>
      <div class="form-check">
        <input class="form-check-input" type="checkbox" name="groupes" value="<%= g %>"
          <%= groupesUser.contains(g) ? "checked" : "" %>>
        <%
          String label = g.replace("_", " ");
          label = label.substring(0, 1).toUpperCase() + label.substring(1);
        %>
        <label class="form-check-label"><%= label %></label>
      </div>
      <% } %>
    </div>

    <!-- SI ADMIN, AJOUTER UN GROUPE -->
    <% if (utilisateur.isAdmin()) { %>
    <div class="mb-3 mt-4">
      <h5>Ajouter un nouveau groupe</h5>
      <div class="input-group">
        <input type="text" name="nouveauGroupe" class="form-control" placeholder="Nom du groupe à ajouter">
        <button class="btn btn-outline-success" type="submit">Ajouter</button>
      </div>
    </div>

    <div class="mb-3 mt-4">
      <h5>Supprimer un groupe</h5>
      <div class="input-group">
        <select name="supprimerGroupe" class="form-select">
          <option value="">-- Sélectionner un groupe --</option>
          <% for (String g : groupes) { %>
          <option value="<%= g %>"><%= g.replace("_", " ") %></option>
          <% } %>
        </select>
        <button class="btn btn-outline-danger" type="submit">Supprimer</button>
      </div>
    </div>
    <% } %>

    <button type="submit" class="btn btn-primary mt-3">Mettre à jour</button>
  </form>
</main>

<jsp:include page="components/footer.jsp" />
</body>
</html>