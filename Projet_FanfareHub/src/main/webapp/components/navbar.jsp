<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.example.projet_fanfarehub.model.Utilisateur" %>
<%@ page import="com.example.projet_fanfarehub.dao.GroupDAO" %>
<%@ page import="com.example.projet_fanfarehub.util.HtmlUtils" %> <!-- Ajout de l'import pour HtmlUtils -->

<%
  Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");

  if (utilisateur == null) {
    System.out.println("<!-- utilisateur est NULL -->");
  } else {
    System.out.println("<!-- utilisateur connecté: " + utilisateur.getPrenom() + " -->");
  }
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="index.jsp">FanfareHub</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">

        <% if (utilisateur != null) { %>
        <!-- Affiche prénom avec protection XSS -->
        <li class="nav-item">
          <a class="nav-link disabled text-white" href="#">
            Bienvenue, <strong><%= HtmlUtils.cleanInput(utilisateur.getPrenom()) %></strong>
          </a>
        </li>
        <% } %>

        <% if (utilisateur != null && utilisateur.isAdmin()) { %>
        <li class="nav-item">
          <a class="nav-link" href="admin.jsp">Admin</a>
        </li>
        <% } %>

        <% if (utilisateur != null) { %>
        <li class="nav-item">
          <a class="nav-link" href="profil.jsp">Mon Profil</a>
        </li>

        <li class="nav-item">
          <a class="nav-link" href="events">Événements</a>
        </li>
        <% } %>

        <% if (utilisateur == null) { %>
        <li class="nav-item">
          <a class="nav-link" href="inscription.jsp">Inscription</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="connexion.jsp">Connexion</a>
        </li>
        <% } %>

        <% if (utilisateur != null) { %>
        <li class="nav-item">
          <a class="nav-link" href="deconnexion.jsp">Déconnexion</a>
        </li>
        <% } %>

      </ul>
    </div>
  </div>
</nav>