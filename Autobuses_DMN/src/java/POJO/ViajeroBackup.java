package POJO;
// Generated 06-mar-2019 15:50:20 by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * ViajeroBackup generated by hbm2java
 */
public class ViajeroBackup  implements java.io.Serializable {


     private int id;
     private String numeroIdentificacion;
     private String nombre;
     private String apellidos;
     private Set ocupacionBackups = new HashSet(0);

    public ViajeroBackup() {
    }
    
    public ViajeroBackup(Viajero viajero) {
        this.id = viajero.getId();
        this.numeroIdentificacion = viajero.getNumeroIdentificacion();
        this.nombre = viajero.getNombre();
        this.apellidos = viajero.getApellidos();
    }

	
    public ViajeroBackup(int id, String numeroIdentificacion, String nombre, String apellidos) {
        this.id = id;
        this.numeroIdentificacion = numeroIdentificacion;
        this.nombre = nombre;
        this.apellidos = apellidos;
    }
    public ViajeroBackup(int id, String numeroIdentificacion, String nombre, String apellidos, Set ocupacionBackups) {
       this.id = id;
       this.numeroIdentificacion = numeroIdentificacion;
       this.nombre = nombre;
       this.apellidos = apellidos;
       this.ocupacionBackups = ocupacionBackups;
    }
   
    public int getId() {
        return this.id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    public String getNumeroIdentificacion() {
        return this.numeroIdentificacion;
    }
    
    public void setNumeroIdentificacion(String numeroIdentificacion) {
        this.numeroIdentificacion = numeroIdentificacion;
    }
    public String getNombre() {
        return this.nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public String getApellidos() {
        return this.apellidos;
    }
    
    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }
    public Set getOcupacionBackups() {
        return this.ocupacionBackups;
    }
    
    public void setOcupacionBackups(Set ocupacionBackups) {
        this.ocupacionBackups = ocupacionBackups;
    }




}


