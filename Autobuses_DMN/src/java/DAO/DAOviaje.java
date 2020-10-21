/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJO.Compra;
import POJO.Ocupacion;
import POJO.Viaje;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 * @author diego
 */
public class DAOviaje {

        public List<Viaje> viajesPorFecha(String fecha, SessionFactory _SessionBuilder) {

            Session sesion = _SessionBuilder.openSession();

            String ordenHQL = "FROM Viaje v WHERE v.fecha =:fecha ORDER BY v.horario.horaSalida ASC";
            Query q = sesion.createQuery(ordenHQL);

            q.setParameter("fecha", fecha);

            List<Viaje> viajePorFecha = q.list();

            ArrayList array = new ArrayList();

            for (Viaje viaje : viajePorFecha) {
                ArrayList arrayViaje = new ArrayList();
                Hibernate.initialize(viaje.getHorario());
                Hibernate.initialize(viaje.getHorario().getRuta());
                Hibernate.initialize(viaje.getHorario().getRuta().getEstacionByEstacionOrigen());
                Hibernate.initialize(viaje.getHorario().getRuta().getEstacionByEstacionDestino());
                Hibernate.initialize(viaje.getCompras());
                arrayViaje.add(viaje);
                for (Compra compra : (Set<Compra>) viaje.getCompras()) {
                    Hibernate.initialize(compra.getOcupacions());
                    Hibernate.initialize(compra.getTarjeta());
                    Hibernate.initialize(compra.getTarjeta().getCompras());

                    for (Ocupacion ocupacion : (Set<Ocupacion>) compra.getOcupacions()) {
                        Hibernate.initialize(ocupacion.getViajero());
                        Hibernate.initialize(ocupacion.getViajero().getOcupacions());
                        arrayViaje.add(ocupacion);
                    }
                }
                array.add(arrayViaje);
                }
            sesion.close();

            return viajePorFecha;

        }
    
    

}
