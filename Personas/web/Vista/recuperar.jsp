<%@page import="Auxiliar.Constantes"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>Mi app - Recuperar contraseña</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="<%=Constantes.CSS_GLOBAL%>"/>
        <link rel="stylesheet" href="<%=Constantes.CSS_FORMULARIO%>"/>
    </head>
    <body class="index">
        <h1>Acceso</h1>
        <form action="<%=Constantes.C_CONTROLADOR%>" method="POST">
            <label>Email</label>
            <input type="email" name="email" required />
            <hr/>
            <div class="botones">
                <input type="submit" name="accion" value="Enviar"    />
                <input type="submit" name="accion" value="Cancelar"  />
            </div>
        </form>
</body>
</html>
