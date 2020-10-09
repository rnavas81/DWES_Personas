/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Auxiliar;

import Modelo.Asignatura;
import Modelo.Persona;

/**
 *
 * @author rodrigo
 */
public class Consultas {

    /////////////////////////////////
    // PERSONAS
    ////////////////////////////////
    private static String[] Campos_Persona = {"DNI", "Tipo", "Nombre", "Apellidos", "Email", "Tfno", "Edad", "Genero", "Fecha", "PJugadas", "PGanadas", "Avatar", "Username"};
    private static String[] Campos_Curso = {"Codigo", "Nombre"};
    private static String[] Campos_Asignatura = {"Codigo", "Nombre"};

    private static String getCampos(String[] campos, String pref) {
        String response = "";
        boolean primero = true;
        for (String campo : campos) {
            if (!primero) {
                response += ",";
            }
            response += pref + "." + campo;
            primero = false;
        }
        return response;
    }

    public static String getPersonas() {
        return "SELECT " + getCampos(Campos_Persona, "p") + "," + getCampos(Campos_Curso, "c") + " "
                + "FROM `" + Constantes.T_PERSONAS + "` p "
                + "LEFT JOIN `Cursos` AS c ON c.Codigo = p.Curso "
                + "WHERE p.Habilitado = 1 ORDER BY p.Apellidos,p.Nombre";
    }

    public static String getPersona(String DNI) {
        return "SELECT " + getCampos(Campos_Persona, "p") + "," + getCampos(Campos_Curso, "c") + " "
                + "FROM `" + Constantes.T_PERSONAS + "` p "
                + "LEFT JOIN `Cursos` AS c ON c.Codigo = p.Curso "
                + "WHERE DNI = '" + DNI + "' AND p.Habilitado = 1";
    }

    public static String testPersona(String DNI, String password) {
        return "SELECT " + getCampos(Campos_Persona, "p") + "," + getCampos(Campos_Curso, "c") + " "
                + "FROM `" + Constantes.T_PERSONAS + "` p "
                + "LEFT JOIN `Cursos` AS c ON c.Codigo = p.Curso "
                + "WHERE DNI = '" + DNI + "' AND Password='" + password + "' AND p.Habilitado = 1";
    }

    public static String insertPersona(Persona persona) {
        String campos = "`DNI`,`Password`,`Tipo`,`Nombre`,`Apellidos`,`Email`,`Tfno`,`Edad`,`Genero`";
        String valores = "'" + persona.getDNI() + "','" + persona.getPassword() + "','" + persona.getTipo() + "','" + persona.getNombre() + "','" + persona.getApellidos() + "','" + persona.getEmail() + "','" + persona.getTelefono() + "','" + persona.getEdad() + "','" + persona.getGenero() + "'";
        if (persona.getFecha() != null && !persona.getFecha().isBlank()) {
            campos += ",`Fecha`";
            valores += ",'" + persona.getFecha() + "'";
        } else {
            campos += ",`Fecha`";
            valores += ",NULL";
        }
        if (persona.getCurso() != null) {
            campos += ",`Curso`";
            valores += ",'" + persona.getCurso().getCodigo() + "'";
        } else {
            campos += ",`Curso`";
            valores += ",NULL";
        }
        String consulta = "INSERT INTO " + Constantes.T_PERSONAS + " (" + campos + ") VALUES (" + valores + ");";

        return consulta;
    }

    public static String updatePersona(Persona persona) {
        String consulta = "UPDATE " + Constantes.T_PERSONAS + " SET "
                + "`Tipo` = '" + persona.getTipo() + "'"
                + ",`Nombre` = '" + persona.getNombre() + "'"
                + ",`Apellidos` = '" + persona.getApellidos() + "'"
                + ",`Email` = '" + persona.getEmail() + "'"
                + ",`Tfno` = '" + persona.getTelefono() + "'"
                + ",`Edad` = '" + persona.getEdad() + "'"
                + ",`Genero` = '" + persona.getGenero() + "'"
                + ",`Fecha` = " + (persona.getFecha().isBlank()?null:"'"+persona.getFecha() + "'")
                + ",`PJugadas` = '" + persona.getPJugadas()+ "'"
                + ",`PGanadas` = '" + persona.getPGanadas()+ "'"
                + ",`Avatar` = '" + persona.getAvatar()+ "'"
                + ",`Username` = '" + persona.getUsername()+ "'";
        if (!persona.getPassword().isBlank()) {
            consulta += ",`Password` = '" + persona.getPassword() + "'";
        }
        if (persona.getCurso() != null) {
            consulta += ",`Curso` = '" + persona.getCurso().getCodigo() + "'";
        } else {
            consulta += ",`Curso` = NULL";
        }
        consulta += " WHERE DNI='" + persona.getDNI() + "'";
        return consulta;
    }

    public static String deletePersona(String DNI) {
        return "DELETE FROM " + Constantes.T_PERSONAS + " WHERE DNI='" + DNI + "'";
    }

    public static String insertPersonaAsignatura(Persona persona, Asignatura asignatura) {
        return "INSERT INTO " + Constantes.T_PERSONAS_ASIGNATURAS
                + " (RPersona,RAsignatura)"
                + " VALUES ('" + persona.getDNI() + "','" + asignatura.getCodigo() + "');";
    }

    public static String deletePersonaAsignaturas(Persona persona) {
        return "DELETE FROM " + Constantes.T_PERSONAS_ASIGNATURAS + " WHERE RPersona='" + persona.getDNI() + "';";
    }

    public static String ModificarDatoPersona(String DNI, String Campo, String Valor) {
        return "UPDATE " + Constantes.T_PERSONAS + " SET `" + Campo + "` = '" + Valor + "' WHERE DNI = '" + DNI + "'";
    }

    /////////////////////////////////
    // CURSOS
    ////////////////////////////////
    public static String getCursos = "SELECT * FROM `" + Constantes.T_CURSOS + "`";

    public static String getCurso(String codigo) {
        return getCursos + " WHERE codigo = '" + codigo + "'";
    }

    /////////////////////////////////
    // ASIGNATURAS
    ////////////////////////////////
    public static String getAsignaturas = "SELECT * FROM `" + Constantes.T_ASIGNATURAS + "`";

    public static String getAsignatura(String codigo) {
        return getAsignaturas + " WHERE codigo = '" + codigo + "'";
    }

    public static String getPersonaAsignaturas(String dni) {
        return "SELECT a.Codigo,a.Nombre "
                + "FROM PersonasAsignaturas pa "
                + "RIGHT JOIN Asignaturas a ON a.Codigo=pa.RAsignatura "
                + "WHERE pa.RPersona = '" + dni + "'";
    }

    public static String actualizarPerfilPersona(Persona p) {
        return "UPDATE " + Constantes.T_PERSONAS + " SET "
                + "Username='" + p.getUsername() + "',"
                + "Avatar='" + p.getAvatar() + "' "
                + "WHERE DNI = '" + p.getDNI() + "';";
    }

}
