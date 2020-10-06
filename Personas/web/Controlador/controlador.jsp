<%-- 
    Document   : distribuidor
    Created on : 22 sept. 2020, 14:25:34
    Author     : rodrigo
--%>

<%@page import="Auxiliar.Constantes"%>
<%@page import="Modelo.ConexionEstatica"%>
<%@page import="Modelo.Persona"%>
<%@page import="java.util.*"%>
<%
    String accion = request.getParameter("accion");
    LinkedList<Persona> personas = new LinkedList<>();
    if (accion == null) {
        session.invalidate();
        response.sendRedirect(Constantes.V_INDEX);

    } else if (accion.equals("Acceder")) {
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
                session.invalidate();
                response.sendRedirect(Constantes.V_INDEX);
                break;
        }
    } else if (accion.equals("Volver")) {
        /*
        Persona persona = (Persona)session.getAttribute("usuario");  
        switch (persona.getTipo()) {
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
        */
    } else if (accion.equals("Registrar")) {
        response.sendRedirect(Constantes.V_REGISTRAR);
    } else if(accion.equals("Recuperar")){
        response.sendRedirect(Constantes.V_RECUPERAR); 
    } else {
        session.invalidate();
        response.sendRedirect(Constantes.V_INDEX);
    }
%>