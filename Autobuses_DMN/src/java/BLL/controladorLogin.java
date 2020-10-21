/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BLL;

import DAO.DAOlogin;
import DAO.Hash;
import DAO.NewHibernateUtil;
import POJO.Cliente;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
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
public class controladorLogin extends HttpServlet {

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

            String numeroIdentificacion = request.getParameter("usuario");
            String password = request.getParameter("password");
            
            String passwordEncriptada = Hash.md5(password);

            HttpSession httpSession = request.getSession();
            DAOlogin dao = new DAOlogin();

            List<Cliente> inicioSesion = (List<Cliente>) dao.inicioSesion(numeroIdentificacion, password, SessionBuilder);

            if (!inicioSesion.isEmpty()) {
                request.setAttribute("inicioSesion", inicioSesion);
                String nextJSP = "/index.jsp";
                request.getSession().setAttribute("inicioSesion", inicioSesion);
                if (request.getSession().getAttribute("estadoCompra") != null) {
                    nextJSP = (String) request.getSession().getAttribute("estadoCompra");
                }

                RequestDispatcher dispatcher = request.getRequestDispatcher(nextJSP);
                dispatcher.forward(request, response);
            }else{
                String mensaje = "El usuario es incorrecto";
                String nextJSP = "/vistaErrores.jsp?id=1&mensaje="+mensaje;
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
