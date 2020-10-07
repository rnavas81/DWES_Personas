package Modelo;

import java.util.LinkedList;
/**
 *
 * @author rodrigo
 * @var tipo 0 => usuario ; 1 => administrador
 * @var genero 0 => masculino; 1 => femenino
 */
public class Persona {

    private String DNI = "";
    private String nombre = "";
    private String apellidos = "";
    private String email = "";
    private int tipo = 0;
    private int edad = 0;
    private int genero = 0;
    private String fecha = "";
    private LinkedList<Asignatura> asignaturas = new LinkedList<>();
    private Curso curso = null;
    private String password = "";
    private String telefono = "";
    private int PJugadas = 0;
    private int PGanadas = 0;
    private String avatar = "";
    private String username = "";
    private String token = "";
    
    public Persona() {
    }

    public Persona(String DNI, String nombre, String apellidos, String email, String tfno, int tipo, int edad, int genero, String fecha, Curso c, int PJugadas, int PGanadas,String username,String avatar) {
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
        this.avatar = avatar;
        this.username = username;
    }

    public Persona(String DNI, String nombre, String apellidos, String email, String tfno, int tipo, int edad, int genero, String fecha, Curso c, LinkedList<Asignatura> asignaturas, int PJugadas, int PGanadas) {
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
        this.asignaturas = asignaturas;
    }
    public Persona(String DNI, String nombre, String apellidos, String email, String tfno, int tipo, int edad, int genero, String fecha, Curso c,LinkedList<Asignatura> asignaturas) {
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

    public void setAsignaturas(LinkedList<Asignatura> asignaturas) {
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

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
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
