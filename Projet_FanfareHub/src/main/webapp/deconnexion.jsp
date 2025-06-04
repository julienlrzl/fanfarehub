<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    session.invalidate();

    HttpSession nouvelleSession = request.getSession();
    nouvelleSession.setAttribute("message", "Déconnexion réussie.");

    response.sendRedirect("index.jsp");
%>