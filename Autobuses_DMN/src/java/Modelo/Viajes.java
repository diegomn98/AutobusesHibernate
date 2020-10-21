/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

/**
 *
 * @author diego
 */
public class Viajes {
    
    private String origen;
    private String destino;
    private String fecha;
    private String horaSalida;
    private String plazasDisponibles;

    public Viajes(String origen, String destino, String fecha, String horaSalida, String plazasDisponibles) {
        this.origen = origen;
        this.destino = destino;
        this.fecha = fecha;
        this.horaSalida = horaSalida;
        this.plazasDisponibles = plazasDisponibles;
    }

    public void setOrigen(String origen) {
        this.origen = origen;
    }

    public void setDestino(String destino) {
        this.destino = destino;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public void setHoraSalida(String horaSalida) {
        this.horaSalida = horaSalida;
    }

    public void setPlazasDisponibles(String plazasDisponibles) {
        this.plazasDisponibles = plazasDisponibles;
    }

    public String getOrigen() {
        return origen;
    }

    public String getDestino() {
        return destino;
    }

    public String getFecha() {
        return fecha;
    }

    public String getHoraSalida() {
        return horaSalida;
    }

    public String getPlazasDisponibles() {
        return plazasDisponibles;
    }
    
    
    
}
