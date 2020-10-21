
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJO.Compra;
import POJO.Estacion;
import POJO.Ocupacion;
import POJO.Ruta;
import POJO.Tarjeta;
import POJO.Viaje;
import POJO.Viajero;
import POJO.ViajeroBackup;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author diego
 */
public class DAOrutas {

    public List getEstacionOrigen(SessionFactory _SessionBuilder) {
        Session sesion = _SessionBuilder.openSession();

        String ordenHQL = "FROM Estacion e WHERE e IN(SELECT r.estacionByEstacionOrigen from Ruta r)";
        Query q = sesion.createQuery(ordenHQL);

        List<Estacion> origenes = q.list();

        sesion.close();

        return origenes;
    }

    public List getEstacionDestino(int idOrigen, SessionFactory _SessionBuilder) {

        Session sesion = _SessionBuilder.openSession();

        String ordenHQL = "FROM Estacion e WHERE e IN(SELECT r.estacionByEstacionDestino from Ruta r WHERE r.estacionByEstacionOrigen.id =:idOrigen)";
        Query q = sesion.createQuery(ordenHQL);
        q.setParameter("idOrigen", idOrigen);

        List<Estacion> destino = q.list();

        sesion.close();

        return destino;

    }

    public List getRutasDia(LocalDate fecha, int idOrigen, int idDestino, int plazas, SessionFactory _SessionBuilder) {

        Session sesion = _SessionBuilder.openSession();

        String ordenHQL = "FROM Viaje v WHERE v.fecha =:fecha AND v.horario.ruta.estacionByEstacionOrigen.id =:idOrigen AND v.horario.ruta.estacionByEstacionDestino.id =:idDestino AND v.plazasDisponibles >=:plazas";
        Query q = sesion.createQuery(ordenHQL);
        q.setParameter("fecha", fecha.toString());
        q.setParameter("idOrigen", idOrigen);
        q.setParameter("idDestino", idDestino);
        q.setParameter("plazas", plazas);

        List<Viaje> viajesDia = q.list();

        for (Viaje viaje : viajesDia) {
            Hibernate.initialize(viaje.getHorario());
            Hibernate.initialize(viaje.getHorario().getRuta());
            Hibernate.initialize(viaje.getHorario().getRuta().getEstacionByEstacionOrigen());
            Hibernate.initialize(viaje.getHorario().getRuta().getEstacionByEstacionDestino());
        }

        sesion.close();

        return viajesDia;

    }

    public List getPlazasOcupadas(int idViaje, SessionFactory _SessionBuilder) {

        Session sesion = _SessionBuilder.openSession();

        String ordenHQL = "SELECT o.numeroAsiento FROM Ocupacion o WHERE o.compra.viaje.id =:idViaje";
        Query q = sesion.createQuery(ordenHQL);

        q.setParameter("idViaje", idViaje);

        List<Integer> ocupadas = q.list();

        sesion.close();

        return ocupadas;
    }
    
    public int getNumeroPlazasDisponibles(int idViaje, SessionFactory _SessionBuilder) {

        Session sesion = _SessionBuilder.openSession();

        String ordenHQL = "SELECT v.plazasDisponibles FROM Viaje v WHERE v.id =:idViaje";
        Query q = sesion.createQuery(ordenHQL);

        q.setParameter("idViaje", idViaje);

        List<Integer> disponibles = q.list();

        sesion.close();

        return disponibles.get(0).intValue();
    }

    public List getPlazasDisponibles(int idViaje, SessionFactory _SessionBuilder) {

        Session sesion = _SessionBuilder.openSession();

        List<Integer> plazasOcupadas = getPlazasOcupadas(idViaje, _SessionBuilder);
        int numeroPlazasDisponibles = getNumeroPlazasDisponibles(idViaje, _SessionBuilder);

        int totalPlazas = numeroPlazasDisponibles + plazasOcupadas.size();
        
        List plazasDisponibles = new ArrayList();
        
        for (int i = 1; i <= totalPlazas; i++) {
            plazasDisponibles.add(i);
        }


        plazasDisponibles.removeAll(plazasOcupadas);

        sesion.close();

        return plazasDisponibles;

    }

