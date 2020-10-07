<%-- 
    Document   : bienvenidoAdmin
    Created on : 29 sept. 2020, 14:02:16
    Author     : rodrigo
--%>

<%@page import="Auxiliar.Constantes"%>
<%@page import="Modelo.Persona"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="<%=Constantes.CSS_GLOBAL%>"/>
        <link rel="stylesheet" href="<%=Constantes.CSS_FORMULARIO%>"/>
        <title>Mi app - Bienvenido</title>
    </head>
    <body>
        <%
            Persona p = new Persona();
            if (session.getAttribute("usuario") != null) {
                p = (Persona) session.getAttribute("usuario");
            } else {
                session.invalidate();
                response.sendRedirect("error.html");
            }
        %>
        <h1>Bienvenido <%=p.getNombre()%></h1>
        <form action="<%=Constantes.C_CONTROLADOR_ADMIN%>" method="POST">
            <fieldset>
                <legend>Como quiere acceder</legend>
                <div>
                    <input type="radio" name="tipoAcceso" value="0" checked/><label>Usuario</label>                    
                </div>
                <div>
                    <input type="radio" name="tipoAcceso" value="1"/><label>Administrador</label>
                </div>
            </fieldset>
            <input type="submit" name="accion" value="Acceder">
        </form>
    </body>
</html>
