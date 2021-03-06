package Modelo;

import Auxiliar.Constantes;
import Auxiliar.Consultas;
import java.sql.*;
import java.util.HashMap;
import java.util.LinkedList;
import javax.swing.JOptionPane;

public class ConexionEstatica {

    //********************* Atributos *************************
    private static java.sql.Connection Conex;
    //Atributo a través del cual hacemos la conexión física.
    private static java.sql.Statement Sentencia_SQL;
    //Atributo que nos permite ejecutar una sentencia SQL
    private static java.sql.ResultSet Conj_Registros;

    public static void abrirBD() {
        try {
            //Cargar el driver/controlador
            //String controlador = "com.mysql.jdbc.Driver";
            //String controlador = "com.mysql.cj.jdbc.Driver";
            //String controlador = "oracle.jdbc.driver.OracleDriver";
            //String controlador = "sun.jdbc.odbc.JdbcOdbcDriver"; 
            String controlador = "org.mariadb.jdbc.Driver"; // MariaDB la version libre de MySQL (requiere incluir la librería jar correspondiente).
            //Class.forName("org.mariadb.jdbc.Driver");              
            //Class.forName(controlador).newInstance();
            Class.forName(controlador);
            //Class.forName("com.mysql.jdbc.Driver"); 

            //String URL_BD = "jdbc:mysql://localhost:3306/" + Constantes.BBDD;
            //String URL_BD = "jdbc:mariadb://"+"localhost:3306"+"/"+Constantes.BBDD;
            //String URL_BD = "jdbc:oracle:oci:@REPASO";
            //String URL_BD = "jdbc:oracle:oci:@REPASO";
            //String URL_BD = "jdbc:odbc:REPASO";
            //String connectionString = "jdbc:mysql://localhost:3306/" + Constantes.BBDD + "?user=" + Constantes.usuario + "&password=" + Constantes.password + "&useUnicode=true&characterEncoding=UTF-8";
            //Realizamos la conexión a una BD con un usuario y una clave.
            //Conex = java.sql.DriverManager.getConnection(connectionString);
            //Conex = java.sql.DriverManager.getConnection(URL_BD, Constantes.usuario, Constantes.password);
            Conex = DriverManager.getConnection(
                    "jdbc:mariadb://localhost:3306/" + Constantes.BBDD, Constantes.usuario, Constantes.password);
            Sentencia_SQL = Conex.createStatement();
            System.out.println("Conexion realizada con éxito");
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Exception: " + e.getMessage());
        }
    }

