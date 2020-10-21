<%-- 
    Document   : compraRealizada
    Created on : 26-feb-2019, 12:12:52
    Author     : diego
--%>

<%@page import="POJO.Compra"%>
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

    <style>

        .box{
            position: relative;
            left: calc(50% - 300px);
            left: -webkit-calc(50% - 300px);
            margin-bottom: 20px;
            margin-right: 750px;
        }

        .ticket{
            width: 600px;
            height: 250px;
            background:rgb(105,105,105);
            border-radius: 3px;
            border-top: 1px solid rgb(105,105,105);
            border-bottom: 1px solid rgb(105,105,105);
        }

        .left{
            margin: 0;
            padding: 0;
            list-style: none;
            position: absolute;
            top: 0px;
            left: -5px;
        }

        .left li{
            width: 0px;
            height: 0px;
        }

        .left li:nth-child(-n+2){
            margin-top: 8px;
            border-top: 5px solid transparent;
            border-bottom: 5px solid transparent; 
            border-right: 5px solid rgb(105,105,105);
        }

        .left li:nth-child(3),
        .left li:nth-child(6){
            margin-top: 8px;
            border-top: 5px solid transparent;
            border-bottom: 5px solid transparent; 
            border-right: 5px solid rgb(105,105,105);
        }

        .left li:nth-child(4){
            margin-top: 8px;
            margin-left: 2px;
            border-top: 5px solid transparent;
            border-bottom: 5px solid transparent; 
            border-right: 5px solid rgb(105,105,105);
        }

        .left li:nth-child(5){
            margin-top: 8px;
            margin-left: -1px;
            border-top: 6px solid transparent;
            border-bottom: 6px solid transparent; 
            border-right: 6px solid rgb(105,105,105);
        }

        .left li:nth-child(7),
        .left li:nth-child(9),
        .left li:nth-child(11),
        .left li:nth-child(12){
            margin-top: 7px;
            border-top: 5px solid transparent;
            border-bottom: 5px solid transparent; 
            border-right: 5px solid rgb(105,105,105);
        }

        .left li:nth-child(8){
            margin-top: 7px;
            margin-left: 2px;
            border-top: 5px solid transparent;
            border-bottom: 5px solid transparent; 
            border-right: 5px solid rgb(105,105,105);
        }

        .left li:nth-child(10){
            margin-top: 7px;
            margin-left: 1px;
            border-top: 5px solid transparent;
            border-bottom: 5px solid transparent; 
            border-right: 5px solid rgb(105,105,105);
        }

        .left li:nth-child(13){
            margin-top: 7px;
            margin-left: 2px;
            border-top: 5px solid transparent;
            border-bottom: 5px solid transparent; 
            border-right: 5px solid rgb(105,105,105);
        }

        .left li:nth-child(14){
            margin-top: 7px;
            border-top: 5px solid transparent;
            border-bottom: 5px solid transparent; 
            border-right: 5px solid rgb(105,105,105);
        }

        .right{
            margin: 0;
            padding: 0;
            list-style: none;
            position: absolute;
            top: 0px;
            right: -5px;
        }

        .right li:nth-child(-n+2){
            margin-top: 8px;
            border-top: 5px solid transparent;
            border-bottom: 5px solid transparent; 
            border-left: 5px solid rgb(105,105,105);
        }

        .right li:nth-child(3),
        .right li:nth-child(4),
        .right li:nth-child(6){
            margin-top: 8px;
            border-top: 5px solid transparent;
            border-bottom: 5px solid transparent; 
            border-left: 5px solid rgb(105,105,105);
        }

        .right li:nth-child(5){
            margin-top: 8px;
            margin-left: -2px;
            border-top: 5px solid transparent;
            border-bottom: 5px solid transparent; 
            border-left: 5px solid rgb(105,105,105);
        }

        .right li:nth-child(8),
        .right li:nth-child(9),
        .right li:nth-child(11){
            margin-top: 7px;
            border-top: 5px solid transparent;
            border-bottom: 5px solid transparent; 
            border-left: 5px solid rgb(105,105,105);
        }

        .right li:nth-child(7){
            margin-top: 7px;
            margin-left: -3px;
            border-top: 5px solid transparent;
            border-bottom: 5px solid transparent; 
            border-left: 5px solid rgb(105,105,105);
        }

        .right li:nth-child(10){
            margin-top: 7px;
            margin-left: -2px;
            border-top: 5px solid transparent;
            border-bottom: 5px solid transparent; 
            border-left: 5px solid rgb(105,105,105);
        }

        .right li:nth-child(12){
            margin-top: 7px;
            border-top: 6px solid transparent;
            border-bottom: 6px solid transparent; 
            border-left: 6px solid rgb(105,105,105);
        }

        .right li:nth-child(13),
        .right li:nth-child(14){
            margin-top: 7px;
            border-top: 5px solid transparent;
            border-bottom: 5px solid transparent; 
            border-left: 5px solid rgb(105,105,105);
        }

        .ticket:after{
            content: '';
            position: absolute;
            right: 200px;
            top: 0px;
            width: 2px;
            height: 250px;

        }

        .ticket:before{
            content: '';
            position: absolute;
            z-index: 5;
            right: 199px;
            top: 0px;
            width: 1px;
            height: 250px;

        }

        .content{
            position: absolute;
            top: 40px;
            width: 100%;
            height: 180px;
            background: #eee;
        }

        .airline{
            position: absolute;
            top: 10px;
            left: 10px;
            font-family: Arial;
            font-size: 20px;
            font-weight: bold;
            color: rgb(50,205,50);
        }

        .boarding{
            position: absolute;
            top: 10px;
            right: 220px;
            font-family: Arial;
            font-size: 18px;
            color: rgba(255,255,255,0.6);   
        }

        .jfk{
            position: absolute;
            top: 10px;
            left: 20px;
            font-family: Arial;
            font-size: 38px;
            color: #222;
        }

        .sfo{
            position: absolute;
            top: 10px;
            left: 180px;
            font-family: Arial;
            font-size: 38px;
            color: #222;
        }

        .plane{
            position: absolute;
            left: 105px;
            top: 0px;
        }

        .sub-content{
            background: #e5e5e5;
            width: 100%;
            height: 100px;
            position: absolute;
            top: 70px;
        }

        .watermark{
            position: absolute;
            left: 5px;
            top: -10px;
            font-family: Arial;
            font-size: 100px;
            font-weight: bold;
            color: #d0d3d8;
        }

        .name{
            position: absolute;
            top: 10px;
            left: 10px;
            font-family: Arial Narrow, Arial;
            font-weight: bold;
            font-size: 14px;
            color: #999;
        }

        .name span{
            color: #555;
            font-size: 17px;
        }

        .flight{
            position: absolute;
            top: 10px;
            left: 180px;
            font-family: Arial Narrow, Arial;
            font-weight: bold;
            font-size: 14px;
            color: #999;
        }

        .flight span{
            color: #555;
            font-size: 17px;
        }

        .gate{
            position: absolute;
            top: 10px;
            left: 280px;
            font-family: Arial Narrow, Arial;
            font-weight: bold;
            font-size: 14px;
            color: #999;
        }

        .gate span{
            color: #555;
            font-size: 17px;
        }


        .seat{
            position: absolute;
            top: 10px;
            left: 350px;
            font-family: Arial Narrow, Arial;
            font-weight: bold;
            font-size: 14px;
            color: #999;
        }

        .seat span{
            color: #555;
            font-size: 17px;
        }

        .boardingtime{
            position: absolute;
            top: 60px;
            left: 10px;
            font-family: Arial Narrow, Arial;
            font-weight: bold;
            font-size: 14px;
            color: #999;
        }

        .boardingtime span{
            color: #555;
            font-size: 17px;
        }

        .barcode{
            position: absolute;
            left: 8px;
            bottom: 6px;
            height: 30px;
            width: 90px;
            background: rgb(105,105,105);

        }

        .slip{
            left: 455px;
        }

        .nameslip{
            top: 60px;
            left: 410px;
        }

        .flightslip{
            left: 410px;
        }

        .seatslip{
            left: 540px;
        }

        .jfkslip{
            font-size: 30px;
            top: 20px;
            left: 410px;
        }

        .sfoslip{
            font-size: 30px;
            top: 20px;
            left: 530px;
        }

        .planeslip{
            top: 10px;
            left: 475px;
        }

        .airlineslip{
            left: 455px;
        }

    </style>

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
            ArrayList<Viajero> arraylist = (ArrayList<Viajero>) request.getSession().getAttribute("arraylist");
            ArrayList<Integer> arrayAsientos = (ArrayList<Integer>) request.getSession().getAttribute("arrayAsientos");

            try {
                if (request.getSession().getAttribute("viajeDesdeId") != null) {

                    List<Viaje> viajeDesdeId = (List<Viaje>) request.getSession().getAttribute("viajeDesdeId");

                    Compra compra = (Compra) request.getSession().getAttribute("compra");

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
                            <td><%= viaje.getHorario().getRuta().getPrecio() * arraylist.size()%>€</td>
                        </tr>

                    </tbody>
                </table>

            </div>
        </form>

        <%

            for (int i = 0; i < arraylist.size(); i++) {


        %>
        <div class="box">
            <ul class="left">
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
            </ul>

            <ul class="right">
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
            </ul>
            <div class="ticket">
                <span class="airline" style="font-family:'Trade Winds';">MasterBus</span>
                <span class="airline airlineslip" style="font-family:'Trade Winds';">MasterBus</span>
                <span class="boarding">Billete de Bus</span>
                <div class="content">
                    <span class="jfk"><%= viaje.getHorario().getRuta().getEstacionByEstacionOrigen().getNombreEstacion()%></span>
                    <span class="sfo">- <%= viaje.getHorario().getRuta().getEstacionByEstacionDestino().getNombreEstacion()%></span>


                    <div class="sub-content">
                        <span class="watermark" style="font-family:'Trade Winds';">MasterBus</span>
                        <span class="name">NOMBRE VIAJERO<br><span><%= arraylist.get(i).getApellidos()%>, <%= arraylist.get(i).getNombre()%></span></span>
                        <span class="flight">LOCALIZADOR<br><span id="localizador"><%= compra.getLocalizador()%></span></span>
                        <span class="gate">ASIENTO<br><span><%= arrayAsientos.get(i)%></span></span>
                        <span class="boardingtime">HORARIO<br><span>DIA - <%= viaje.getFecha().toString()%> &nbsp;&nbsp;HORA - <%= viaje.getHorario().getHoraSalida().toString()%></span></span>
                        <span class="flight flightslip" id="qrcode<%=i%>"></span>
                        <!--                        <span class="flight flightslip">FLIGHT N&deg;<br><span>X3-65C3</span></span>
                                                <span class="seat seatslip">SEAT<br><span>45A</span></span>
                                                <span class="name nameslip">PASSENGER NAME<br><span>Rex, Anonasaurus</span></span>-->
                    </div>
                </div>
            </div>
        </div>


        <%
            }
        %>
        <%
                    }
                }
            } catch (Exception e) {
                out.print(e.getMessage());
            }
        %>





        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
        <script>
            
            var idQR = document.querySelectorAll('[id^="qrcode"]');
            
            $(document).ready(function () {
                $(idQR).qrcode({width: 90, height: 90, text: $('#localizador').text()});
            });

        </script>

        <script type="text/javascript" src="assets/js/jquery.min.js"></script>
        <script type="text/javascript" src="assets/js/jquery.qrcode.min.js"></script>
    </body>

</html>