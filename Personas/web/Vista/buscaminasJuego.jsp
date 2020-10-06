<%-- 
    Document   : jugar
    Created on : 23 sept. 2020, 12:27:36
    Author     : rodrigo
--%>

<%@page import="Modelo.Persona"%>
<%@page import="Auxiliar.Constantes"%>
<%@page import="Modelo.Buscaminas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Buscaminas</title>
        <style>
            .tablero {
                height: auto;
                display: inline-block;
                border: 1px solid black;
                padding: 15px;
            }
            a,p.boton {
                text-decoration: none;
                border: 1px solid black;
                margin: 0;
                padding: 5px 10px;
                border-radius: 30%;
                background: grey;
                color: black;
                display: inherit;
                font-size: x-large;
                width: 18px;
                }
            p.boton {
              display: inline-block;
            }
            form{
                margin-top:10px;
            }
            form a,input[type=submit] {                
                width: auto;
                cursor: default;
                background: rgb(239, 239, 239);
                box-sizing: border-box;
                font: 400 13.3333px Arial;
                border-width: 1px;
                border-style: outset;
                border-color: rgb(118, 118, 118);
                border-image: initial;
                border-radius: 3px;
                padding: 2px;
                display: inline-block;
            }
        </style>
    </head>
    <body>
        <center>
        <%
            Persona usuario = (Persona)session.getAttribute("usuario");
            Buscaminas b;
            int estado = 0;
            String accion = "";
            if(request.getParameter("accion")!=null)accion=request.getParameter("accion");
            if(accion.equals("Jugar")){
                usuario.addPartida();                
            }
            if(accion.equals("Volver")){
                response.sendRedirect(Constantes.V_BIENVENIDO);
            }
            if(session.getAttribute("buscaminas")!=null){
                b = (Buscaminas)session.getAttribute("buscaminas");
                if(accion.equals("rendirse")){
                    b.rendirse();
                } else if(request.getParameter("posicion")!=null){
                   int posicion = Integer.parseInt(request.getParameter("posicion"));
                   estado = b.comprobarPosicion(posicion);
                }
            } else {//Primera entrada
                int size = Integer.parseInt(request.getParameter("size"));
                int minas = Integer.parseInt(request.getParameter("minas"));
                b = new Buscaminas(size, minas);
                b.iniciar();
            }
            session.setAttribute("buscaminas", b);
            out.print(b.pintar());
            if(estado == -1){
                session.removeAttribute("buscaminas");
            %>
            <p>Has perdido</p>
            <% } else if(estado == 1) {
                usuario.addGanada();
                session.removeAttribute("buscaminas");%>
            <p>Has ganado</p>
            <% } else if(accion.equals("rendirse")) {
                session.removeAttribute("buscaminas");%>
            <p>Te has rendido</p>
            <% }
        %>
            <form action="<%=Constantes.V_BUSCAMINAS%>">
                <input type="submit" value="Volver"/>
                <a class="accion" href="<%=Constantes.V_BUSCAMINAS_JUEGO%>?accion=rendirse" >Rendirse</a>
            </form>
        </center>
    </body>
</html>
