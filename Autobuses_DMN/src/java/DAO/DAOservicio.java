/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Modelo.Viajes;
import POJO.Estacion;
import POJO.Viaje;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 * @author diego
 */
public class DAOservicio {

    public ArrayList<Viajes> getViajes(SessionFactory _SessionBuilder) {

        Session sesion = _SessionBuilder.openSession();
        
        ArrayList<Viajes> viajesModelo = new ArrayList();
        
        sesion.flush();
        String ordenHQL = "FROM Viaje";
        Query q = sesion.createQuery(ordenHQL);

        List<Viaje> viajes = q.list();

        for (Viaje viaje : viajes) {
            Hibernate.initialize(viaje.getHorario());
            Hibernate.initialize(viaje.getHorario().getRuta());
            Hibernate.initialize(viaje.getHorario().getRuta().getEstacionByEstacionOrigen());
            Hibernate.initialize(viaje.getHorario().getRuta().getEstacionByEstacionDestino());
            Hibernate.initialize(viaje.getHorario().getRuta().getEstacionByEstacionDestino());
            
            Viajes viajeModelo = new Viajes(viaje.getHorario().getRuta().getEstacionByEstacionOrigen().getNombreEstacion(), viaje.getHorario().getRuta().getEstacionByEstacionDestino().getNombreEstacion(), viaje.getFecha().toString(), viaje.getHorario().getHoraSalida().toString(), String.valueOf(viaje.getPlazasDisponibles()));
           
            viajesModelo.add(viajeModelo);
        }
        
        
        sesion.close();

        return viajesModelo;

    }


}