    public List getViajeEspecifico(int idViaje, SessionFactory _SessionBuilder) {

        Session sesion = _SessionBuilder.openSession();

        String ordenHQL = "FROM Viaje v WHERE v.id =:idViaje";
        Query q = sesion.createQuery(ordenHQL);

        q.setParameter("idViaje", idViaje);

        List<Viaje> viajeDesdeId = q.list();

        for (Viaje viaje : viajeDesdeId) {
            Hibernate.initialize(viaje.getHorario());
            Hibernate.initialize(viaje.getHorario().getRuta());
            Hibernate.initialize(viaje.getHorario().getRuta().getEstacionByEstacionOrigen());
            Hibernate.initialize(viaje.getHorario().getRuta().getEstacionByEstacionDestino());
            Hibernate.initialize(viaje.getCompras());
        }

        sesion.close();

        return viajeDesdeId;

    }

    public String generarLocalizador(SessionFactory _SessionBuilder) {

        Session sesion = _SessionBuilder.openSession();

        Compra compra = null;

        String localizador = "";

        do {

            ArrayList localizadores = new ArrayList();

            String caracteres = "abcdefghijkmnpqrtuvwxyzABCDEFGHJKMNPQRTUVWXYZ2346789";

            for (int i = 0; i < 8; i++) {
                localizador += caracteres.charAt((int) Math.floor(Math.random() * caracteres.length()));
            }

            String ordenHQL = "FROM Compra c WHERE c.localizador =:localizador";

            Query q = sesion.createQuery(ordenHQL);
            q.setParameter("localizador", localizador);

            compra = (Compra) q.uniqueResult();

        } while (compra != null);

        sesion.close();

        return localizador;
    }

    public String saveCompra(Compra compra, SessionFactory _SessionBuilder) {

        Session sesion = _SessionBuilder.openSession();
        Transaction Tx = null;
        try {

            Tx = sesion.beginTransaction();

            String clienteInsertado = "";

            sesion.saveOrUpdate(compra);

            Tx.commit();

            return "1";

        } catch (Exception e) {
            if (Tx != null) {
                Tx.rollback();
            }
            return e.getMessage();
        } finally {
            sesion.close();
        }

    }

    public Tarjeta getTarjetaDesdeId(int idTarjeta, int CVV, SessionFactory _SessionBuilder) {

        Session sesion = _SessionBuilder.openSession();

        Tarjeta tarjeta = null;

        String ordenHQL = "FROM Tarjeta t WHERE t.id =:idTarjeta AND t.cvv =:CVV";
        Query q = sesion.createQuery(ordenHQL);

        q.setParameter("idTarjeta", idTarjeta);
        q.setParameter("CVV", CVV);

        tarjeta = (Tarjeta) q.uniqueResult();

        Hibernate.initialize(tarjeta.getCompras());

        sesion.close();

        return tarjeta;
    }

    public int obtenerIdViajeroPorNif(String numeroIdentificacion, SessionFactory _SessionBuilder) {

        Session sesion = _SessionBuilder.openSession();
        
        String ordenHQL = "FROM Viajero v WHERE v.numeroIdentificacion =:numeroIdentificacion";
        Query q = sesion.createQuery(ordenHQL);

        q.setParameter("numeroIdentificacion", numeroIdentificacion);
        
        List<Viajero> viajeros = (List<Viajero>) q.list();
        
        int idViajero = 0;
        
        if(viajeros.size() > 0){
            idViajero = viajeros.get(0).getId();
        }
        
        sesion.close();

        return idViajero;

    }
    
    
    public int obtenerIdViajeroBackup(String numeroIdentificacion, SessionFactory _SessionBuilder) {

        Session sesion = _SessionBuilder.openSession();
        
        String ordenHQL = "FROM ViajeroBackup v WHERE v.numeroIdentificacion =:numeroIdentificacion";
        Query q = sesion.createQuery(ordenHQL);

        q.setParameter("numeroIdentificacion", numeroIdentificacion);
        
        List<ViajeroBackup> viajeros = (List<ViajeroBackup>) q.list();
        
        int idViajero = 0;
        
        if(viajeros.size() > 0){
            idViajero = viajeros.get(0).getId();
        }
        
        sesion.close();

        return idViajero;

    }
    

}
