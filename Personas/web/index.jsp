<%-- 
    Document   : index
    Created on : 2 oct. 2020, 13:07:09
    Author     : rodrigo
--%>

<%@page import="Auxiliar.Constantes"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrador de gente</title>
        <link rel="stylesheet" href="<%=Constantes.CSS_GLOBAL%>"/>
    </head>
    <body>
        <h1>Acceso</h1>
        <form action="<%=Constantes.C_CONTROLADOR%>" method="POST">
            <label>DNI</label>
            <input type="dni" name="dni"/>
            <label>Contraseña</label>
            <input type="password" maxlength="16" name="pass"/>
            <hr/>
            <div class="botones">
                <input type="submit" name="accion" value="Acceder"    />
                <input type="submit" name="accion" value="Registrar"  />
                <input type="submit" name="accion" value="Recuperar"  />                
            </div>
        </form>
    </body>
</html>
