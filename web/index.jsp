<%-- 
    Document   : index
    Created on : 12/11/2013, 03:15:20 PM
    Author     : Ismael García Hernández (igh1@hotmail.com)
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javabeans.Usuario"%>
<!DOCTYPE>
<html>
    <head>
        <meta charset="UTF-8">
	<meta name="description" content="Ventanilla unica de gestión de trámites y servicios">
	<meta name="keywords" content="servicios, tramites, chetumal, quintana, roo">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
        <link href="imagenes/valid.png"  rel="shortcut icon" />
        <!--Estilos!-->
	<link rel="stylesheet" type="text/css" href="css/estilos.css"/> 
        <link rel="stylesheet" href="css/ui-lightness/jquery-ui-1.10.4.custom.min.css">
        
        <!-- framework jquery -->
        <script type="text/javascript" language="JavaScript" src="js/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" language="JavaScript" src="js/jquery.tablesorter.js"></script>
        <script src="js/jquery.confirm.js"></script>
        <script type="text/javascript" src="js/jquery-ui.js"></script>
        
        <!-- Librerias javaScript de la aplicacion tramites -->
        <script type="text/javascript" language="JavaScript" src="js/script_tramites.js"></script>
        
        <!-- Confirm 
        <script src="js/jquery.confirm.js"></script>
        <script src="js/script_confirm.js"></script>
        
        Alert         
        <script src="js/script_alert.js"></script>
        Fecha actual!-->
        
        <!--<script type="text/javascript" language="JavaScript" src="js/fechaActual.js"></script>!-->
        
        <link href='http://fonts.googleapis.com/css?family=Cuprum&amp;subset=latin' rel='stylesheet' type='text/css'>
        
        <!--<link rel="stylesheet" type="text/css" href="bootstrap-responsive.css">!-->
        
	<title>Trámites y servicios</title>
        

       
        
        <script> //Script para definir las áreas en donde se cargará el contenido
            $(document).ready(function(){
                $("#registro").click(function (event) {
                    event.preventDefault();
                    cargar('controladorregistro?operacion=capturar','#contenido');
                });
                
                $("#consultar").click(function (event) {
                    event.preventDefault();
                    cargar('controladorregistro?operacion=listar','#contenido');
                });
                
                $("#consolaadmin").click(function (event) {
                    event.preventDefault();
                    cargar('scr_admin.jsp','#contenido');
                });
                
                $("#reportes").click(function (event) {
                    event.preventDefault();
                    cargar('scr_reports.jsp','#contenido');
                });
            });
            
            
            function cargar(seccion, div){
                $.post(seccion, function(datos){
                    $(div).html(datos);
                });
            }
            
            window.addEventListener("load", cargar('fondo.html','#contenido') , false);
            
        </script>
    
   </head>

   
    <script>

          //usuario='{request.getAttribute.usuario.id_grupo}';
              usuario='${requestScope.usuario.usuario}';
              
                  //alert(usuario);
        </script>
        
    <body ><strong></strong>
	<header>
            
            <div id="subheader">
		<div id="logotipo"><a href="">SEDUVI <span class="secre"><br/>Secretaría de Desarrollo Urbano y Vivienda</span></a></div>
                <div id="sistema">Ventanilla Única de Gestión<br/> de Trámites y Servicios<br/>
                    <span class="secre" style="font-size: 12px; color:grey "><SPAN STYLE="font-weight: bold">USUARIO:</span>
                      
                        <script type="text/javascript">document.write(usuario);</script>
                        
                       
                        <a href="login.jsp"> <img src="imagenes/locked.png" class="btn-tabla" alt="Cerrar Sesión"  title="Cerrar Sesión"></a>
                    </span>
                </div>

		<nav>
                    <!--<div class="reporte"><a href="#">Reportes</a></div>!-->
                  
                    <div class="reporte" id="reportes"><a href="#">Reportes</a></div> 
                    <div class="admin" id="consolaadmin"><a href="#">Admin</a></div>
                    <div class="consulta" id="consultar"><a href="#">Consulta</a></div>
                    <div class="registra" id="registro" ><a href="#" >Registra</a></div>
                </nav>
                
            </div> <!--fin del subheader!-->
                
	</header> <!--fin del header!-->

	<section id="wrap"><!--Contenedor principal-->
            <section id="main"><!--Seccion Principal-->
                <div id="contenido"></div> <!--Vertedero princiapl-->
                
            </section>
            
            <footer> <!--Pie de página!-->
                <p>Sistema: Ventanilla Ünica de Gestión de Trámites y Servicios.<br>
                        Derechos reservados SEDUVI. Subsecretaría de Técnica, Chetumal, Q.Roo 2013.</p>
            </footer> <!--fin del pie de página-->
	            
	</section> <!--fin del wrap, contenedor princiapal!-->
 <!--<script src="js/jquery.confirm.js"></script>
        <script src="js/script_confirm.js"></script><!-->
     <script>
            
             usuario='${requestScope.usuario.usuario}';

                //alert(usuario);
                if (usuario=='RMENDEZ1972'){
                    document.getElementById("consolaadmin").style.display="none";
                    document.getElementById("registro_tramites").style.display="none";
                    
                }
        </script>
    </body>
</html>