    public static void cerrarBD() {
        try {
            // resultado.close();
            Conex.close();
            System.out.println("Desconectado de la Base de Datos"); // Opcional para seguridad
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "Error de Desconexion", JOptionPane.ERROR_MESSAGE);
        }
    }
    private static Persona recogerDatosPersona() {
        Persona p = null;
        try {
            Curso c = new Curso(Conj_Registros.getString("Codigo"), Conj_Registros.getString("Nombre"));
            p = new Persona(
                Conj_Registros.getString("DNI"),
                Conj_Registros.getString("Nombre")!=null?Conj_Registros.getString("Nombre"):"",
                Conj_Registros.getString("Apellidos")!=null?Conj_Registros.getString("Apellidos"):"",
                Conj_Registros.getString("Email")!=null?Conj_Registros.getString("Email"):"",
                Conj_Registros.getString("Tfno")!=null?Conj_Registros.getString("Tfno"):"",
                Conj_Registros.getInt("Tipo"),
                Conj_Registros.getInt("Edad"),
                Conj_Registros.getInt("Genero"),
                Conj_Registros.getString("Fecha"),
                c,
                Conj_Registros.getInt("PJugadas"),
                Conj_Registros.getInt("PGanadas"),
                Conj_Registros.getString("Username"),
                Conj_Registros.getString("Avatar")                    
            );
            
        } catch (SQLException e) {
        }
        return p;
    }
    private static LinkedList<Asignatura> recogerAsignaturasPersona(Persona p){
        LinkedList<Asignatura> asignaturas = new LinkedList<>();
        try {
            ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(Consultas.getPersonaAsignaturas(p.getDNI()));
            while (ConexionEstatica.Conj_Registros.next())//Si devuelve true es que existe.
            {
                String codigo = Conj_Registros.getString("Codigo");
                String nombre = Conj_Registros.getString("Nombre");
                asignaturas.add(new Asignatura(codigo,nombre));
                
            }
        } catch (SQLException ex) {
            System.out.println("Error en el acceso a la BD.");
        }
        return asignaturas;
        
    }
    public static Persona existeUsuario(String dni) {
        Persona existe = null;
        abrirBD();
        try {
            ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(Consultas.getPersona(dni));
            if (ConexionEstatica.Conj_Registros.next())//Si devuelve true es que existe.
            {
                existe = recogerDatosPersona();
                existe.setAsignaturas(recogerAsignaturasPersona(existe));
            }
        } catch (SQLException ex) {
            System.out.println("Error en el acceso a la BD.");
            existe = null;
        } finally {
            cerrarBD();
        }
        return existe;//Si devolvemos null el usuario no existe.
    }

    /**
     * Comprueba si un usuario puede acceder al sistema
     *
     * @param dni
     * @param password
     * @return Persona o null
     */
    public static Persona accederUsuario(String dni, String password) {
        Persona existe = null;
        abrirBD();
        try {
            ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(Consultas.testPersona(dni, password));
            if (ConexionEstatica.Conj_Registros.next())//Si devuelve true es que existe.
            {
                existe = recogerDatosPersona();
                existe.setAsignaturas(recogerAsignaturasPersona(existe));
            }
        } catch (SQLException ex) {
            System.out.println("Error en el acceso a la BD.");
            existe = null;
        } finally {
            cerrarBD();
        }
        return existe;//Si devolvemos null el usuario no existe.

    }

    /**
     * Usando una LinkedList.
     *
     * @return
     */
    public static LinkedList<Persona> obtenerPersonas() {
        LinkedList<Persona> personasBD = new LinkedList<>();
        Persona p;
        abrirBD();
        try {
            ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(Consultas.getPersonas());
            while (Conj_Registros.next()) {
                p = recogerDatosPersona();
                personasBD.add(p);
            }
            for (Persona persona : personasBD) {
                persona.setAsignaturas(recogerAsignaturasPersona(persona));
            }
        } catch (SQLException ex) {
            System.out.println("ObtenerPersonas[ERROR] = " + ex.getMessage());
            personasBD = new LinkedList<>();
        } finally {
            cerrarBD();
        }
        return personasBD;
    }

    /**
     * Usando una tabla Hash.
     *
     * @return
     */
    public static HashMap<String, Persona> obtenerPersonas2() {
        HashMap<String, Persona> personas = new HashMap<>();
        Persona p;
        abrirBD();
        try {
            ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(Consultas.getPersonas());
            while (Conj_Registros.next()) {
                p = recogerDatosPersona();
                personas.put(p.getDNI(), p);
            }
            for (String dni : personas.keySet()) {
                personas.get(dni).setAsignaturas(recogerAsignaturasPersona(personas.get(dni)));
            }
        } catch (SQLException ex) {
            System.out.println("ObtenerPersonas2[ERROR] = " + ex.getMessage());
            personas = new HashMap<>();
        } finally {
            cerrarBD();
        }
        return personas;
    }

    public static boolean eliminarPersona(String DNI) {
        boolean hecho = false;
        abrirBD();
        try {
            ConexionEstatica.Sentencia_SQL.executeUpdate(Consultas.deletePersona(DNI));
        } catch (SQLException e) {
            System.out.println("EliminarPersona[ERROR] = " + e.getMessage());
            hecho = false;
        } finally {
            cerrarBD();
        }
        return hecho;
    }

    /**
     * Comprueba si existe una entrada con el mismo DNI. Si no existe agrega una
     * entrada con la persona
     *
     * @param persona
     * @return
     */
    public static boolean agregarPersona(Persona persona) {
        boolean hecho = false;
        try {
            if (existeUsuario(persona.getDNI()) == null) {
                abrirBD();
                ConexionEstatica.Sentencia_SQL.executeUpdate(Consultas.insertPersona(persona));
                for (Asignatura asignatura : persona.getAsignaturas()) {
                    ConexionEstatica.Sentencia_SQL.executeUpdate(Consultas.insertPersonaAsignatura(persona, asignatura));
                }
                hecho = true;
            }
        } catch (SQLException e) {
            System.out.println("AgregarPersona[Error] = " + e.getMessage());
            hecho = false;
        } finally {
            cerrarBD();
        }

        return hecho;
    }
    /**
     * Comprueba si existe una entrada con el mismo DNI. Si no existe agrega una
     * entrada con la persona
     *
     * @param persona
     * @return
     */
    public static boolean editarPersona(Persona persona) {
        boolean hecho = false;
        try {
            if (existeUsuario(persona.getDNI()) != null) {
                abrirBD();
                ConexionEstatica.Sentencia_SQL.executeUpdate(Consultas.updatePersona(persona));
                ConexionEstatica.Sentencia_SQL.executeUpdate(Consultas.deletePersonaAsignaturas(persona));
                for (Asignatura asignatura : persona.getAsignaturas()) {
                    ConexionEstatica.Sentencia_SQL.executeUpdate(Consultas.insertPersonaAsignatura(persona, asignatura));
                    
                }
                
                hecho = true;
            }
        } catch (SQLException e) {
            System.out.println("EditarPersona[Error] = " + e.getMessage());
            hecho = false;
        } finally {
            if(hecho)cerrarBD();
        }

        return hecho;
    }
    public static void editarPerfil(Persona p){
        try {
            if (existeUsuario(p.getDNI()) != null) {
                abrirBD();
                ConexionEstatica.Sentencia_SQL.executeUpdate(Consultas.actualizarPerfilPersona(p));
            }
        } catch (SQLException e) {
            System.out.println("editarPerfil[Error] = " + e.getMessage());
        } finally {
            cerrarBD();
        }
        
    }

    public static void addPartida(String DNI, int PJugadas) {
        try {
            if (existeUsuario(DNI) != null) {
                abrirBD();
                ConexionEstatica.Sentencia_SQL.executeUpdate(Consultas.ModificarDatoPersona(DNI, "PJugadas", String.valueOf(PJugadas)));
            }
        } catch (SQLException e) {
            System.out.println("addPartida[Error] = " + e.getMessage());
        } finally {
            cerrarBD();
        }
    }

    public static void addPartidaGanada(String DNI, int PGanadas) {
        try {
            if (existeUsuario(DNI) != null) {
                abrirBD();
                ConexionEstatica.Sentencia_SQL.executeUpdate(Consultas.ModificarDatoPersona(DNI, "PGanadas", String.valueOf(PGanadas)));
            }
        } catch (SQLException e) {
            System.out.println("addPartidaGanada[Error] = " + e.getMessage());
        } finally {
            cerrarBD();
        }
    }
    public static void setPassword(Persona p){
        try {
            if (existeUsuario(p.getDNI()) != null) {
                abrirBD();
                ConexionEstatica.Sentencia_SQL.executeUpdate(Consultas.ModificarDatoPersona(p.getDNI(), "Password", p.getPassword()));
            }
        } catch (SQLException e) {
            System.out.println("setPassword[Error] = " + e.getMessage());
        } finally {
            cerrarBD();
        }
        
    }

    //----------------------------------------------------------
    public void Modificar_Dato(String tabla, String DNI, String Campo, String Valor) throws SQLException {
        String Sentencia = "UPDATE " + tabla + " SET `" + Campo + "` = '" + Valor + "' WHERE DNI = '" + DNI + "'";
        ConexionEstatica.Sentencia_SQL.executeUpdate(Sentencia);
    }

    //----------------------------------------------------------
    public void Insertar_Dato(String tabla, String DNI, String Nombre, int Tfno) throws SQLException {
        String Sentencia = "INSERT INTO " + tabla + " VALUES ('" + DNI + "'," + "'" + Nombre + "','" + Tfno + "')";
        ConexionEstatica.Sentencia_SQL.executeUpdate(Sentencia);
    }

    //----------------------------------------------------------
    public void Borrar_Dato(String tabla, String DNI) throws SQLException {
        String Sentencia = "DELETE FROM " + tabla + " WHERE DNI = '" + DNI + "'";
        ConexionEstatica.Sentencia_SQL.executeUpdate(Sentencia);
    }

    //CURSOS
    public static LinkedList<Curso> getCursos() {
        LinkedList<Curso> cosasBD = new LinkedList<>();
        Curso item;
        abrirBD();
        try {
            String sentencia = "SELECT * FROM " + Constantes.T_CURSOS;
            ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                item = new Curso(
                        Conj_Registros.getString("codigo"),
                        Conj_Registros.getString("nombre")
                );

                cosasBD.push(item);
            }

        } catch (SQLException e) {
            System.out.println("GetCursos[ERROR] = " + e.getMessage());
            cosasBD = new LinkedList<>();
        } finally {
            cerrarBD();
        }
        return cosasBD;
    }

    //ASIGNATURAS
    public static LinkedList<Asignatura> getAsignaturas() {
        LinkedList<Asignatura> cosasBD = new LinkedList<>();
        Asignatura item;
        abrirBD();
        try {
            String sentencia = "SELECT * FROM " + Constantes.T_ASIGNATURAS;
            ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                item = new Asignatura(
                        Conj_Registros.getString("codigo"),
                        Conj_Registros.getString("nombre")
                );

                cosasBD.push(item);
            }

        } catch (SQLException e) {
            System.out.println("GetAsignaturas[ERROR] = " + e.getMessage());
            cosasBD = new LinkedList<>();
        } finally {
            cerrarBD();
        }
        return cosasBD;
    }
}
