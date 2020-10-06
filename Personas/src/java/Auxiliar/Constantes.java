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
    public static final String T_CURSOS = "Cursos";
    public static final String T_ASIGNATURAS = "Asignaturas";
    
    public static final String ROOT = "/CRUD_LIST_BBDD";
    //VISTAS
    public static final String VISTAS_DIR = ROOT + "/Vista";
    public static final String V_INDEX = ROOT + "/index.jsp";
    public static final String V_BIENVENIDO = VISTAS_DIR + "/bienvenido.jsp";
    public static final String V_ERROR = VISTAS_DIR + "/error.jsp";
    public static final String V_BIENVENIDO_ADMIN = VISTAS_DIR + "/bienvenidoAdmin.jsp";
    public static final String V_REGISTRAR = VISTAS_DIR + "/registrar.jsp";
    public static final String V_LISTAR = VISTAS_DIR + "/listar.jsp";
    public static final String V_EDITAR = VISTAS_DIR + "/editar.jsp";
    public static final String V_RECUPERAR = VISTAS_DIR + "/recuperar.jsp";
    
    //CONTROLADORES
    public static final String CONTROLADOR_DIR = ROOT + "/Controlador";
    public static final String C_CONTROLADOR = CONTROLADOR_DIR + "/controlador.jsp";
    public static final String C_CONTROLADOR_ADMIN = CONTROLADOR_DIR + "/controladorAdmin.jsp";
    
    //CSS
    public static final String CSS_DIR = ROOT + "/css";
    public static final String CSS_GLOBAL = CSS_DIR+ "/style.css";
    public static final String CSS_FORMULARIO = CSS_DIR+ "/formulario.css";
    public static final String CSS_LISTAR = CSS_DIR+ "/listar.css";
    
}
