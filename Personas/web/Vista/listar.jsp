<%-- 
    Document   : listar
    Created on : 23 sept. 2020, 10:25:46
    Author     : rodrigo
--%>

<%@page import="java.util.LinkedList"%>
<%@page import="Modelo.ConexionEstatica"%>
<%@page import="Auxiliar.Constantes"%>
<%@page import="Modelo.Persona"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="<%=Constantes.CSS_GLOBAL%>"/>
        <link rel="stylesheet" href="<%=Constantes.CSS_LISTAR%>"/>
        <title>Mi app - Usuarios</title>
    </head>
    <body>
        <form class="cabecera" action="<%=Constantes.C_CONTROLADOR%>">
            <input type="submit" name="accion" value="Cerrar sesion">
            <input type="submit" name="accion" value="Volver">
        </form>
        <%
            LinkedList<Persona> personas = new LinkedList<>();
            if (session.getAttribute("personas") != null) {
                personas = (LinkedList) session.getAttribute("personas");
            } else {
                personas = ConexionEstatica.obtenerPersonas();
            }
            if (personas.size() > 0) {
                for (Persona p : personas) {%>
        <form action="<%=Constantes.C_CONTROLADOR_ADMIN%>" method="POST">
            DNI: <input type="text" name="dni" value="<%=p.getDNI()%>" readonly/> Nombre: <input type="text" name="nombre" value="<%=p.getNombre()%>" readonly/> Apellidos: <input type="text" name="nombre" value="<%=p.getApellidos()%>" readonly/>
            <div>
                <input type="submit" name="eliminar" value="X">
                <input type="submit" name="modificar" value="E">
            </div>
        </form><%
            }
        %>
        <% } else {%>
        <p>No hay nadie en la lista</p>
        <% }
        %>
    </body>
</html>
