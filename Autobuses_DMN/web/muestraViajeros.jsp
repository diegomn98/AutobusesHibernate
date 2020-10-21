<%-- 
    Document   : muestraViajeros
    Created on : 01-feb-2019, 9:55:51
    Author     : diego
--%>

<%@page import="POJO.Cliente"%>
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

        <script>

            function funcionSelect(pasajero, asientosDisponibles) {
                var seleccionAsiento = document.querySelectorAll('[id^="plazaViajero"]');

                var asientosSeleccionados = new Array();

                for (var l = 0; l < seleccionAsiento.length; l++) {
                    asientosSeleccionados[l] = seleccionAsiento[l].value;
                }



                for (var i = 0; i < seleccionAsiento.length; i++) {
                    if (seleccionAsiento[i].id != 'plazaViajero' + pasajero) {
                        seleccionAsiento[i].innerHTML = "<option>Selecciona asiento</option>";
                        for (var j = 0; j < asientosDisponibles.length; j++) {

                            var seleccionado = false;

                            for (var k = 0; k < asientosSeleccionados.length; k++) {

                                if (asientosDisponibles[j] == asientosSeleccionados[k]) {
                                    seleccionado = true;
                                    if (k == i) {
                                        seleccionAsiento[i].innerHTML += '<option selected value="' + asientosDisponibles[j] + '">Asiento nº ' + asientosDisponibles[j] + '</option>';
                                    }
                                }
                            }

                            if (!seleccionado) {
                                seleccionAsiento[i].innerHTML += '<option value="' + asientosDisponibles[j] + '">Asiento nº ' + asientosDisponibles[j] + '</option>';
                            }
                        }
                    }

                }


            }

        </script>

        <%!
            public static String getArray(Object[] items) {
                String result = "[";
                for (int i = 0; i < items.length; i++) {
                    result += "'" + items[i] + "'";
                    if (i < items.length - 1) {
                        result += ", ";
                    }
                }
                result += "]";

                return result;
            }
        %>
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
<!--                            <li class="dropdown"><a class="dropdown-toggle nav-link dropdown-toggle" data-toggle="dropdown" aria-expanded="false" href="#" style="color:rgb(255,255,255);font-size:18px;font-family:'Mate SC', serif;">Dropdown </a>
                                <div class="dropdown-menu" role="menu"><a class="dropdown-item" role="presentation" href="#">First Item</a><a class="dropdown-item" role="presentation" href="#">Second Item</a><a class="dropdown-item" role="presentation" href="#">Third Item</a></div>
                            </li>-->
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
        <form action="controladorDatosViaje" method="get" style="text-align: center" onsubmit="return comprobar()"> 
            <%
                int plazasReserva = (Integer) request.getSession().getAttribute("plazasReserva");

                List plazasDisponibles = (List) request.getSession().getAttribute("plazasDisponibles");

                for (int i = 0; i < plazasReserva; i++) {
            %>
            <div style="width: 60%; margin: 0 auto; text-align: center; background: white; height: 170px; margin-bottom: 10px; margin-top: 20px; opacity: 0.9">
                <div style="width: 50%;height: 100%;float: left; ">  

                    <h3>Pasajero <%=i + 1%></h3>
                    <input type="text" id="identificacion<%=i%>" required name="identificacion<%=i%>" pattern="(\d{8})([-]?)([A-Z]{1})" maxlength="9" minlength="9" placeholder="NIF/NIE" style="text-align: center;padding: 5px;" />
                    <br><br>
                    <input type="text" id="nombre<%=i%>" maxlength="25"  name="nombre<%=i%>" required placeholder="Nombre" style="text-align: center;padding: 5px;"                />
                    <input type="text" id="apellidos<%=i%>" name="apellidos<%=i%>" required placeholder="Apellidos" style="text-align: center;padding: 5px;"/>
                </div>
                <div style="float: left;width: 50%;height: 30px;">

                </div>
                <div style="width: 50%;height: 60%;" class="d-flex justify-content-center align-items-center">

                    <select style="padding: 10px;"  id="plazaViajero<%=i%>" name="plazaViajero<%=i%>" onchange="funcionSelect(<%=i%>,<%= getArray(plazasDisponibles.toArray(new Object[plazasDisponibles.size()]))%>);">
                        <option>Selecciona asiento</option>
                        <%
                            for (int j = 0; j < plazasDisponibles.size(); j++) {
                        %>
                        <option value="<%=plazasDisponibles.get(j)%>">Asiento nº <%=plazasDisponibles.get(j)%></option>
                        <%
                            }

                        %>
                    </select>

                </div>


            </div>
            <%            }
            %>
            <button type="submit" id="boton1" class="btn btn-primary">Continuar</button>
        </form>
        <div id="divlabel">
            <label type="text" id="label"></label>
        </div>
        <script>

            function comprobar() {
                var select = document.querySelectorAll('[id^="plazaViajero"]');
                var divlabel = document.getElementById("divlabel");
                var label = document.getElementById("label");
                var estado = true;

                for (var i = 0; i < select.length; i++) {
                    if (select[i].value === "Selecciona asiento") {
                        divlabel.setAttribute("style","width: 30%; margin: 0 auto; text-align: center; background: #ef887c; height: 50px; margin-bottom: 10px; margin-top: 20px; opacity: 0.9;border-radius: 2%;transition-duration:2s;");
                        label.innerHTML = "Seleccion un Asiento";
                        estado = false;
                    }
                }

                if (estado === false) {
                    return false;
                } else {
                    return true;
                }
            }

        </script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
    </body>

</html>