/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BLL;

import DAO.DAOrutas;
import DAO.NewHibernateUtil;
import POJO.Cliente;
import POJO.Compra;
import POJO.Ocupacion;
import POJO.Tarjeta;
import POJO.Viaje;
import POJO.Viajero;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SessionFactory;

/**
 *
 * @author diego
 */
public class controladorPago extends HttpServlet {

    private SessionFactory SessionBuilder;

    public void init() {
        SessionBuilder = NewHibernateUtil.getSessionFactory();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {
                if (request.getSession().getAttribute("compra") == null) {
                    int idTarjeta = 0;

                    String tipoTarjeta = request.getParameter("typeCard");
                    String numeroTarjeta = request.getParameter("cardNumber");
                    String dayMonthYearCaducidad = request.getParameter("cardExpiry");
                    int CVV = Integer.parseInt(request.getParameter("cardCVV"));

                    if (request.getParameter("tarjetas") != null) {
                        idTarjeta = Integer.parseInt(request.getParameter("tarjetas"));
                    }

                    //SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                    DAOrutas dao = new DAOrutas();

                    String localizador = dao.generarLocalizador(SessionBuilder);

                    List<Cliente> clientes = (List<Cliente>) request.getSession().getAttribute("inicioSesion");
                    Cliente cliente = clientes.get(0);
                    Tarjeta tarjeta = null;

                    if (idTarjeta == 0) {
                        SimpleDateFormat parser = new SimpleDateFormat("MM/yy");
                        Date fechaCaducidad = parser.parse(dayMonthYearCaducidad);
                        tarjeta = new Tarjeta(cliente, tipoTarjeta, numeroTarjeta, fechaCaducidad, CVV);
                        cliente.getTarjetas().add(tarjeta);
                    } else {

                        Set<Tarjeta> tarjetas = cliente.getTarjetas();
                        for (Tarjeta t : tarjetas) {
                            if (t.getId() == idTarjeta && t.getCvv() == CVV) {
                                tarjeta = t;
                            } else {
                                String mensaje = "Error en la tarjeta";
                                String nextJSP = "/vistaErrores.jsp?id=4&mensaje=" + mensaje;
                                RequestDispatcher dispatcher = request.getRequestDispatcher(nextJSP);
                                dispatcher.forward(request, response);
                            }
                        }

                    }

                    List<Viaje> viajes = (List<Viaje>) request.getSession().getAttribute("viajeDesdeId");
                    Viaje viaje = viajes.get(0);
//                    viajes = dao.getViajeEspecifico(viaje.getId(), SessionBuilder);
//                    viaje = viajes.get(0);

                    float precio = viaje.getHorario().getRuta().getPrecio();

                    ArrayList<Viajero> viajeros = (ArrayList<Viajero>) request.getSession().getAttribute("arraylist");

                    for (int i = 0; i < viajeros.size(); i++) {

                        int idViajeroPorNif = dao.obtenerIdViajeroPorNif(viajeros.get(i).getNumeroIdentificacion(), SessionBuilder);
                        //int idViajeroBackup = dao.obtenerIdViajeroBackup(viajeros.get(i).getNumeroIdentificacion(), SessionBuilder);

                        if (idViajeroPorNif > 0) {
                            viajeros.get(i).setId(idViajeroPorNif);
                        }//else if(idViajeroBackup > 0){
//                            viajeros.get(i).setId(idViajeroBackup);
//                        }
                    }

                    int numeroPasajeros = viajeros.size();

                    viaje.setPlazasDisponibles(viaje.getPlazasDisponibles() - numeroPasajeros);

                    float precioTotal = precio * numeroPasajeros;

                    ArrayList<Integer> asientosOcupados = (ArrayList<Integer>) request.getSession().getAttribute("arrayAsientos");

                    Compra compra = new Compra(tarjeta, viaje, new Date(), precioTotal, numeroPasajeros, localizador);
                    tarjeta.getCompras().add(compra);
                    viaje.getCompras().add(compra);

                    for (int i = 0; i < viajeros.size(); i++) {
                        Ocupacion ocupacion = new Ocupacion(compra, viajeros.get(i), asientosOcupados.get(i), precio);
                        compra.getOcupacions().add(ocupacion);
                    }

                    dao.saveCompra(compra, SessionBuilder);

                    

                    request.getSession().setAttribute("compra", compra);
                }
                String nextJSP = "/compraRealizada.jsp";
                RequestDispatcher dispatcher = request.getRequestDispatcher(nextJSP);
                dispatcher.forward(request, response);

            } catch (Exception e) {
                String mensaje = "Error en el pago";
                String nextJSP = "/vistaErrores.jsp?id=5&mensaje=" + mensaje;
                RequestDispatcher dispatcher = request.getRequestDispatcher(nextJSP);
                dispatcher.forward(request, response);
            }

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(controladorPago.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(controladorPago.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
