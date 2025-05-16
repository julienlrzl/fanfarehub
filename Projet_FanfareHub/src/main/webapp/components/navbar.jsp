<%@ page contentType="text/html; charset=UTF-8" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="index.jsp">FanfareHub</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link" href="inscription.jsp">Inscription</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="connexion.jsp">Connexion</a>
        </li>
        <c:if test="${not empty sessionScope.utilisateur and sessionScope.utilisateur.admin}">
          <li class="nav-item">
            <a class="nav-link" href="gestionUtilisateurs.jsp">Admin</a>
          </li>
        </c:if>
        <c:if test="${not empty sessionScope.utilisateur}">
          <li class="nav-item">
            <a class="nav-link" href="deconnexion">Déconnexion</a>
          </li>
        </c:if>
      </ul>
    </div>
  </div>
</nav>