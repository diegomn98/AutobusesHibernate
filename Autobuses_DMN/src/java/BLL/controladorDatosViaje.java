/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BLL;

import DAO.DAOrutas;
import DAO.NewHibernateUtil;
import POJO.Viaje;
import POJO.Viajero;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.SessionFactory;

/**
 *
 * @author diego
 */
public class controladorDatosViaje extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            ArrayList<Viajero> arraylist = new ArrayList();

            ArrayList<Integer> arrayAsientos = new ArrayList();

            List<Viaje> viajeDesdeId;

            if (request.getSession().getAttribute("estadoCompra") == "controladorDatosViaje") {

                viajeDesdeId = (List<Viaje>) request.getSession().getAttribute("viajeDesdeId");
                arraylist = (ArrayList<Viajero>) request.getSession().getAttribute("arraylist");
                arrayAsientos = (ArrayList<Integer>) request.getSession().getAttribute("arrayAsientos");

            } else {

                int plazasReserva = (Integer) request.getSession().getAttribute("plazasReserva");

                for (int i = 0; i < plazasReserva; i++) {

                    String nif = request.getParameter("identificacion" + i);
                    String nombre = request.getParameter("nombre" + i);
                    String apellidos = request.getParameter("apellidos" + i);
                    int asiento = Integer.parseInt(request.getParameter("plazaViajero" + i));

                    Viajero viajero = new Viajero(nif, nombre, apellidos);

                    arraylist.add(viajero);

                    arrayAsientos.add(asiento);
                }

                int idViaje = (Integer) request.getSession().getAttribute("idViaje");

                HttpSession httpSession = request.getSession();
                DAOrutas dao = new DAOrutas();

                viajeDesdeId = dao.getViajeEspecifico(idViaje, SessionBuilder);

                request.getSession().setAttribute("viajeDesdeId", viajeDesdeId);
                request.getSession().setAttribute("arraylist", arraylist);
                request.getSession().setAttribute("arrayAsientos", arrayAsientos);
                request.getSession().setAttribute("estadoCompra", "controladorDatosViaje");

            }

            request.setAttribute("arraylist", arraylist);
            request.setAttribute("arrayAsientos", arrayAsientos);
            request.setAttribute("viajeDesdeId", viajeDesdeId);
            String nextJSP = "/resumenViaje.jsp";
            RequestDispatcher dispatcher = request.getRequestDispatcher(nextJSP);
            dispatcher.forward(request, response);

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
        processRequest(request, response);
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
        processRequest(request, response);
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
