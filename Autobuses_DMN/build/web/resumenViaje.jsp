<%-- 
    Document   : resumenViaje
    Created on : 04-feb-2019, 17:28:37
    Author     : diego
--%>

<%@page import="POJO.Cliente"%>
<%@page import="POJO.Viajero"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="POJO.Viaje"%>
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

        <%

            ArrayList<Viajero> arraylist = (ArrayList<Viajero>) request.getAttribute("arraylist");
            ArrayList<Integer> arrayAsientos = (ArrayList<Integer>) request.getAttribute("arrayAsientos");

            try {
                if (request.getAttribute("viajeDesdeId") != null) {

                    List<Viaje> viajeDesdeId = (List<Viaje>) request.getAttribute("viajeDesdeId");

                    Iterator iter = viajeDesdeId.iterator();

                    while (iter.hasNext()) {
                        Viaje viaje = (Viaje) iter.next();

        %>
        <form action="controladorTarjeta" method="get" style="text-align: center">
            <div style="width: 80%; margin: 0 auto; text-align: center; background: white; height: 170px; margin-bottom: 10px; margin-top: 20px; opacity: 0.9">
                <h3>Resumen de tu Viaje</h3>
                <table class="table">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">Estación Origen</th>
                            <th scope="col">Estación Destino</th>
                            <th scope="col">Fecha</th>
                            <th scope="col">Horario Salida</th>
                            <th scope="col">Horario Llegada</th>
                            <th scope="col">Tiempo Estimado</th>
                            <th scope="col">Precio</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><%= viaje.getHorario().getRuta().getEstacionByEstacionOrigen().getNombreEstacion()%></td>
                            <td><%= viaje.getHorario().getRuta().getEstacionByEstacionDestino().getNombreEstacion()%></td>
                            <td><%= viaje.getFecha().toString()%></td>
                            <td><%= viaje.getHorario().getHoraSalida().toString()%></td>
                            <td><%= viaje.getHorario().getHoraLlegada().toString()%></td>
                            <td><%= viaje.getHorario().getRuta().getTiempoEstimado()%></td>
                            <td><%= viaje.getHorario().getRuta().getPrecio() * arraylist.size() %>€</td>
                        </tr>

                    </tbody>
                </table>

            </div>

            <div style="width: 80%; margin: 0 auto; text-align: center; background: white; margin-bottom: 10px; margin-top: 20px; opacity: 0.9">
                <h3>Pasajeros</h3>

                <table class="table">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">NIF</th>
                            <th scope="col">Nombre</th>
                            <th scope="col">Apellidos</th>
                            <th scope="col">NºAsiento</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (int i = 0; i < arraylist.size(); i++) {


                        %>
                        <tr>
                            <td><%= arraylist.get(i).getNumeroIdentificacion()%></td>
                            <td><%= arraylist.get(i).getNombre()%></td>
                            <td><%= arraylist.get(i).getApellidos()%></td>
                            <td><%= arrayAsientos.get(i)%></td>

                            <%
                                }
                            %>
                        </tr>
                    </tbody>
                </table>

            </div>
            <button type="submit" id="boton1" class="btn btn-primary">Continuar</button>
        </form>
        <%
                    }
                }
            } catch (Exception e) {
                out.print(e.getMessage());
            }
        %>


        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
    </body>

</html>