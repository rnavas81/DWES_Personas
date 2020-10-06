package Modelo;

import java.util.LinkedList;
/**
 *
 * @author rodrigo
 * @var tipo 0 => usuario ; 1 => administrador
 * @var genero 0 => masculino; 1 => femenino
 */
public class Persona {

    private String nombre;
    private String DNI;
    private String apellidos;
    private String email;
    private int tipo;
    private int edad;
    private int genero;
    private String fecha;
    private LinkedList<Asignatura> asignaturas;
    private Curso curso;
    private String password;
    private String telefono;
    private int PJugadas;
    private int PGanadas;
    private String token;

    public Persona() {
        this.DNI = "";
        this.nombre = "";
        this.apellidos = "";
        this.email = "";
        this.tipo = 0;
        this.edad = 0;
        this.genero = 0;
        this.fecha = "";
        this.asignaturas = new LinkedList<>();
        this.curso = new Curso();
        this.password = "";
        this.telefono = "";
        this.token = "";
    }

    public Persona(String DNI, String nombre, String apellidos, String email, String tfno, int tipo, int edad, int genero, String fecha, Curso c, int PJugadas, int PGanadas) {
        this.DNI = DNI;
        this.nombre = nombre!=null?nombre:"";
        this.apellidos = apellidos!=null?apellidos:"";
        this.email = email;
        this.tipo = tipo;
        this.edad = edad;
        this.genero = genero;
        this.fecha = fecha;
        this.curso = c;
        this.PJugadas = PJugadas;
        this.PGanadas = PGanadas;
        this.asignaturas = new LinkedList<>();
    }
    public Persona(String DNI, String nombre, String apellidos, String email, String tfno, int tipo, int edad, int genero, String fecha, Curso c,LinkedList asignaturas) {
        this.DNI = DNI;
        this.nombre = nombre!=null?nombre:"";
        this.apellidos = apellidos!=null?apellidos:"";
        this.email = email;
        this.tipo = tipo;
        this.edad = edad;
        this.genero = genero;
        this.fecha = fecha;
        this.curso = c;
        this.PJugadas = 0;
        this.PGanadas = 0;
        this.asignaturas = asignaturas;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public int getEdad() {
        return edad;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public int getGenero() {
        return genero;
    }

    public void setGenero(int genero) {
        this.genero = genero;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public LinkedList<Asignatura> getAsignaturas() {
        return asignaturas;
    }

    public void setAsignaturas(LinkedList asignaturas) {
        this.asignaturas = asignaturas;
    }

    public Curso getCurso() {
        return curso;
    }

    public void setCurso(Curso curso) {
        this.curso = curso;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

    public String getDNI() {
        return DNI;
    }

    public void setDNI(String DNI) {
        this.DNI = DNI;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public int getPJugadas() {
        return PJugadas;
    }

    public void setPJugadas(int PJugadas) {
        this.PJugadas = PJugadas;
    }

    public int getPGanadas() {
        return PGanadas;
    }

    public void setPGanadas(int PGanadas) {
        this.PGanadas = PGanadas;
    }

    public void addPartida() {
        this.PJugadas++;
        ConexionEstatica.addPartida(this.DNI,this.PJugadas);
    }

    public void addGanada() {
        this.PGanadas++;
        ConexionEstatica.addPartidaGanada(this.DNI,this.PGanadas);
    }

    @Override
    public String toString() {
        return this.nombre + " " + this.apellidos + " " + this.email + " " + this.password + " " + this.tipo;
    }

    public String getAsignaturasString() {
        String response = "";
        for (Asignatura asignatura : asignaturas) {
            response += asignatura + ",";
        }
        if (response.length() > 0) {
            response = response.substring(0, response.length() - 1);
        }
        return response;
    }

    public boolean isAsignatura(String codigo) {
        for (Asignatura asignatura : asignaturas) {
            if (asignatura.getCodigo().equals(codigo)) {
                return true;
            }
        }
        return false;
    }

}
