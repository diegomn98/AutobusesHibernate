<%-- 
    Document   : viajar
    Created on : 27-feb-2019, 12:28:47
    Author     : diego
--%>

<%@page import="POJO.Viaje"%>
<%@page import="POJO.Administrador"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="DAO.NewHibernateUtil"%>
<%@page import="POJO.Estacion"%>
<%@page import="java.util.List"%>
<%@page import="DAO.DAOrutas"%>
<%@page import="DAO.DAOadministrador"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>MasterBus</title>
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

                        </ul>
                        <%
                            if (request.getSession().getAttribute("inicioSesionAdministrador") == null) {
                        %>

                        <span class="navbar-text actions"> <a href="registro.jsp" class="login" style="color:rgb(255,255,255);font-family:'Mate SC', serif;">Registro</a><a class="btn btn-light action-button" role="button" href="login.jsp" style="background-color:rgb(50,205,50);font-family:'Mate SC', serif;">Iniciar Sesión</a></span>

                        <%
                        } else {

                        %>
                        <span class="navbar-text actions"> <a href="#" class="login" style="color:rgb(255,255,255);font-family:'Mate SC', serif;"><%= ((List<Administrador>) request.getSession().getAttribute("inicioSesionAdministrador")).get(0).getNombre()%></a><a class="btn btn-light action-button" role="button" href="controladorLogout" style="background-color:rgb(50,205,50);font-family:'Mate SC', serif;">Cerrar Sesión</a></span>
                                <%

                                    }
                                %>
                    </div>
            </nav>              
        </div>
        <div style="width: 80%; margin: 0 auto; text-align: center; background: white; margin-bottom: 10px; margin-top: 20px; opacity: 0.9">
            <table class="table">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">Estación Origen</th>
                        <th scope="col">Estación Destino</th>
                        <th scope="col">Fecha</th>
                        <th scope="col">Horario Salida</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Viaje> viajes = (List<Viaje>) request.getAttribute("viajes");

                        for(Viaje viaje : viajes) {


                    %>


                    <tr>
                        <td><%= viaje.getHorario().getRuta().getEstacionByEstacionOrigen().getNombreEstacion()%></td>
                        <td><%= viaje.getHorario().getRuta().getEstacionByEstacionDestino().getNombreEstacion()%></td>
                        <td><%= viaje.getFecha().toString()%></td>
                        <td><%= viaje.getHorario().getHoraSalida().toString()%></td>
                        <td><a class="btn btn-primary" href="controladorHacerViaje?idViaje=<%= viaje.getId() %>" role="button">Viajar</a></td>
                    </tr>




                    <%

                        }

                    %>

                </tbody>
            </table>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
    </body>

</html>
