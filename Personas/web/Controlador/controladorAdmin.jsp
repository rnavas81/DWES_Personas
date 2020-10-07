<%-- 
    Document   : distribuidor
    Created on : 22 sept. 2020, 14:25:34
    Author     : rodrigo
--%>

<%@page import="Modelo.Curso"%>
<%@page import="Modelo.Asignatura"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Modelo.ConexionEstatica"%>
<%@page import="Auxiliar.Constantes"%>
<%@page import="Modelo.Persona"%>
<%@page import="java.util.ArrayList"%>
<%
    // Recupera la acción 
    String accion = request.getParameter("accion");
    if(accion == null){
        if(request.getParameter("eliminar")!=null){
            accion = "eliminar";
        } else if(request.getParameter("modificar")!=null){
            accion = "modificar";
        } else {
            session.invalidate();
            response.sendRedirect(Constantes.V_INDEX);            
        }
    }
    // Recupera los datos de sesion
    LinkedList<Persona> personas = new LinkedList<>();
    if(session.getAttribute("personas")!=null){
        personas = (LinkedList) session.getAttribute("personas");
    } else {
        personas = ConexionEstatica.obtenerPersonas();
    }
    LinkedList<Curso> cursos = new LinkedList<>();
    if(session.getAttribute("cursos")!=null){
        cursos = (LinkedList) session.getAttribute("cursos");
    } else {
        cursos = ConexionEstatica.getCursos();
    }
    LinkedList<Asignatura> asignaturas = new LinkedList<>();
    if(session.getAttribute("asignaturas")!=null){
        asignaturas = (LinkedList) session.getAttribute("asignaturas");
    } else {
        asignaturas = ConexionEstatica.getAsignaturas();
    }
    //**************************
    //ACCIONES
    if (accion.equals("Acceder")) {
        Persona p = (Persona) session.getAttribute("usuario");
        int tipoAcceso = Integer.parseInt(request.getParameter("tipoAcceso"));
        switch (tipoAcceso) {
            case 0:
                response.sendRedirect(Constantes.V_BIENVENIDO);
                break;
            case 1:
                response.sendRedirect(Constantes.V_LISTAR);
                break;
            default:
                session.invalidate();
                response.sendRedirect(Constantes.V_INDEX);
                break;
        }
    } else if (accion.equals("eliminar")) {
        String dni = request.getParameter("dni");        
        ConexionEstatica.eliminarPersona(dni);
        boolean encontrado=false;
        for (int i = 0; i < personas.size() && !encontrado; i++) {
                Persona persona = personas.get(i);
                if(persona.getDNI().equals(dni)){
                    personas.remove(i);
                    encontrado=true;
                }
            }
        response.sendRedirect(Constantes.V_LISTAR);
    } else if (accion.equals("modificar")) {
        String dni = request.getParameter("dni").trim();
        for (Persona p : personas) {
            if (p.getDNI().trim().equals(dni)) {
                session.setAttribute("persona", p);
                response.sendRedirect(Constantes.V_EDITAR);
            }
        }
    } else if (accion.equals("Editar")) {
        String dni = request.getParameter("dni")!=null?request.getParameter("dni"):"";
        String password = request.getParameter("password")!=null?request.getParameter("password"):"";
        String nombre = request.getParameter("nombre")!=null?request.getParameter("nombre"):"";
        String apellidos = request.getParameter("apellidos")!=null?request.getParameter("apellidos"):"";
        String email = request.getParameter("email")!=null?request.getParameter("email"):"";
        String telefono = request.getParameter("telefono")!=null?request.getParameter("telefono"):"";
        String fecha = request.getParameter("fecha");
        int tipo = Integer.parseInt(request.getParameter("tipo"));
        int edad = 0;
        try {
            edad = Integer.parseInt(request.getParameter("edad"));
        } catch (Exception e) {
            edad = 0;
        }

        int genero = 0;
        try {
            genero = Integer.parseInt(request.getParameter("genero"));
        } catch (Exception e){
            genero = 0;
        }
        Curso curso = null;
        if(request.getParameter("curso")!=null){
            for (Curso curso1 : cursos) {
                    if(curso1.getCodigo().equals(request.getParameter("curso"))){
                        curso = curso1;
                        break;
                    }
                }
        }
        LinkedList<Asignatura> fAsignaturas = new LinkedList<>();
        if (request.getParameterValues("asignaturas") != null) {
            for(String codigo:request.getParameterValues("asignaturas")){
                for(Asignatura a:asignaturas){
                    if(a.getCodigo().equals(codigo)){
                        fAsignaturas.add(a);
                        break;
                    }
                }
            }
        }
        Persona p = new Persona(dni, nombre, apellidos, email, telefono, tipo, edad, genero, fecha, curso, fAsignaturas);
        if(password!=null && !password.isEmpty()){
            p.setPassword(password);
        }
        try {
            ConexionEstatica.editarPersona(p);
            int i=0;
            for (Persona persona : personas) {
                if(persona.getDNI().equals(p.getDNI())){
                    break;
                } else {
                    i++;
                }
            }
            personas.set(i, p);
            session.setAttribute("msg_index", "Usuario creado");
            response.sendRedirect(Constantes.V_INDEX);                
        } catch (Exception e) {
            response.sendRedirect(Constantes.V_ERROR);
        }

        response.sendRedirect(Constantes.V_LISTAR);
    } else if (accion.equals("Cancelar")) {
        response.sendRedirect(Constantes.V_LISTAR);  
    } else {
        response.sendRedirect(Constantes.V_INDEX);
    }
%>