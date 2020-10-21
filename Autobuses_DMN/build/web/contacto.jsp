<%-- 
    Document   : contacto
    Created on : 27-feb-2019, 11:20:38
    Author     : diego
--%>

<%@page import="POJO.Cliente"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="DAO.NewHibernateUtil"%>
<%@page import="POJO.Estacion"%>
<%@page import="java.util.List"%>
<%@page import="DAO.DAOrutas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Contacto</title>
        <link rel="icon" type="image/png" href="IMAGENES/logoAutobus.png">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Fruktur">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Joti+One">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Mate+SC">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Monofett">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Timmana">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Trade+Winds">
        <link rel="stylesheet" href="assets/css/styles.min.css">
    </head>

    <body style="background-image:url(IMAGENES/carretera.jpg);background-size:100% 100%;background-attachment:fixed;background-repeat:no-repeat;">
        <div>
            <nav class="navbar navbar-light navbar-expand-md navigation-clean-button" style="background-color:rgb(105, 105, 105);">
                <div class="container"><a class="navbar-brand" href="index.jsp" style="color:rgb(50,205,50);background-image:url(&quot;assets/img/logoAutobus.png&quot;);font-family:'Trade Winds', cursive;margin-right:50px;font-size:29px;"><img src="IMAGENES/logoAutobus.png" height="30px" />MasterBus</a><button class="navbar-toggler" data-toggle="collapse"
                                                                                                                                                                                                        data-target="#navcol-1"><span class="sr-only">Toggle navigation</span><span class="navbar-toggler-icon"></span></button>
                    <div class="collapse navbar-collapse" id="navcol-1">
                        <ul class="nav navbar-nav mr-auto">
                            <li class="nav-item" role="presentation"><a class="nav-link" href="controladorRutas" style="color:rgb(255,255,255);font-size:18px;font-family:'Mate SC', serif;">Ruta</a></li>
                            <li class="nav-item" role="presentation"><a class="nav-link" href="administrador.jsp" style="color:rgb(255,255,255);font-size:18px;font-family:'Mate SC', serif;">Administrador</a></li>
                            <li class="nav-item" role="presentation"><a class="nav-link" href="contacto.jsp" style="color:rgb(255,255,255);font-size:18px;font-family:'Mate SC', serif;">Contacto</a></li>
                        </ul>
                        <%
                            if (request.getSession().getAttribute("inicioSesion") == null) {
                        %>

                        <span class="navbar-text actions"> <a href="registro.jsp" class="login" style="color:rgb(255,255,255);font-family:'Mate SC', serif;">Registro</a><a class="btn btn-light action-button" role="button" href="login.jsp" style="background-color:rgb(50,205,50);font-family:'Mate SC', serif;">Iniciar Sesión</a></span>

                        <%
                        } else {

                        %>
                        <span class="navbar-text actions"> <a href="#" class="login" style="color:rgb(255,255,255);font-family:'Mate SC', serif;"><%= ((List<Cliente>) request.getSession().getAttribute("inicioSesion")).get(0).getNumeroIdentificacion()%></a><a class="btn btn-light action-button" role="button" href="controladorLogout" style="background-color:rgb(50,205,50);font-family:'Mate SC', serif;">Cerrar Sesión</a></span>
                                <%

                                    }
                                %>
                    </div>
            </nav>              
        </div>

        <div style="border-radius: 10px;float: left;opacity:0.85;margin-left:9%; margin-top: 2%;background-color:gainsboro;height:500px;width:30%;text-align: center;">
            
            <h2>Contacto</h2>
            <hr style="color:black;">
            
            <h4 style="font-size: 20px">Envianos un email</h4>
            <p style="font-size: 20px">masterbus@gmail.com</p>
            <hr style="color:black">
            
            <h4 style="font-size: 20px">Atención al Viajero</h4>
            <p style="font-size: 20px">967 12 34 56</p>
            <hr style="color:black">
            
            <h4 style="font-size: 20px">Dirección Postal</h4>
            <p style="font-size: 20px">C/ Feria, 27, 02005 Albacete</p>
            
        </div>
        <div style="float: left;border-radius: 10px;opacity:0.85;margin-left:9%; margin-top: 2%;background-color:gainsboro;height:500px;width:40%;display: flex;justify-content: center;align-items: center;">
            
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3100.760141104681!2d-1.8470698052064651!3d38.99797028021076!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd665f94721977a7%3A0x8a688fed348c0665!2sEstacion+de+Autobuses!5e0!3m2!1ses!2ses!4v1551263243978" width="98%" height="495px" frameborder="0" style="border-radius: 2px" allowfullscreen></iframe>
            
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
    </body>

</html>
