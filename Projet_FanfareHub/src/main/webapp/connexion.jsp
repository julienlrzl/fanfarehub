<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Connexion - FanfareHub</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex flex-column min-vh-100">
<jsp:include page="components/navbar.jsp"/>

<main class="container my-5">
  <h2 class="mb-4">Connexion</h2>
  <form action="connexion" method="post">
    <div class="mb-3">
      <label for="nomFanfaron" class="form-label">Email</label>
      <input type="text" class="form-control" id="email" name="email" required>
    </div>
    <div class="mb-3">
      <label for="mdp" class="form-label">Mot de passe</label>
      <input type="password" class="form-control" id="mdp" name="mdp" required>
    </div>
    <button type="submit" class="btn btn-success">Se connecter</button>
  </form>
</main>

<jsp:include page="components/footer.jsp"/>
</body>
</html>