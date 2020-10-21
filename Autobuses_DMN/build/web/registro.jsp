<%-- 
    Document   : registro
    Created on : 05-feb-2019, 9:56:16
    Author     : diego
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<!DOCTYPE html>
<html>
    <head>
        <title>Registro</title>
        <!--Made with love by Mutiullah Samim -->

        <!--Bootsrap 4 CDN-->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

        <!--Fontawesome CDN-->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">

        <!--Custom styles-->
        <link rel="stylesheet" type="text/css" href="assets/css/css.css">
    </head>
    <body>
        <div class="container">
            <div class="d-flex justify-content-center h-100">
                <div class="card">
                    <div class="card-header">
                        <h3>Registro</h3>
                        <div class="d-flex justify-content-end social_icon">
                            <span><i class="fab fa-facebook-square"></i></span>
                            <span><i class="fab fa-google-plus-square"></i></span>
                            <span><i class="fab fa-twitter-square"></i></span>
                        </div>
                    </div>
                    <div class="card-body">
                        <form action="controladorRegistro" method="get" onsubmit="return verificarPassword()">
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                </div>
                                <input type="text" id="usuario" maxlength="9" name="usuario" required pattern="(\d{8})([-]?)([A-Z]{1})" class="form-control" placeholder="Usuario">

                            </div>
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-key"></i></span>
                                </div>
                                <input type="password" maxlength="15" id="password" required name="password" class="form-control" placeholder="Contraseña">
                            </div>
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-key"></i></span>
                                </div>
                                <input type="password" maxlength="15" id="password1" required name="password1" class="form-control" placeholder="Confirmar Contraseña">
                            </div>
                            <div class="input-group form-group">
                                <div class="input-group-prepend">    
                                </div>
                                <input type="text" id="nombre" maxlength="25" required name="nombre" class="form-control" placeholder="Nombre">

                            </div>
                            <div class="input-group form-group">
                                <div class="input-group-prepend">    
                                </div>
                                <input type="text" maxlength="25" id="apellidos" required name="apellidos" class="form-control" placeholder="Apellidos">

                            </div>
                            <div class="input-group form-group">
                                <div class="input-group-prepend">    
                                </div>
                                <input type="text" maxlength="25" id="domicilio" required name="domicilio" class="form-control" placeholder="Domicilio">

                            </div>
                            <div class="input-group form-group">
                                <div class="input-group-prepend">    
                                </div>
                                <input type="email" maxlength="25" id="correo" required name="correo" class="form-control" placeholder="Email">

                            </div>
                            <div class="input-group form-group">
                                <div class="input-group-prepend">  
                                </div>
                                <input type="text" maxlength="9" id="telefono" required name="telefono" class="form-control" placeholder="Teléfono">

                            </div>
                            <div class="form-group">
                                <input type="submit" value="Registrarse" class="btn float-right login_btn">
                            </div>
                            
                        </form>
                    </div>
                    <div class="card-footer">
                        <div class="d-flex justify-content-center links">
                            <a href="login.jsp" style="color: rgb(50,205,50);">Volver atras</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    
    <script>
        
        function verificarPassword(){
            
            var password = document.getElementById("password").value;
            var password1 = document.getElementById("password1").value;
            
            if(password !== password1){
                alert("Verifica que las contraseñas coincidan");
                return false;
            }
            return true;
        }
        
    </script>
    
</html>
