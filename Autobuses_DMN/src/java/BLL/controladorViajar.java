/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BLL;

import DAO.DAOadministrador;
import DAO.NewHibernateUtil;
import POJO.Administrador;
import POJO.Viaje;
import java.io.IOException;
import java.io.PrintWriter;
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
public class controladorViajar extends HttpServlet {

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

            HttpSession httpSession = request.getSession();
            DAOadministrador dao = new DAOadministrador();

            List<Administrador> inicioSesionAdministrador = (List<Administrador>) request.getSession().getAttribute("inicioSesionAdministrador");

            if (inicioSesionAdministrador == null) {
                String numeroIdentificacion = request.getParameter("usuario");
                String password = request.getParameter("password");

                inicioSesionAdministrador = (List<Administrador>) dao.inicioSesionAdministrador(numeroIdentificacion, password, SessionBuilder);
                //request.getSession().setAttribute("inicioSesionAdministrador", inicioSesionAdministrador);
            }

            if (!inicioSesionAdministrador.isEmpty()) {
                request.getSession().setAttribute("inicioSesionAdministrador", inicioSesionAdministrador);
                List<Viaje> viajes = (List<Viaje>) dao.getViajes(SessionBuilder);
                request.setAttribute("viajes", viajes);
                String nextJSP = "/viajar.jsp";
                RequestDispatcher dispatcher = request.getRequestDispatcher(nextJSP);
                dispatcher.forward(request, response);
            } else {
                String mensaje = "El administrador es incorrecto";
                String nextJSP = "/vistaErrores.jsp?id=2&mensaje=" + mensaje;
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
