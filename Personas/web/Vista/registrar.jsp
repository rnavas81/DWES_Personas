<%@page import="Auxiliar.Constantes"%>
<%@page import="Modelo.Asignatura"%>
<%@page import="Modelo.ConexionEstatica"%>
<%@page import="Modelo.Curso"%>
<%@page import="java.util.LinkedList"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>Mi app - Datos de Persona</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="<%=Constantes.CSS_GLOBAL%>"/>
        <link rel="stylesheet" href="<%=Constantes.CSS_FORMULARIO%>"/>
    </head>
    <body>
        <%
            LinkedList<Curso> cursos = new LinkedList<>();
            if(session.getAttribute("cursos")!=null){
                cursos = (LinkedList<Curso>) session.getAttribute("cursos");
            } else {
                cursos = ConexionEstatica.getCursos();
                session.setAttribute("cursos", cursos);
            }
            LinkedList<Asignatura> asignaturas = new LinkedList<>();
            if(session.getAttribute("asignaturas")!=null){
                asignaturas = (LinkedList<Asignatura>) session.getAttribute("asignaturas");
            } else {
                asignaturas = ConexionEstatica.getAsignaturas();
                session.setAttribute("asignaturas", asignaturas);
            }
        %>

        <form action="<%=Constantes.C_CONTROLADOR%>" name="formulario" style="width:max-content" method="POST">
            <div>
                <label>DNI:</label><input type="text" name="dni" placeholder="000000000#" required/>
            </div>
            <div>
                <label>Nombre:</label><input type="text" name="nombre" placeholder="Nombre" /><input type="text" name="apellidos" placeholder="Apellidos"/>
            </div>
            <div>
                <label>Email:</label><input type="email" name="email" placeholder="usuario@email.com" />
            </div>
            <div>
                <label>Teléfono</label><input type="text" name="telefono" placeholder="000000000" />
            </div>
            <div>
                <label>Contraseña:</label><input type="password" name="password" placeholder="Contraseña"/>
            </div>
            <div class="izquierda">
                <fieldset>
                    <legend>Tipo:</legend>
                    <input type="radio" name="tipo" value="0" checked/><label>Usuario</label>
                    <input type="radio" name="tipo" value="1" /><label>Administrador</label>
                </fieldset>
            </div>
            <div>
                <label>Edad:</label><input type="number" name="edad" />
            </div>
            <div class="izquierda">
                <fieldset>
                    <legend>Sexo:</legend>
                    <input type="radio" name="genero" value="0" checked/><label>Hombre</label>
                    <input type="radio" name="genero" value="1" /><label>Mujer</label>
                </fieldset>
            </div>
            <div>
                <label>Fecha actual:</label><input type="date" name="fecha" />
            </div>
            <div class="izquierda">
                <fieldset>
                    <legend>Asignaturas:</legend>
                        <%
                            for (Asignatura asignatura : asignaturas) {
                            %><label><%=asignatura.getNombre()%></label><input type="checkbox" name="asignaturas" value="<%=asignatura.getCodigo()%>"/>
                            <br><%
                        }%>
                </fieldset>
            </div>
            <div>            
                <fieldset>
                    <legend>Curso:</legend>
                    <select name="curso">
                        <%
                            boolean primero=true;
                            for (Curso curso : cursos) {
                            %><option label="<%=curso.getNombre()%>" value="<%=curso.getCodigo()%>" <%=primero?"selected":""%>/><%
                                primero=false;
                        }%>                        
                    </select>
                </fieldset>
            </div>
            <div style="clear:both;">
            </div>
            <div class="botones">                
                <input type="submit" name="accion" value="Crear" />
                <input type="submit" name="accion" value="Cancelar"/>
            </div>
        </form>
    </body>
</html>
