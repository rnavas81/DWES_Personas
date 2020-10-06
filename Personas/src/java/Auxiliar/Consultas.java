/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Auxiliar;

/**
 *
 * @author rodrigo
 */
public class Consultas {
    /////////////////////////////////
    // PERSONAS
    ////////////////////////////////
    public static String getPersonas = "SELECT p.`DNI`, p.`Tipo`, p.`Nombre`, p.`Apellidos`, p.`Email`, p.`Tfno`, p.`Edad`, p.`Genero`, p.`Fecha` , p.`PJugadas` , p.`PGanadas` ,c.`Codigo`,c.`Nombre` " +
                "FROM `"+Constantes.T_PERSONAS+"` p " +
                "LEFT JOIN `Cursos` AS c ON c.Codigo = p.Curso " +
                "WHERE p.Habilitado = 1 ORDER BY p.Apellidos,p.Nombre";
    public static String getPersona(String DNI){
        return  "SELECT p.`DNI`, p.`Tipo`, p.`Nombre`, p.`Apellidos`, p.`Email`, p.`Tfno`, p.`Edad`, p.`Genero`, p.`Fecha`, p.`PJugadas` , p.`PGanadas` ,c.`Codigo`,c.`Nombre` " +
                "FROM `"+Constantes.T_PERSONAS+"` p " +
                "LEFT JOIN `Cursos` AS c ON c.Codigo = p.Curso " +
                "WHERE DNI = '"+DNI+"' AND p.Habilitado = 1";
    }
    public static String testPersona(String DNI,String password){
        return  "SELECT p.`DNI`, p.`Tipo`, p.`Nombre`, p.`Apellidos`, p.`Email`, p.`Tfno`, p.`Edad`, p.`Genero`, p.`Fecha`, p.`PJugadas` , p.`PGanadas` ,c.`Codigo`,c.`Nombre` " +
                "FROM `"+Constantes.T_PERSONAS+"` p " +
                "LEFT JOIN `Cursos` AS c ON c.Codigo = p.Curso " +
                "WHERE DNI = '"+DNI+"' AND Password='"+password+"' AND p.Habilitado = 1";
    }
    public static String deletePersona(String DNI){
        return "DELETE FORM "+Constantes.T_PERSONAS+" WHERE DNI='"+DNI+"'";
    }
    
    /////////////////////////////////
    // CURSOS
    ////////////////////////////////
    public static String getCursos = "SELECT * FROM `"+Constantes.T_CURSOS+"`";
    public static String getCurso(String codigo){
        return getCursos+" WHERE codigo = '"+codigo+"'";
    }
    
    /////////////////////////////////
    // ASIGNATURAS
    ////////////////////////////////
    public static String getAsignaturas = "SELECT * FROM `"+Constantes.T_ASIGNATURAS+"`";
    public static String getAsignatura(String codigo){
        return getAsignaturas+" WHERE codigo = '"+codigo+"'";
    }
    
}
