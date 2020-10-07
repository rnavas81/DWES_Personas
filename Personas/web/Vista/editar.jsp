<%@page import="Modelo.Asignatura"%>
<%@page import="Modelo.Curso"%>
<%@page import="Modelo.ConexionEstatica"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Auxiliar.Constantes"%>
<%@page import="Modelo.Persona"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>Mi app - Editar Persona</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="<%=Constantes.CSS_GLOBAL%>"/>
        <link rel="stylesheet" href="<%=Constantes.CSS_FORMULARIO%>"/>
        <style>
            div {
                margin: 10px 0;
                width: inherit;
            }
        </style>
    </head>
    <body>
        <%
            Persona p =new Persona();
            if(session.getAttribute("persona")!=null){
                p = (Persona) session.getAttribute("persona");
            } else {
                session.invalidate();
                response.sendRedirect("index.html");
            }
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
            
        <form action="<%=Constantes.C_CONTROLADOR_ADMIN%>" name="formulario" style="width:max-content" method="POST">
            <div>
                <label>DNI:</label><input type="text" name="dni" value="<%=p.getDNI()%>" placeholder="000000000#" readonly/>
            </div>
            <div>
                <label>Nombre:</label><input type="text" name="nombre" value="<%=p.getNombre()%>" placeholder="Nombre" /><input type="text" name="apellidos" value="<%=p.getApellidos()%>" placeholder="Apellidos"/>
            </div>
            <div>
                <label>Email:</label><input type="email" name="email" value="<%=p.getEmail()%>" placeholder="usuario@email.com" />
            </div>
            <div>
                <label>Contraseña:</label><input type="password" name="password" value="" placeholder="Contraseña"/>
            </div>
            <div class="izquierda">
                <fieldset>
                    <legend>Tipo:</legend>
                    <input type="radio" name="tipo" value="0" <% out.print(p.getTipo()==0?"checked":"");%>/><label>Usuario</label>
                    <input type="radio" name="tipo" value="1" <% out.print(p.getTipo()==1?"checked":"");%>/><label>Administrador</label>
                </fieldset>
            </div>
            <div>
                <label>Edad:</label><input type="number" name="edad" value="<%=p.getEdad()%>" />
            </div>
            <div class="izquierda">
                <fieldset>
                    <legend>Sexo:</legend>
                    <input type="radio" name="genero" value="Hombre" <%=p.getGenero()==0?"checked":""%>/><label>Hombre</label>
                    <input type="radio" name="genero" value="Mujer" <%=p.getGenero()==1?"checked":""%>/><label>Mujer</label>
                </fieldset>
            </div>
            <div>
                <label>Fecha actual:</label><input type="date" name="fecha" value="<%=p.getFecha()%>"/>
            </div>
            <div class="izquierda">
                <fieldset>
                    <legend>Asignaturas:</legend>
                        <%
                            for (Asignatura asignatura : asignaturas) {
                            %><label><%=asignatura.getNombre()%></label><input type="checkbox" name="asignaturas" value="<%=asignatura.getCodigo()%>" <%=p.isAsignatura(asignatura.getCodigo())?"checked":""%>/>
                            <br><%
                        }%>
                </fieldset>
            </div>
            <div>            
                <fieldset>
                    <legend>Curso:</legend>
                    <select name="curso">
                        <%
                            for (Curso curso : cursos) {
                            %><option label="<%=curso.getNombre()%>" value="<%=curso.getCodigo()%>" <%=p.getCurso().getCodigo().equals(curso.getCodigo())?"selected":""%>/><%
                        }%>                        
                    </select>
                </fieldset>
            </div>
            <div style="clear:both;">
            </div>
            <div>                
                <input type="submit" name="accion" value="Editar" />
                <input type="submit" name="accion" value="Cancelar"/>
            </div>
        </form>
        <%      session.removeAttribute("persona");     %>
    </body>
</html>
