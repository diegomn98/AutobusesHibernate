/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJO.Cliente;
import POJO.Tarjeta;
import static java.lang.System.out;
import java.util.List;
import java.util.Set;
import javax.servlet.RequestDispatcher;
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
public class DAOlogin {

    public String insertarCliente(Cliente cliente, SessionFactory _SessionBuilder) {

        Session sesion = _SessionBuilder.openSession();
        Transaction Tx = null;
        try {

            Tx = sesion.beginTransaction();

            String clienteInsertado = "";

            sesion.save(cliente);

            Tx.commit();

            return clienteInsertado = "1";

        } catch (Exception e) {
            if (Tx != null) {
                Tx.rollback();
            }
            throw e;
        } finally {
            sesion.close();
        }

    }

    public List inicioSesion(String usuario, String password, SessionFactory _SessionBuilder) {

        Session sesion = _SessionBuilder.openSession();

        boolean estado = false;

        String passwordEncriptada = "";

        passwordEncriptada = Hash.md5(password);

        String ordenHQL = "FROM Cliente c WHERE c.numeroIdentificacion =:usuario AND c.password =:passwordEncriptada ";
        Query q = sesion.createQuery(ordenHQL);

        q.setParameter("usuario", usuario);
        q.setParameter("passwordEncriptada", passwordEncriptada);

        List<Cliente> datosUsuario = q.list();

        if (!datosUsuario.isEmpty()) {
            Hibernate.initialize(datosUsuario.get(0).getTarjetas());

            Set<Tarjeta> tarjetas = datosUsuario.get(0).getTarjetas();

            for (Tarjeta t : tarjetas) {
                Hibernate.initialize(t.getCompras());
            }
        }
        sesion.close();

        return datosUsuario;
    }
    
    public boolean comprobarNif(String numeroIdentificacion, SessionFactory _SessionBuilder){
        
        Session sesion = _SessionBuilder.openSession();

        boolean registrado = false;
        
        String ordenHQL = "FROM Cliente c WHERE c.numeroIdentificacion =:numeroIdentificacion";
        Query q = sesion.createQuery(ordenHQL);

        q.setParameter("numeroIdentificacion", numeroIdentificacion);
        
        List clientes = q.list();
        
        if(clientes.size() > 0){
            registrado = true;
        }
        
        return registrado;
        
    }

}
