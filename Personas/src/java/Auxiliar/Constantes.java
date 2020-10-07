/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Auxiliar;

/**
 *
 * @author fernando
 */
public class Constantes {
    //BASE DE DATOS
    public static final String BBDD="Personas";
    public static final String usuario="rodrigo";
    public static final String password="Chubaca2020";
    public static final String ficheroBitacora="bitacora.txt";
    
    //TABLAS
    public static final String T_PERSONAS = "Personas";
    public static final String T_PERSONAS_ASIGNATURAS = "PersonasAsignaturas";
    public static final String T_CURSOS = "Cursos";
    public static final String T_ASIGNATURAS = "Asignaturas";
    
    //DIRECTORIOS
    public static final String ROOT = "/Personas";
    public static final String ROOT_FILES= "/home/rodrigo/particionLinux/DWEBS/DWES_Personas/Personas/web";
    public static final String RECURSOS_DIR = ROOT+"/Recursos";
    public static final String CSS_DIR = ROOT + "/css";
    public static final String VISTAS_DIR = ROOT + "/Vista";
    public static final String CONTROLADOR_DIR = ROOT + "/Controlador";
    
    //VISTAS
    public static final String V_INDEX = ROOT + "/index.jsp";
    public static final String V_BIENVENIDO = VISTAS_DIR + "/bienvenido.jsp";
    public static final String V_ERROR = VISTAS_DIR + "/error.jsp";
    public static final String V_BIENVENIDO_ADMIN = VISTAS_DIR + "/bienvenidoAdmin.jsp";
    public static final String V_REGISTRAR = VISTAS_DIR + "/registrar.jsp";
    public static final String V_LISTAR = VISTAS_DIR + "/listar.jsp";
    public static final String V_EDITAR = VISTAS_DIR + "/editar.jsp";
    public static final String V_RECUPERAR = VISTAS_DIR + "/recuperar.jsp";
    public static final String V_BUSCAMINAS = VISTAS_DIR + "/buscaminas.jsp";
    public static final String V_BUSCAMINAS_JUEGO = VISTAS_DIR + "/buscaminasJuego.jsp";
    public static final String V_EDITAR_PERFIL = VISTAS_DIR + "/editarPerfil.jsp";
    
    //CONTROLADORES
    public static final String C_CONTROLADOR = CONTROLADOR_DIR + "/controlador.jsp";
    public static final String C_CONTROLADOR_ADMIN = CONTROLADOR_DIR + "/controladorAdmin.jsp";
    public static final String C_CONTROLADOR_PERFIL = CONTROLADOR_DIR + "/controladorPerfil.jsp";
    
    //CSS
    public static final String CSS_GLOBAL = CSS_DIR+ "/style.css";
    public static final String CSS_FORMULARIO = CSS_DIR+ "/formulario.css";
    public static final String CSS_LISTAR = CSS_DIR+ "/listar.css";
    
    //IMAGENES
    public static final String IMG_USER_DEFAULT = RECURSOS_DIR + "/default.png";
    public static final String HOST_AVATAR = ROOT + "/Avatar";
    public static final String DIR_AVATAR = ROOT_FILES + "/Avatar";
    
    
}
