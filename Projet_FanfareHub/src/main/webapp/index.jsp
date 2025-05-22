<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>FanfareHub - Accueil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex flex-column min-vh-100">

<jsp:include page="components/navbar.jsp"/>
<%
    String message = (String) session.getAttribute("message");
    if (message != null) {
%>
<div class="alert alert-success text-center" role="alert">
    <%= message %>
</div>
<%
        session.removeAttribute("message");
    }
%>

<main class="container my-5">
    <h1 class="text-center">Bienvenue sur FanfareHub 🎺</h1>
    <p class="text-center">Plateforme de gestion collaborative des fanfares.</p>
</main>

<jsp:include page="components/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>