/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJO.Administrador;
import POJO.Compra;
import DAO.DAOrutas;
import POJO.CompraBackup;
import POJO.Horario;
import POJO.Ocupacion;
import POJO.OcupacionBackup;
import POJO.Viaje;
import POJO.ViajeBackup;
import POJO.Viajero;
import POJO.ViajeroBackup;
import java.util.ArrayList;

import java.util.List;
import java.util.Set;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author diego
 */
public class DAOadministrador {

    public List inicioSesionAdministrador(String usuario, String password, SessionFactory _SessionBuilder) {

        Session sesion = _SessionBuilder.openSession();

        boolean estado = false;

        String ordenHQL = "FROM Administrador a WHERE a.nombre =:usuario AND a.password =:password";
        Query q = sesion.createQuery(ordenHQL);

        q.setParameter("usuario", usuario);
        q.setParameter("password", password);

        List<Administrador> datosAdministrador = q.list();

        sesion.close();

        return datosAdministrador;
    }

    public List getViajes(SessionFactory _SessionBuilder) {

        Session sesion = _SessionBuilder.openSession();
        sesion.flush();
        String ordenHQL = "FROM Viaje";
        Query q = sesion.createQuery(ordenHQL);
        q.setCacheable(false);
        List<Viaje> viajes = q.list();

        for (Viaje viaje : viajes) {
            Hibernate.initialize(viaje.getHorario());
            Hibernate.initialize(viaje.getCompras());
            Hibernate.initialize(viaje.getHorario().getRuta());
            Hibernate.initialize(viaje.getHorario().getRuta().getEstacionByEstacionOrigen());
            Hibernate.initialize(viaje.getHorario().getRuta().getEstacionByEstacionDestino());
        }

        sesion.close();

        return viajes;

    }

    public Viaje getViajePorId(int idViaje, SessionFactory _SessionBuilder) {

        Session sesion = _SessionBuilder.openSession();

        String ordenHQL = "FROM Viaje v WHERE v.id =:idViaje";
        Query q = sesion.createQuery(ordenHQL);

        q.setParameter("idViaje", idViaje);

        Viaje viaje = (Viaje) q.uniqueResult();

        if (viaje != null) {
            Hibernate.initialize(viaje.getCompras());
            Hibernate.initialize(viaje.getHorario());
            Hibernate.initialize(viaje.getHorario().getViajes());
            for (Compra compra : (Set<Compra>) viaje.getCompras()) {
                Hibernate.initialize(compra.getOcupacions());
                Hibernate.initialize(compra.getTarjeta());
                Hibernate.initialize(compra.getTarjeta().getCompras());
                for (Ocupacion ocupacion : (Set<Ocupacion>) compra.getOcupacions()) {
                    Hibernate.initialize(ocupacion.getViajero());
                    Hibernate.initialize(ocupacion.getViajero().getOcupacions());
                }
            }
        }

        sesion.close();

        return viaje;

    }

    public String borrarViajePorId(int idViaje, SessionFactory _SessionBuilder) {

        Session sesion = _SessionBuilder.openSession();

        Transaction Tx = null;
        try {
            Tx = sesion.beginTransaction();

            DAOrutas dao = new DAOrutas();
            
            Viaje viaje = (Viaje) getViajePorId(idViaje, _SessionBuilder);
            ViajeBackup viajebackup = new ViajeBackup(viaje);
            //sesion.save(viajebackup);
            List<Viajero>borrarViajero = new ArrayList<Viajero>();

            if (viaje != null) {
                Set<Compra> compras = (Set<Compra>) viaje.getCompras();
                for (Compra compra : compras) {
                    CompraBackup comprabackup = new CompraBackup(compra);
                    viajebackup.getCompraBackups().add(comprabackup);
                    comprabackup.setViajeBackup(viajebackup);
                   // sesion.save(comprabackup);

                    Set<Ocupacion> ocupaciones = (Set<Ocupacion>) compra.getOcupacions();
                    for (Ocupacion ocupacion : ocupaciones) {
                        OcupacionBackup ocupacionbackup = new OcupacionBackup(ocupacion);
                        ocupacionbackup.setCompraBackup(comprabackup);
                        comprabackup.getOcupacionBackups().add(ocupacionbackup);
                        
                        Viajero viajero = (Viajero) ocupacion.getViajero();
                        viajero.getOcupacions().remove(ocupacion);
                        
                        ViajeroBackup viajerobackup = new ViajeroBackup(viajero);
//                        sesion.save(viajerobackup);

                        int idViajeroBackup = dao.obtenerIdViajeroBackup(viajerobackup.getNumeroIdentificacion(), _SessionBuilder);

                        if(idViajeroBackup > 0){
                            viajerobackup.setId(idViajeroBackup);
                        }
                        
                        
                        ocupacionbackup.setViajeroBackup(viajerobackup);
                        viajerobackup.getOcupacionBackups().add(ocupacionbackup);
                        
                        //sesion.save(ocupacionbackup);
                        viajero.getOcupacions().remove(ocupacion);
                        if(viajero.getOcupacions().size() < 1){
                            borrarViajero.add(viajero);
                        }

                        //sesion.delete(ocupacion);
                        //sesion.delete(viajero);
                       
                    }
                    //compra.getOcupacions().clear();
                    //Quitamos la relacion de la tarjeta con la compra
                    comprabackup.setTarjeta(compra.getTarjeta());
                    compra.getTarjeta().getCompras().remove(compra);
                    //compra.setTarjeta(null);

                    //sesion.delete(compra);
                }
                //viaje.getCompras().clear();
                Horario horario = (Horario) viaje.getHorario();
                viaje.getHorario().getViajes().remove(viaje);
                viajebackup.setHorario(horario);
                
                sesion.save(viajebackup);
                sesion.delete(viaje);
                for (Viajero viajero : borrarViajero ){
                    sesion.delete(viajero);
                }
                
                sesion.flush();
                Tx.commit();
                return "true";
            }
        } catch (HibernateException HE) {
            if (Tx != null) {
                Tx.rollback();
                return HE.getMessage();
            }
        } finally {

            sesion.close();

        }
        return "false";
    }

}
