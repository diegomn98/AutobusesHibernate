<%-- 
    Document   : vistaErrores.jsp
    Created on : 03-mar-2019, 15:52:48
    Author     : diego
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html


    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<!DOCTYPE html>
<html>
    <head>
        <title>Error</title>
        <!--Made with love by Mutiullah Samim -->

        <!--Bootsrap 4 CDN-->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous"/>

        <!--Fontawesome CDN-->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous"/>

        <!--Custom styles-->
        <link rel="stylesheet" type="text/css" href="assets/css/css.css"/>

    </head>
    <body>
        <div class="container">
            <div class="d-flex justify-content-center h-100">
                <div class="card">
                    <div class="card-header">
                        <h3>Ha Habido un Error</h3>
                        <div class="d-flex justify-content-end social_icon">

                        </div>
                    </div>
                    <div class="card-body">
                        <form action="controladorLogin" method="get">
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <h4 style="text-align: center;color: yellow;">

                                        <%

                                            int id = Integer.parseInt(request.getParameter("id"));
                                            String mensaje = request.getParameter("mensaje");

                                            if (id == 1) {
                                        %><%=mensaje%><%
                                        } else if (id == 2) {
                                        %><%=mensaje%><%
                                        } else if (id == 3) {
                                        %><%=mensaje%><%
                                        } else if (id == 4) {
                                        %><%=mensaje%><%
                                        } else if (id == 5) {
                                        %><%=mensaje%><%
                                        } else if (id == 6) {
                                        %><%=mensaje%><%
                                        } else if (id == 7) {
                                        %><%=mensaje%><%
                                            }
                                        %>

                                    </h4>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="card-footer">
                        <div class="d-flex justify-content-center links">
                            <a href="index.jsp" style="color: rgb(50,205,50);">Volver al inicio</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>



    </body>
</html>

