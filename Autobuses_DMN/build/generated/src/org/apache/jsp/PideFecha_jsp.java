package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import POJO.Cliente;
import org.hibernate.SessionFactory;
import DAO.NewHibernateUtil;
import POJO.Estacion;
import java.util.List;
import DAO.DAOrutas;

public final class PideFecha_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("\n");
      out.write("    <head>\n");
      out.write("        <meta charset=\"utf-8\">\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("        <title>MasterBus</title>\n");
      out.write("        <link rel=\"icon\" type=\"image/png\" href=\"IMAGENES/logoAutobus.png\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/css/bootstrap.min.css\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/css?family=Fruktur\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/css?family=Joti+One\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/css?family=Mate+SC\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/css?family=Monofett\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/css?family=Timmana\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/css?family=Trade+Winds\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"assets/css/styles.min.css\">\n");
      out.write("    </head>\n");
      out.write("\n");
      out.write("    <body style=\"background-image:url(IMAGENES/carretera.jpg);background-size:100% 100%;background-attachment:fixed;background-repeat:no-repeat;\">\n");
      out.write("        <div>\n");
      out.write("            <nav class=\"navbar navbar-light navbar-expand-md navigation-clean-button\" style=\"background-color:rgb(105, 105, 105);\">\n");
      out.write("                <div class=\"container\"><a class=\"navbar-brand\" href=\"index.jsp\" style=\"color:rgb(50,205,50);background-image:url(&quot;assets/img/logoAutobus.png&quot;);font-family:'Trade Winds', cursive;margin-right:50px;font-size:29px;\"><img src=\"IMAGENES/logoAutobus.png\" height=\"30px\" />MasterBus</a><button class=\"navbar-toggler\" data-toggle=\"collapse\"\n");
      out.write("                                                                                                                                                                                                        data-target=\"#navcol-1\"><span class=\"sr-only\">Toggle navigation</span><span class=\"navbar-toggler-icon\"></span></button>\n");
      out.write("                    <div class=\"collapse navbar-collapse\" id=\"navcol-1\">\n");
      out.write("                        <ul class=\"nav navbar-nav mr-auto\">\n");
      out.write("                            <li class=\"nav-item\" role=\"presentation\"><a class=\"nav-link\" href=\"controladorRutas\" style=\"color:rgb(255,255,255);font-size:18px;font-family:'Mate SC', serif;\">Ruta</a></li>\n");
      out.write("                            <li class=\"nav-item\" role=\"presentation\"><a class=\"nav-link\" href=\"administrador.jsp\" style=\"color:rgb(255,255,255);font-size:18px;font-family:'Mate SC', serif;\">Administrador</a></li>\n");
      out.write("                            <li class=\"nav-item\" role=\"presentation\"><a class=\"nav-link\" href=\"contacto.jsp\" style=\"color:rgb(255,255,255);font-size:18px;font-family:'Mate SC', serif;\">Contacto</a></li>\n");
      out.write("                            <li class=\"nav-item\" role=\"presentation\"><a class=\"nav-link\" href=\"PideFecha.jsp\" style=\"color:rgb(255,255,255);font-size:18px;font-family:'Mate SC', serif;\">Exámen</a></li>\n");
      out.write("                        </ul>\n");
      out.write("                        ");

                            if (request.getSession().getAttribute("inicioSesion") == null) {
                        
      out.write("\n");
      out.write("\n");
      out.write("                        <span class=\"navbar-text actions\"> <a href=\"registro.jsp\" class=\"login\" style=\"color:rgb(255,255,255);font-family:'Mate SC', serif;\">Registro</a><a class=\"btn btn-light action-button\" role=\"button\" href=\"login.jsp\" style=\"background-color:rgb(50,205,50);font-family:'Mate SC', serif;\">Iniciar Sesión</a></span>\n");
      out.write("\n");
      out.write("                        ");

                        } else {

                        
      out.write("\n");
      out.write("                        <span class=\"navbar-text actions\"> <a href=\"#\" class=\"login\" style=\"color:rgb(255,255,255);font-family:'Mate SC', serif;\">");
      out.print( ((List<Cliente>) request.getSession().getAttribute("inicioSesion")).get(0).getNumeroIdentificacion());
      out.write("</a><a class=\"btn btn-light action-button\" role=\"button\" href=\"controladorLogout\" style=\"background-color:rgb(50,205,50);font-family:'Mate SC', serif;\">Cerrar Sesión</a></span>\n");
      out.write("                                ");


                                    }
                                
      out.write("\n");
      out.write("                    </div>\n");
      out.write("            </nav>              \n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        \n");
      out.write("\n");
      out.write("        <script src=\"https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js\"></script>\n");
      out.write("        <script src=\"https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/js/bootstrap.bundle.min.js\"></script>\n");
      out.write("    </body>\n");
      out.write("\n");
      out.write("</html>\n");
      out.write("\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
