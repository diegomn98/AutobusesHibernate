/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BLL;

import DAO.DAOrutas;
import DAO.NewHibernateUtil;
import POJO.Estacion;
import POJO.Viaje;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
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
public class controladorMostrarRutas extends HttpServlet {

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

            int origen = Integer.parseInt(request.getParameter("origen"));
            int destino = Integer.parseInt(request.getParameter("destino"));
            LocalDate fecha = LocalDate.parse(request.getParameter("fechaInput"));
            int plazas = Integer.parseInt(request.getParameter("plazas"));

            DAOrutas dao = new DAOrutas();
//            HttpSession session = request.getSession();
//            
//            session.setAttribute("plazasReserva", plazas);
            request.getSession().setAttribute("plazasReserva", plazas);

            List<Viaje> viajesDia = dao.getRutasDia(fecha, origen, destino, plazas, SessionBuilder);

            if (!viajesDia.isEmpty()) {
                request.setAttribute("viajesDia", viajesDia);
                String nextJSP = "/muestraRutas.jsp";
                RequestDispatcher dispatcher = request.getRequestDispatcher(nextJSP);
                dispatcher.forward(request, response);
            }else{
                String mensaje = "No hay viajes disponibles para esta ruta en este día";
                String nextJSP = "/vistaErrores.jsp?id=3&mensaje=" + mensaje;
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
