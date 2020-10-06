/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import Auxiliar.Constantes;
import java.util.Arrays;

/**
 *
 * @author rodrigo
 *
 * Juego del buscaminas
 *
 * @param tablero = Lo que ve el usuario 0 => el usuario no ha descubierto 1 =>
 * el usuario si ha descubierto
 * @param solucion = posición de las minas -1 => mina número de minas en
 * contacto
 * @param minas = número de minas
 * @param size = tamaño del tablero
 *
 */
public class Buscaminas {

    private int[] tablero;
    private int[] solucion;
    private int minas;
    private int size;

    public Buscaminas(int size, int minas) {
        this.tablero = new int[size];
        this.solucion = new int[size];
        this.minas = minas;
        this.size = size;
    }
    public int[] getTablero() {
        return tablero;
    }

    public int[] getSolucion() {
        return solucion;
    }

    public int getMinas() {
        return minas;
    }

    public int getSize() {
        return size;
    }

    public void iniciar() {
        Arrays.fill(tablero, 0);
        Arrays.fill(solucion, 0);
        ponerMinas();
    }

    private void ponerMinas() {
        int puestas = 0;
        while (puestas < minas) {
            int i = (int) (Math.random() * solucion.length);
            if (solucion[i] == 0) {
                solucion[i] = -1;
                puestas += 1;
            }
        }
        for (int i = 0; i < solucion.length; i++) {
            if (solucion[i] == 0) {
                if (i > 0 && solucion[i - 1] == -1) {
                    solucion[i]++;
                }
                if (i < (solucion.length - 1) && solucion[i + 1] == -1) {
                    solucion[i]++;
                }
            }
        }
    }

    public String pintar() {
        //String cadena = "<form action=\""+Constantes.V_BUSCAMINAS_JUEGO+"\">";
        String cadena = "<fieldset class=\"tablero\">"
                + "<legend>Buscaminas</legend>";
        for (int i = 0; i < tablero.length; i++) {
            if (tablero[i] == 0) {
                cadena+="<a href=\""+Constantes.V_BUSCAMINAS_JUEGO+"?posicion="+i+"\">?</a>";
                //cadena+="<input type=\"submit\" name=\""+i+"\" value=\"?\" />";
            } else {
                if(solucion[i]==-1){
                    cadena+="<p class=\"boton\">*</p>";   
                } else {
                    cadena+="<p class=\"boton\">"+solucion[i]+"</p>";
                }
            }

        }
        cadena+="</fieldset>";
        return cadena;
    }
    public int comprobarPosicion(int p){
        int estado = 0;
        if(p>=0 && p<size){
            tablero[p]=1;            
            if(solucion[p]==-1){
                estado=-1;
                Arrays.fill(tablero, 1);
            } else {
                estado = comprobarTablero();
                if(estado==1)Arrays.fill(tablero, 1);
            }
        }
        return estado;
    }
    /**
     * Comprueba si lo que queda en el tablero por descubrir son solo minas
     * @return 1 solo quedan minas por descubrir, 0 si no
     */
    public int comprobarTablero(){
        boolean soloMinas = true;
        for (int i = 0; i < tablero.length; i++) {
            if(tablero[i]==0 && solucion[i]!=-1){
                soloMinas = false;
                break;
            }
        }
        return soloMinas?1:0;
    }
    public void rendirse(){
        Arrays.fill(tablero, 1);
    }
}
