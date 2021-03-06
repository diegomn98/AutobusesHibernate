package POJO;
// Generated 06-mar-2019 15:50:20 by Hibernate Tools 4.3.1


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * ViajeBackup generated by hbm2java
 */
public class ViajeBackup  implements java.io.Serializable {


     private int id;
     private Horario horario;
     private Date fecha;
     private int plazasLibres;
     private Set compraBackups = new HashSet(0);

    public ViajeBackup() {
    }

    public ViajeBackup(Viaje viaje){
        this.id = viaje.getId();
       // this.idHorario = viaje.getHorario().getId();
        this.fecha = viaje.getFecha();
        this.plazasLibres= viaje.getPlazasDisponibles();
    }
	
    public ViajeBackup(int id, Horario horario, Date fecha, int plazasLibres) {
        this.id = id;
        this.horario = horario;
        this.fecha = fecha;
        this.plazasLibres = plazasLibres;
    }
    public ViajeBackup(int id, Horario horario, Date fecha, int plazasLibres, Set compraBackups) {
       this.id = id;
       this.horario = horario;
       this.fecha = fecha;
       this.plazasLibres = plazasLibres;
       this.compraBackups = compraBackups;
    }
   
    public int getId() {
        return this.id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    public Horario getHorario() {
        return this.horario;
    }
    
    public void setHorario(Horario horario) {
        this.horario = horario;
    }
    public Date getFecha() {
        return this.fecha;
    }
    
    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
    public int getPlazasLibres() {
        return this.plazasLibres;
    }
    
    public void setPlazasLibres(int plazasLibres) {
        this.plazasLibres = plazasLibres;
    }
    public Set getCompraBackups() {
        return this.compraBackups;
    }
    
    public void setCompraBackups(Set compraBackups) {
        this.compraBackups = compraBackups;
    }




}


