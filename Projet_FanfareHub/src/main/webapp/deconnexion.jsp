<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    session.invalidate(); // Supprime la session

    // Crée une nouvelle session juste pour le message flash
    HttpSession nouvelleSession = request.getSession();
    nouvelleSession.setAttribute("message", "Déconnexion réussie.");

    response.sendRedirect("index.jsp");
%>