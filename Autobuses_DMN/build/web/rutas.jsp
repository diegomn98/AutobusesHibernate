<%-- 
    Document   : rutas
    Created on : 18-ene-2019, 12:43:09
    Author     : diego
--%>

<%@page import="POJO.Cliente"%>
<%@page import="java.util.List"%>
<%@page import="POJO.Estacion"%>
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
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
    </head>

    <script>
        function obtenerDestinos(idOrigen) {
            var xmlhttp;
            if (idOrigen === "") {
                document.getElementById("destino").innerHTML = "";

                return;

            }
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            } else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                    document.getElementById("destino").innerHTML = xmlhttp.responseText;
                }
            };
            xmlhttp.open("GET", "/Autobuses_DMN/controladorAjax?origen=" + idOrigen, true);
            xmlhttp.send();
        }
    </script>

    <style>

        #select1{
            height: 40%;
            width: 50%;
            float: left;
            margin-top:50px;
            text-align: center;
        }

        .nombre1{
            color: black;
            font-weight: bold;
            font-size: 18px;
        }

        .nombre2{
            color: black;
            font-weight: bold;
            font-size: 18px;
        }

        #select2{
            height: 40%;
            width: 50%;
            float: left;
            margin-top: 50px;
            text-align: center;
        }

        #fechaViaje{
            clear: both;
            margin-top:50px;
        }   
        #plazasReservadas{
            clear: both;
            margin-top:50px;
        }   

        #origen{
            padding: 12px;
            width: 275px;
            border-color: green;
        }
        #destino{
            padding: 12px;
            width: 275px;
            border-color: green;
        }

        #fechaInput{
            padding: 12px;
            width: 275px;
            text-align: center;
            border-color: green;
            border-width: 1px;
        }
        #plazas{
            padding: 12px;
            width: 275px;
            text-align: center;
            border-color: green;
            border-width: 1px;
        }

        #buscar{
            clear: both;
            height: 60%;
            width: 100%;
            text-align: center;
        }

        #boton {
            position: relative;
            margin-top: 30px;
            z-index: 0;
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

        <div style="border-radius: 15%;margin-left:9%;margin-right: 9%; margin-top: 2%;background-color:gainsboro;height:500px;width:80%;" id="contenedor">
            <form action="controladorMostrarRutas" method="get" onsubmit="return comprobar()">
                <div id="select1">
                    <span class="nombre1">Estación Origen</span>
                    <br>
                    <select required id="origen" name="origen" onchange="obtenerDestinos(this.value)" style="text-align-last: center">
                        <option selected="selected">Selecciona una estación</option>
                        <%
                            if (request.getAttribute("origenes") != null) {
                                List<Estacion> origenes = (List<Estacion>) request.getAttribute("origenes");

                                for (Estacion estacion : origenes) {
                        %>
                        <option required="" value="<%= estacion.getId()%>"><%= estacion.getNombreEstacion()%></option>
                        <%
                                }
                            }
                        %>
                    </select>

                    <div id="fechaViaje">
                        <input type="text" required id="fechaInput" name="fechaInput" min="2019-02-04" max="2019-02-09" placeholder="Fecha de Viaje" onfocus="(this.type = 'date')" onblur="(this.type = 'text')" required="required"/>
                    </div>  
                </div>
                <div id="select2">
                    <span class="nombre2">Estación Destino</span>
                    <br>
                    <select id="destino" name="destino" style="text-align-last: center">
                        <option selected="selected">Selecciona un destino</option>>
                    </select>
                    <div id="plazasReservadas">
                        <input type="text" required min="1" max="8" pattern="[1-8]{1}" required="required" id="plazas" name="plazas" placeholder="Plazas a reservar" onfocus="(this.type = 'number')" onblur="(this.type = 'text')"/>
                    </div>
                </div>

                <div id="buscar">
                    <button type="submit" id="boton" style="background-color:rgb(50,205,50);border-radius: 15%; width: 170px;height: 60px; font-weight: bold;">Buscar</button>
                </div>
            </form>
        </div>


        <script>
            
            
            function comprobar(){
                var select1 = document.getElementById("origen");
                
                if(select1.value == "Selecciona una estación"){
                    alert("Elige una estación");
                    return false;
                }
                return true;
                
            }

        </script>


        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>

    </body>

</html>
