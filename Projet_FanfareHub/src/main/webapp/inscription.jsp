<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Inscription - FanfareHub</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex flex-column min-vh-100">
<jsp:include page="components/navbar.jsp"/>

<main class="container my-5">
  <h2 class="mb-4">Formulaire d'inscription</h2>
  <form action="inscription" method="post">
    <div class="mb-3">
      <label for="email" class="form-label">Adresse email</label>
      <input type="email" class="form-control" id="email" name="email" required>
    </div>
    <div class="mb-3">
      <label for="emailConfirm" class="form-label">Confirmation email</label>
      <input type="email" class="form-control" id="emailConfirm" name="emailConfirm" required>
    </div>
    <div class="mb-3">
      <label for="mdp" class="form-label">Mot de passe</label>
      <input type="password" class="form-control" id="mdp" name="mdp" required>
    </div>
    <div class="mb-3">
      <label for="mdpConfirm" class="form-label">Confirmation mot de passe</label>
      <input type="password" class="form-control" id="mdpConfirm" name="mdpConfirm" required>
    </div>
    <div class="mb-3">
      <label for="prenom" class="form-label">Prénom</label>
      <input type="text" class="form-control" id="prenom" name="prenom" required>
    </div>
    <div class="mb-3">
      <label for="nom" class="form-label">Nom</label>
      <input type="text" class="form-control" id="nom" name="nom" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Genre</label><br>
      <select name="genre" class="form-select" required>
        <option value="">-- Sélectionnez --</option>
        <option value="male">Homme</option>
        <option value="female">Femme</option>
        <option value="other">Autre</option>
      </select>
    </div>
    <div class="mb-3">
      <label class="form-label">Contraintes alimentaires</label><br>
      <select name="alimentaire" class="form-select">
        <option value="none">Aucune</option>
        <option value="vegetarian">Végétarien</option>
        <option value="vegan">Vegan</option>
        <option value="pork-free">Sans porc</option>
      </select>
    </div>
    <button type="submit" class="btn btn-primary">S'inscrire</button>
  </form>
</main>

<jsp:include page="components/footer.jsp"/>
</body>
</html>