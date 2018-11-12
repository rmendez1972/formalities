<%-- 
    Document   : index
    Created on : 12/11/2013, 03:15:20 PM
    Author     : Ismael García Hernández (igh1@hotmail.com)
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javabeans.Usuario"%>
<!DOCTYPE>
<html>
    <head>
        <meta charset="UTF-8">
	<meta name="description" content="Ventanilla unica de gestión de trámites y servicios">
	<meta name="keywords" content="servicios, tramites, chetumal, quintana, roo">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="imagenes/valid.png"  rel="shortcut icon" />
        <!--Estilos!-->
        <script src="https://code.jquery.com/jquery-3.3.1.js" integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60=" crossorigin="anonymous"></script>
        
        <link href="css/bootstrap.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css/estilos.css"/> 
        <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/ui-lightness/jquery-ui.css">
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js" 
                integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="
        crossorigin="anonymous"></script>
        
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.15/css/jquery.dataTables.css">
        
        
        <!-- framework jquery -->
        <script type="text/javascript" language="JavaScript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.tablesorter/2.31.0/js/jquery.tablesorter.min.js"></script>
        
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.js"></script>     
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
       
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.full.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        
        <script type="text/javascript" charset="utf-8" src="//cdn.datatables.net/1.10.15/js/jquery.dataTables.js"></script>
        
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
                    cargar('controladoradministrador?operacion=mostrarAdmin','#contenido');
                });
                
                $("#consolaadminventanilla").click(function (event) {
                    event.preventDefault();
                    cargar('controladoradministrador?operacion=mostrarVentanilla','#contenido');
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
        
	<header style="width:100%;height: 120px;">
            
            <div style="width:90%;height: auto;" id="subheader">
		<div style="width:20%;height:120px;" id="logotipo"></div>
                <div style="width:30%;height:120px;" id="sistema"> Trámites y Servicios
                    <div  style="font-size: 12px; color:#000; margin-top: 5px"><strong>USUARIO:</strong>
                      
                        <script type="text/javascript">document.write(usuario+'    ');</script>
                        
                       
                        <a href="login.jsp"> <img src="imagenes/locked.png" class="btn-tabla" alt="Cerrar Sesión"  title="Cerrar Sesión"></a>
                    </div>
                </div>
                
		<nav >
                    <div class="reporte" id="reportes"><a href="#">Reportes</a></div> 
                    <div class="admin" id="consolaadmin"><a href="#">Catálogos</a></div>
                    <div class="admin" id="consolaadminventanilla" style="display:none"><a href="#">Catálogos</a></div>
                    <div class="consulta" id="consultar"><a href="#">Consulta</a></div>
                    <div class="registra" id="registro" ><a href="#" >Registra</a></div>
                </nav>
                
            </div> <!--fin del subheader!-->
                
	</header> <!--fin del header!-->

	<section id="wrap"><!--Contenedor principal-->
            <section style="width:100%;height: auto;" id="main"><!--Seccion Principal-->
                
                <div  id="contenido"></div> <!--Vertedero princiapl-->
                
            </section>
            
            <footer >  <!--Pie de página!-->
                <p>Sistema: Trámites y Servicios.<br>
                    Derechos reservados SEDETUS. Subsecretaría de Técnica, Dirección de Informática. Departamento de Sistemas Chetumal, Q.Roo 2017.
                    
                </p>
            </footer> <!--fin del pie de página-->
	            
	</section> <!--fin del wrap, contenedor princiapal!-->
 <!--<script src="js/jquery.confirm.js"></script>
        <script src="js/script_confirm.js"></script><!-->
     <script>
            
            id_grupo='${requestScope.id_grupo}';

            if (id_grupo==2){
                document.getElementById("consolaadmin").style.display="none";
                document.getElementById("registro").style.display="none";
                    
            }
            
            if (id_grupo==4){
                document.getElementById("consolaadmin").style.display="none";
                document.getElementById("reportes").style.display="none";
                document.getElementById("consolaadminventanilla").style.display="inline";
            }
            
        </script>
    </body>
</html>
