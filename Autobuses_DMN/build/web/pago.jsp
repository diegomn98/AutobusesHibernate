<%-- 
    Document   : pago
    Created on : 12-feb-2019, 9:05:26
    Author     : diego
--%>

<%@page import="java.util.Set"%>
<%@page import="POJO.Tarjeta"%>
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

        <style>
            body {
                /******************************************************************
          This contains the font, Internet Explorer fall back options and 
          the background color for all of the sites
          ******************************************************************/
                background: #C3E6F3 no-repeat center center fixed;
                margin: 0 auto;
                font-family: "Lucida Sans Unicode", "Lucida Grande", "sans-serif";
                /* IE Fallback */
                background: #c3e6f4;
                width: 100%;
                height: 100%;
            }
            /******************************************************************
            Below is the code for the red and blue button class which will be 
            for all of the buttons in the program including the submit, next,
            cancel, etc. 
            ******************************************************************/

            .blueButton {
                -moz-box-shadow: inset 0px -3px 7px 0px #29bbff;
                -webkit-box-shadow: inset 0px -3px 7px 0px #29bbff;
                box-shadow: inset 0px -3px 7px 0px #29bbff;
                background-color: #0088BB;
                -moz-border-radius: 3px;
                -webkit-border-radius: 3px;
                border-radius: 3px;
                border: 1px solid #0088BB;
                display: inline-block;
                cursor: pointer;
                color: #fff;
                font-family: Arial;
                font-size: 15px;
                padding: 9px 23px;
                text-decoration: none;
                text-shadow: 0px 1px 0px #263666;
            }

            .blueButton:hover {
                background-color: #369cb8;
            }

            .blueButton:active {
                position: relative;
                top: 1px;
            }

            /******************************************************************
            Below is the code for the confirm order page, it displays the material ID and cost of the order
            ******************************************************************/

            .payment input[type=text] {
                width: 95%;
                padding: 12px 20px;
                margin: 8px 0;
                display: block;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                resize: none;
                text-align: left;
            }

            .payment input[type=text]:focus {
                border: 1px solid #a8a8a8;
            }

            .payment input[type=submit],
            .payment input[type=button] {
                float: right;
                margin: -20px 20px 10px 0px;
            }

            .payment {
                border-radius: 5px;
                background-color: #f8f8f8;
                padding: 40px;
                width: 40%;
                margin: 0 auto;
                margin-top: 20px;
                margin-bottom: 20px;
                box-shadow: 1px 1px 5px #888888;
            }

            .payment select{
                margin-bottom: 10px;
            }


            /******************************************************************
            Below is the form for the confirm order table 
            ******************************************************************/

            /* CSS for Credit Card Payment form */
            .credit-card-box .panel-title {
                display: inline;
                font-weight: bold;
            }
            .credit-card-box .form-control.error {
                border-color: red;
                outline: 0;
                box-shadow: inset 0 1px 1px rgba(0,0,0,0.075),0 0 8px rgba(255,0,0,0.6);
            }
            .credit-card-box label.error {
                font-weight: bold;
                color: red;
                padding: 2px 8px;
                margin-top: 2px;
            }
            .credit-card-box .payment-errors {
                font-weight: bold;
                color: red;
                padding: 2px 8px;
                margin-top: 2px;
            }
            .credit-card-box label {
                display: block;
            }
            /* The old "center div vertically" hack */
            .credit-card-box .display-table {
                display: table;
            }
            .credit-card-box .display-tr {
                display: table-row;
            }
            .credit-card-box .display-td {
                display: table-cell;
                vertical-align: middle;
                width: 50%;
            }
            .credit-card-box .panel-heading img {
                min-width: 180px;
            }
        </style>

        <%
            Cliente cliente = ((List<Cliente>) request.getSession().getAttribute("inicioSesion")).get(0);

            if (!cliente.getTarjetas().isEmpty()) {


        %>

        <form action="controladorPago" method="get" id="form" class="payment" onsubmit="return comprobar()">
            <div class="panel panel-default credit-card-box">
                <div class="panel-heading display-table">
                    <div class="row display-tr">
                        <h3 class="panel-title display-td">Detalles del Pago</h3>
                        <img class="img-responsive pull-right" src="http://i76.imgup.net/accepted_c22e0.png">
                    </div>
                </div>
            </div>
            <br>
            <label for="cardNumber">TARJETAS USADAS</label>
            <select class="form-control" name="tarjetas" id="tarjetas" onchange="seleccionarTarjeta(this.value)" required autofocus>
                <option value="0" selected="">Elige una tarjeta</option> 
                <%  try {

                        for (Tarjeta tarjeta : (Set<Tarjeta>) cliente.getTarjetas()) {


                %>
                <option value="<%= tarjeta.getId()%>">Tipo:<%= tarjeta.getTipo()%> Número: XXXX-XXXX-XXXX-<%= tarjeta.getNumero().substring(12)%></option>
                <%  }
                    } catch (Exception e) {
                        out.print(e.getMessage());
                    }
                %>
            </select>
            <label for="cardNumber">TIPO DE TARJETA</label>
            <select class="form-control" name="typeCard" id="typeCard" required autofocus>
                <option selected="">Elige el Tipo de Tarjeta</option> 
                <option>MasterCard</option>
                <option>Visa</option>
                <option>Discover</option>
                <option>American Express</option>
            </select>
            <label for="cardNumber">NÚMERO DE TARJETA</label>
            <input type="text" size="10" class="form-control" maxlength="16" pattern="[0-9]{16}" id="cardNumber" name="cardNumber" placeholder="Número de Tarjeta Válido" autocomplete="cc-number" required autofocus />
            <span class="input-group-addon"><i class="fa fa-credit-card"></i></span>
            <label for="cardExpir">FECHA DE CADUCIDAD</label>
            <input type="text" size="5" data-date-format="DD YY" class="form-control" minlength="5" maxlength="5" id="cardExpiry" name="cardExpiry" pattern="^(0[1-9]{1}|1[0-2]{1})/\d{2}$" placeholder="MM / YY" autocomplete="cc-exp" required />
            <label for="cardCVC">CVV</label>
            <input type="text" size="3" minlength="3" maxlength="3" class="form-control" pattern="[0-9]{3}" name="cardCVV" placeholder="CVV" autocomplete="cc-csc" required />
            <br>
            <button class="blueButton" style="float:right;" type="submit">Confirmar Pago</button>
            <br><br>
        </form>
        <%
        } else {
        %>

        <form action="controladorPago" method="get" id="form" class="payment" onsubmit="return comprobar()">
            <div class="panel panel-default credit-card-box">
                <div class="panel-heading display-table">
                    <div class="row display-tr">
                        <h3 class="panel-title display-td">Detalles del Pago</h3>
                        <img class="img-responsive pull-right" src="http://i76.imgup.net/accepted_c22e0.png">
                    </div>
                </div>
            </div>
            <br>
            <label for="cardNumber">TIPO DE TARJETA</label>
            <select class="form-control" name="typeCard" id="typeCard" required autofocus>
                <option selected="">Elige el Tipo de Tarjeta</option> 
                <option>MasterCard</option>
                <option>Visa</option>
                <option>Discover</option>
                <option>American Express</option>
            </select>
            <label for="cardNumber">NÚMERO DE TARJETA</label>
            <input type="text" size="10" class="form-control" maxlength="16" pattern="[0-9]{16}" id="cardNumber" name="cardNumber" placeholder="Número de Tarjeta Válido" autocomplete="cc-number" required autofocus />
            <span class="input-group-addon"><i class="fa fa-credit-card"></i></span>
            <label for="cardExpir">FECHA DE CADUCIDAD</label>
            <input type="text" size="5" data-date-format="DD YY" class="form-control" minlength="5" maxlength="5" id="cardExpiry" name="cardExpiry" pattern="^(0[1-9]{1}|1[0-2]{1})/\d{2}$" placeholder="MM / YY" autocomplete="cc-exp" required />
            <label for="cardCVC">CVV</label>
            <input type="text" size="3" minlength="3" maxlength="3" class="form-control" pattern="[0-9]{3}" name="cardCVV" placeholder="CVV" autocomplete="cc-csc" required />
            <br>
            <button class="blueButton" style="float:right;" type="submit">Confirmar Pago</button>
            <br><br>
        </form>
        <%
            }
        %>
        <!-- If you're using Stripe for payments -->
        <script type="text/javascript" src="https://js.stripe.com/v2/"></script>

        <script>

            function comprobar() {
                var select = document.getElementById("typeCard").value;
                if (select == "Elige el Tipo de Tarjeta") {
                    alert("Elige una opción de tarjeta");
                    return false;
                }
                return true;
            }
            
            

            function seleccionarTarjeta(valor) {

                if (valor === "0") {
                    document.getElementById("cardNumber").disabled = false;
                    document.getElementById("typeCard").disabled = false;
                    document.getElementById("cardExpiry").disabled = false;
                    document.getElementById("form").setAttribute("onsubmit", "return comprobar()");
                } else {
                    document.getElementById("cardNumber").disabled = true;
                    document.getElementById("typeCard").disabled = true;
                    document.getElementById("cardExpiry").disabled = true;
                    document.getElementById("form").removeAttribute("onsubmit");
                }

            }
        </script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
    </body>

</html>