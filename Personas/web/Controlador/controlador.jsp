<%-- 
    Document   : distribuidor
    Created on : 22 sept. 2020, 14:25:34
    Author     : rodrigo
--%>
<%@page import="Auxiliar.Funciones"%>
<%@page import="java.nio.charset.Charset"%>
<%@page import="Modelo.Email"%>
<%@page import="Auxiliar.Constantes"%>
<%@page import="Modelo.Asignatura"%>
<%@page import="Modelo.Curso"%>
<%@page import="Modelo.ConexionEstatica"%>
<%@page import="Modelo.Persona"%>
<%@page import="java.io.*,java.util.*,javax.mail.*"%>
<%@page import="javax.mail.internet.*,javax.activation.*"%>
<%@page import="javax.servlet.http.*,javax.servlet.*" %>
<%    // Recupera la acción 
    String accion = request.getParameter("accion");
    if (accion == null) {
        if (request.getParameter("cancelarEditarPerfil") != null) {
            accion = "Volver";
        } else if (request.getParameter("modificarEditarPerfil") != null) {
            accion = "modificarPerfil";
        } else {
            session.invalidate();
            response.sendRedirect(Constantes.V_INDEX);
        }
    }
    // Recupera los datos de sesion
    LinkedList<Persona> personas = new LinkedList<>();
    if(session.getAttribute(Constantes.S_PERSONAS)!=null){
        personas = (LinkedList) session.getAttribute(Constantes.S_PERSONAS);
    } else {
        personas = ConexionEstatica.obtenerPersonas();
        session.setAttribute(Constantes.S_PERSONAS, personas);
    }
    LinkedList<Curso> cursos = new LinkedList<>();
    if(session.getAttribute(Constantes.S_CURSOS)!=null){
        cursos = (LinkedList) session.getAttribute(Constantes.S_CURSOS);
    } else {
        cursos = ConexionEstatica.getCursos();
        session.setAttribute(Constantes.S_CURSOS, cursos);
    }
    LinkedList<Asignatura> asignaturas = new LinkedList<>();
    if(session.getAttribute(Constantes.S_ASIGNATURAS)!=null){
        asignaturas = (LinkedList) session.getAttribute(Constantes.S_ASIGNATURAS);
    } else {
        asignaturas = ConexionEstatica.getAsignaturas();
        session.setAttribute(Constantes.S_ASIGNATURAS, asignaturas);
    }
    //**************************
    //ACCIONES
    if (accion.equals("Acceder")) {
        String dni = request.getParameter("dni") != null ? request.getParameter("dni") : "";
        String password = request.getParameter("pass") != null ? request.getParameter("pass") : "";
        Persona persona = ConexionEstatica.accederUsuario(dni, password);
        int tipo = -1;
        if (persona != null) {//Puede acceder
            session.setAttribute("usuario", persona);
            tipo = persona.getTipo();
        }
        switch (tipo) {
            case 0://Usuario normal
                response.sendRedirect(Constantes.V_BIENVENIDO);
                break;
            case 1://Usuario administrador
                response.sendRedirect(Constantes.V_BIENVENIDO_ADMIN);
                break;
            default:
                //session.invalidate();
                session.setAttribute("msg_index", "DNI o contraseña no valido");
                response.sendRedirect(Constantes.V_INDEX);
                break;
        }
    } else if (accion.equals("Volver")) {
        Persona persona = (Persona) session.getAttribute("usuario");
        int tipo = -1;
        if (persona != null) {//Puede acceder
            tipo = persona.getTipo();
        }
        switch (tipo) {
            case 0://Usuario normal
                response.sendRedirect(Constantes.V_BIENVENIDO);
                break;
            case 1://Usuario administrador
                response.sendRedirect(Constantes.V_BIENVENIDO_ADMIN);
                break;
            default:
                session.invalidate();
                response.sendRedirect(Constantes.V_INDEX);
                break;
        }
    } else if (accion.equals("Registrar")) {
        response.sendRedirect(Constantes.V_REGISTRAR);
    } else if (accion.equals("Recuperar")) {
        response.sendRedirect(Constantes.V_RECUPERAR);
    } else if (accion.equals("Crear")) {
        String dni = request.getParameter("dni") != null ? request.getParameter("dni") : "";
        String password = request.getParameter("password") != null ? request.getParameter("password") : "";
        String nombre = request.getParameter("nombre") != null ? request.getParameter("nombre") : "";
        String apellidos = request.getParameter("apellidos") != null ? request.getParameter("apellidos") : "";
        String email = request.getParameter("email") != null ? request.getParameter("email") : "";
        String telefono = request.getParameter("telefono") != null ? request.getParameter("telefono") : "";
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
        } catch (Exception e) {
            genero = 0;
        }
        Curso curso = null;
        if (request.getParameter("curso") != null) {
            for (Curso curso1 : cursos) {
                if (curso1.getCodigo().equals(request.getParameter("curso"))) {
                    curso = curso1;
                    break;
                }
            }
        }
        LinkedList<Asignatura> fAsignaturas = new LinkedList<>();
        if (request.getParameterValues("asignaturas") != null) {
            for (String codigo : request.getParameterValues("asignaturas")) {
                for (Asignatura a : asignaturas) {
                    if (a.getCodigo().equals(codigo)) {
                        fAsignaturas.add(a);
                        break;
                    }
                }
            }
        }
        Persona p = new Persona(dni, nombre, apellidos, email, telefono, tipo, edad, genero, fecha, curso, fAsignaturas);
        p.setPassword(password);
        try {
            ConexionEstatica.agregarPersona(p);
            session.setAttribute("msg_index", "Usuario creado");
            personas.add(p);
            response.sendRedirect(Constantes.V_INDEX);
        } catch (Exception e) {
            response.sendRedirect(Constantes.V_ERROR);
        }

    } else if (accion.equals("Jugar")) {
        response.sendRedirect(Constantes.V_BUSCAMINAS);
    } else if (accion.equals("Editar")) {
        response.sendRedirect(Constantes.V_EDITAR_PERFIL);
    } else if (accion.equals("Enviar")) {
        if (request.getParameter("email") != null) {
            String pEmail = request.getParameter("email");
            boolean buscando = true;
            for (int i = 0; i < personas.size() && buscando ; i++) {
                Persona persona = personas.get(i);
                if (persona.getEmail().equals(pEmail.trim())) {
                    buscando = false;
                    String newPass = Funciones.alphanumericoAleatorio(8);
                    Email email = new Email();
                    String mensaje= "Cuerpo del mensaje.\nSu nueva contraseña es " + newPass;
                    String asunto = "Contraseña olvidada";
                    email.enviarCorreo(pEmail, mensaje, asunto);
                    persona.setPassword(newPass);
                    ConexionEstatica.setPassword(persona);
                    personas.set(i, persona);
                }
            }
            session.setAttribute("msg_index", "Email enviado");
            response.sendRedirect(Constantes.V_INDEX);
        }
    } else {
        session.invalidate();
        response.sendRedirect(Constantes.V_INDEX);
    }
%>