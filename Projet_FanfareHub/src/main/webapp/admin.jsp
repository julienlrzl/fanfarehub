<%@ page import="java.util.*, com.example.projet_fanfarehub.model.Utilisateur, com.example.projet_fanfarehub.dao.UtilisateurDAO" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
  Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
  if (utilisateur == null || !utilisateur.isAdmin()) {
    response.sendRedirect("index.jsp");
    return;
  }

  UtilisateurDAO dao = new UtilisateurDAO();
  List<Utilisateur> utilisateurs = dao.listerTous(); // méthode à créer
%>

<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Administration - FanfareHub</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex flex-column min-vh-100">

<jsp:include page="components/navbar.jsp" />

<main class="container my-5">
  <h1 class="mb-4">Gestion des utilisateurs</h1>

  <div class="table-responsive shadow rounded">
    <table class="table table-hover align-middle">
      <thead class="table-dark">
      <tr>
        <th scope="col">Email</th>
        <th scope="col">Prénom</th>
        <th scope="col">Nom</th>
        <th scope="col" class="text-center">Admin</th>
        <th scope="col" class="text-end">Actions</th>
      </tr>
      </thead>
      <tbody>
      <%
        for (Utilisateur u : utilisateurs) {
          boolean estAdmin = u.isAdmin();
      %>
      <tr>
        <td><%= u.getEmail() %></td>
        <td><%= u.getPrenom() %></td>
        <td><%= u.getNom() %></td>
        <td class="text-center">
          <% if (estAdmin) { %>
          <span class="text-success fw-semibold">Oui</span>
          <% } else { %>
          <span class="text-danger fw-semibold">Non</span>
          <% } %>
        </td>
        <td class="text-end">
          <!-- Supprimer -->
          <form action="admin-action" method="post" class="d-inline">
            <input type="hidden" name="email" value="<%= u.getEmail() %>">
            <input type="hidden" name="action" value="delete">
            <button type="submit" class="btn btn-outline-danger btn-sm me-2" title="Supprimer"
                    onclick="return confirm('Supprimer cet utilisateur ?')">Supprimer
            </button>
          </form>

          <!-- Toggle Admin -->
          <form action="admin-action" method="post" class="d-inline">
            <input type="hidden" name="email" value="<%= u.getEmail() %>">
            <input type="hidden" name="action" value="toggleAdmin">
            <button type="submit" class="btn btn-warning btn-sm">
              <%= estAdmin ? "Retirer Admin" : "Donner Admin" %>
            </button>
          </form>
        </td>
      </tr>
      <%
        }
      %>
      </tbody>
    </table>
  </div>
</main>

<jsp:include page="components/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>