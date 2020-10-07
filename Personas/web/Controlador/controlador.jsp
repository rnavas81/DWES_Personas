<%-- 
    Document   : distribuidor
    Created on : 22 sept. 2020, 14:25:34
    Author     : rodrigo
--%>

<%@page import="Modelo.Asignatura"%>
<%@page import="Modelo.Curso"%>
<%@page import="Auxiliar.Constantes"%>
<%@page import="Modelo.ConexionEstatica"%>
<%@page import="Modelo.Persona"%>
<%@page import="java.util.*"%>
<%    // Recupera la acci�n 
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
        String dni = request.getParameter("dni") != null ? request.getParameter("dni") : "";
        String password = request.getParameter("pass") != null ? request.getParameter("pass") : "";
        Persona persona = ConexionEstatica.accederUsuario(dni, password);
        int tipo = -1;
        if(persona!=null){//Puede acceder
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
                session.setAttribute("msg_index", "DNI o contrase�a no valido");
                response.sendRedirect(Constantes.V_INDEX);
                break;
        }
    } else if (accion.equals("Volver")) {
        Persona persona = (Persona)session.getAttribute("usuario"); 
        int tipo = -1;
        if(persona!=null){//Puede acceder
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
    } else if(accion.equals("Recuperar")){
        response.sendRedirect(Constantes.V_RECUPERAR);
    } else if(accion.equals("Crear")){
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
        p.setPassword(password);
        try {
            ConexionEstatica.agregarPersona(p);
            session.setAttribute("msg_index", "Usuario creado");
            personas.add(p);
            response.sendRedirect(Constantes.V_INDEX);                
        } catch (Exception e) {
            response.sendRedirect(Constantes.V_ERROR);
        }

    } else if(accion.equals("Jugar")){
        response.sendRedirect(Constantes.V_BUSCAMINAS);
        
    } else {
        session.invalidate();
        response.sendRedirect(Constantes.V_INDEX);
    }
%>