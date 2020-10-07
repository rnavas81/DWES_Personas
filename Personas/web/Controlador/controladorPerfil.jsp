<%-- 
    Document   : controladorPerfil
    Created on : 7 oct. 2020, 13:58:54
    Author     : rodrigo
--%>
<%@page import="Modelo.ConexionEstatica"%>
<%@page import="java.io.File"%>
<%@page import="Auxiliar.Constantes"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page import="java.util.Date"%>
<%@page import="Modelo.Persona"%>
<%

    Persona persona = (Persona) session.getAttribute("usuario");

    FileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);

    // req es la HttpServletRequest que recibimos del formulario.
    // Los items obtenidos serán cada uno de los campos del formulario,
    // tanto campos normales como ficheros subidos.
    List items = upload.parseRequest(request);

    // Se recorren todos los items, que son de tipo FileItem
    for (Object item : items) {
        FileItem uploaded = (FileItem) item;

        // Hay que comprobar si es un campo de formulario. Si no lo es, se guarda el fichero
        // subido donde nos interese
        if (!uploaded.isFormField()) {
            File directory = new File(Constantes.DIR_AVATAR);
            if (!directory.exists()) {
                directory.mkdir();
            }
            String fileName = uploaded.getName();
            if(!fileName.isBlank()){
                String extension = "";
                int index = fileName.lastIndexOf(".");
                if(index > 0){
                    extension = fileName.substring(index+1);
                    extension = extension.toLowerCase();
                }
                String newName = Long.toString(new Date().getTime()) + "." + extension;
                persona.setAvatar(newName);
                // No es campo de formulario, guardamos el fichero en algún sitio
                File fichero = new File(Constantes.DIR_AVATAR, newName);
                uploaded.write(fichero);            
            }            
        } else {
            String key = uploaded.getFieldName();
            String valor = uploaded.getString();
            if (key.equals("username")) {
                persona.setUsername(valor);
            } else if (key.equals("cancelarEditarPerfil")) {
                response.sendRedirect(Constantes.V_BIENVENIDO);
            }
        }
    }
    ConexionEstatica.editarPerfil(persona);
    session.setAttribute("usuario", persona);
    Thread.sleep(2000);
    response.sendRedirect(Constantes.V_BIENVENIDO);

%>
