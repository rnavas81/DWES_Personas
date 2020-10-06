<%-- 
    Document   : buscaminas
    Created on : 6 oct. 2020, 19:53:51
    Author     : rodrigo
--%>

<%@page import="Auxiliar.Constantes"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Buscaminas</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            input{
                margin-top: 10px
            }
        </style>
    </head>
    <body>
        <center>
            <form action="<%=Constantes.V_BUSCAMINAS_JUEGO%>" method="POST" style="display: inline-block; width: min-content;">
                <fieldset>
                    <legend>Buscaminas</legend>
                    <label>Tamaño</label><input type="number" name="size" value="8" required/>
                    <label>Minas</label><input type="number" name="minas" value="4" required/>
                    <input type="submit" name="accion" value="Jugar"/>
                    <input type="submit" name="accion" value="Volver"/>
                </fieldset>
            </form>
        </center>
    </body>
</html>
