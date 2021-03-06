package POJO;
// Generated 06-mar-2019 15:50:20 by Hibernate Tools 4.3.1


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * CompraBackup generated by hbm2java
 */
public class CompraBackup  implements java.io.Serializable {


     private int id;
     private Tarjeta tarjeta;
     private ViajeBackup viajeBackup;
     private Date fechaPago;
     private float importe;
     private int numeroViajeros;
     private String localizador;
     private Set ocupacionBackups = new HashSet(0);

    public CompraBackup() {
    }
    
    public CompraBackup(Compra compra) {
       this.id = compra.getId();
//       this.viajeBackup = compra.getViaje().getId();
//       this.idTarjeta = compra.getTarjeta().getId();
       this.fechaPago = compra.getFechaPago();
       this.importe = compra.getImporte();
       this.numeroViajeros = compra.getNumeroViajeros();
       this.localizador = compra.getLocalizador();
    }

	
    public CompraBackup(int id, Tarjeta tarjeta, ViajeBackup viajeBackup, Date fechaPago, float importe, int numeroViajeros, String localizador) {
        this.id = id;
        this.tarjeta = tarjeta;
        this.viajeBackup = viajeBackup;
        this.fechaPago = fechaPago;
        this.importe = importe;
        this.numeroViajeros = numeroViajeros;
        this.localizador = localizador;
    }
    public CompraBackup(int id, Tarjeta tarjeta, ViajeBackup viajeBackup, Date fechaPago, float importe, int numeroViajeros, String localizador, Set ocupacionBackups) {
       this.id = id;
       this.tarjeta = tarjeta;
       this.viajeBackup = viajeBackup;
       this.fechaPago = fechaPago;
       this.importe = importe;
       this.numeroViajeros = numeroViajeros;
       this.localizador = localizador;
       this.ocupacionBackups = ocupacionBackups;
    }
   
    public int getId() {
        return this.id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    public Tarjeta getTarjeta() {
        return this.tarjeta;
    }
    
    public void setTarjeta(Tarjeta tarjeta) {
        this.tarjeta = tarjeta;
    }
    public ViajeBackup getViajeBackup() {
        return this.viajeBackup;
    }
    
    public void setViajeBackup(ViajeBackup viajeBackup) {
        this.viajeBackup = viajeBackup;
    }
    public Date getFechaPago() {
        return this.fechaPago;
    }
    
    public void setFechaPago(Date fechaPago) {
        this.fechaPago = fechaPago;
    }
    public float getImporte() {
        return this.importe;
    }
    
    public void setImporte(float importe) {
        this.importe = importe;
    }
    public int getNumeroViajeros() {
        return this.numeroViajeros;
    }
    
    public void setNumeroViajeros(int numeroViajeros) {
        this.numeroViajeros = numeroViajeros;
    }
    public String getLocalizador() {
        return this.localizador;
    }
    
    public void setLocalizador(String localizador) {
        this.localizador = localizador;
    }
    public Set getOcupacionBackups() {
        return this.ocupacionBackups;
    }
    
    public void setOcupacionBackups(Set ocupacionBackups) {
        this.ocupacionBackups = ocupacionBackups;
    }




}


