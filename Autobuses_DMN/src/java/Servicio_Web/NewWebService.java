/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servicio_Web;

import DAO.DAOservicio;
import DAO.NewHibernateUtil;
import Modelo.Viajes;
import POJO.Viaje;
import java.io.StringWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.PropertyException;
import org.hibernate.SessionFactory;

/**
 *
 * @author diego
 */
@WebService(serviceName = "NewWebService")
public class NewWebService {

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "obtenerViajes")
    public ArrayList<Viajes> obtenerViajes() throws PropertyException, JAXBException {

        
        SessionFactory SessionBuilder = NewHibernateUtil.getSessionFactory();

        DAOservicio dao = new DAOservicio();

        ArrayList<Viajes> viajes = (ArrayList<Viajes>)dao.getViajes(SessionBuilder);

        return viajes;
        
        
    }
}
