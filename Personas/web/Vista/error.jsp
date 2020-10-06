<%-- 
    Document   : error.jsp
    Created on : 4 oct. 2020, 19:47:22
    Author     : rodrigo
--%>

<%@page import="Auxiliar.Constantes"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Mi app - Error de acceso</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="<%=Constantes.CSS_GLOBAL%>"/>
    </head>
    <body>
        <h1>Acceso no autorizado</h1>
        <form action="<%=Constantes.C_CONTROLADOR%>" method="POST">
            <input name="accion" value="Salir">
        </form>
    </body>
</html>
