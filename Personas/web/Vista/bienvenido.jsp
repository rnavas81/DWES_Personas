<%@page import="Modelo.Persona"%>
<%@page import="Auxiliar.Constantes"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>Personas - Bienvenido Usuario</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="<%=Constantes.CSS_GLOBAL%>"/>
    </head>
    <body>
        <%
            Persona persona = (Persona)session.getAttribute("usuario");
            %>
        <section>
            <form action="<%=Constantes.C_CONTROLADOR%>">
                <div>
                    Partidas jugadas: <%=persona.getPJugadas()%>
                    Partidas ganadas: <%=persona.getPGanadas()%>
                </div>
                <input type="submit" name="accion" value="Jugar" />
                <input type="submit" name="accion" value="Salir" />
            </form>
            
        </section>
    </body>
</html>
