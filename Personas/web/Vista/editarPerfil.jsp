<%-- 
    Document   : editarPerfil
    Created on : 7 oct. 2020, 12:43:38
    Author     : rodrigo
--%>

<%@page import="Modelo.Persona"%>
<%@page import="Auxiliar.Constantes"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Perfil</title>
        <link rel="stylesheet" href="<%=Constantes.CSS_GLOBAL%>"/>
        <link rel="stylesheet" href="<%=Constantes.CSS_FORMULARIO%>"/>
    </head>
    <body>
        <%
            Persona persona = (Persona)session.getAttribute("usuario");
            %>
        <section>
            <form action="<%=Constantes.C_CONTROLADOR_PERFIL%>" enctype="multipart/form-data" method="POST">
                <label for="username">Username: </label>
                <input type="text" name="username" value="<%=persona.getUsername()%>">
                <input type="file" name="avatar" accept="image/png, image/jpeg">
                <input type="submit" name="modificarEditarPerfil" value="Modificar">
                <input type="submit" name="cancelarEditarPerfil" value="Cancelar">
            </form>            
        </section>
    </body>
</html>
