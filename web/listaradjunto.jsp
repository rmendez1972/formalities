<%-- 
    Document   : listaradjunto
    Created on : 21/11/2013, 02:32:54 PM
    Author     : Rafael Mendez
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        
        <!-- framework jquery -->
        <script type="text/javascript" language="JavaScript" src="js/jquery-1.7.2.js"></script>
        <script type="text/javascript" language="JavaScript" src="js/jquery.tablesorter.js"></script>
        <script type="text/javascript" language="JavaScript" src="js/jquery.confirm.js"></script>
        <script type="text/javascript" language="JavaScript" src="js/script_confirm.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--<link rel="stylesheet" type="text/css" href="css/estilos.css"/>!-->
        
        <!--Estilos!-->
	<link rel="stylesheet" type="text/css" href="css/estilos.css"/> 
       
        <title>Listado de Seguimientos</title>
        
        <script>
            /*variable que trae la bandera de exito o fracaso del modelo*/
            var mensaje='${requestScope.mensaje}';
            if (mensaje!=null)
            {
                alert (mensaje);
            }
            
            
            $(document).ready(function(){         
                $("#seguimientos").tablesorter();
                
                $(":button").click(function(event) 
                {  
                   event.preventDefault();
                   titulo=$(this,"button").attr("titulo");//Se obtiene el id del bot�n para presentarlo como titulo del confirm
                   logo=$(this,"button").attr("id");
                   mensaje=$(this,"button").attr("mensaje");
                     

                   var url = $(this).attr('value'); //Obteniendo la opcion que ejecutar� el controlador.
                   
                   //Invocamos al confirm personalizado pasandole parametros
                   confirma(url, titulo,mensaje,logo,
                                function(url)
                                {
                                    $.post(url,function(resultado) 
                                    {  
                                        $('#contenido').html(resultado);  
                                    });
                                    return true;
                                });
                   

                
                });
                
            }); 
            
        </script>
    </head>
    <body>
        <center> 
        
        <br>
        <table border=0 width="98%">
            <tr>
                <td width="80%" align="left"> 
                    <h1>Listado de Adjuntos del Seguimiento</h1>
                    <p style="padding:0.1em"><strong>N�m. Solicitud: </strong>${solicitud.id_solicitud}</p>
                    <p style="padding:0.1em"><strong>Tramite: </strong>${tramite.nombre}</p>
                    <p style="padding:0.1em"><strong>Solicitante:</strong> ${solicitante.nombre} ${solicitante.apellido_paterno} ${solicitante.apellido_materno}</p>
                    <p style="padding:0.1em"><strong>Subsecretar�a: </strong>${tramite.unidadAdministrativa}</p>
                    <p style="padding:0.1em"><strong>Direcci�n:</strong> ${tramite.direccion}</p><br>
                    <p style="padding:0.1em"><strong>Seguimiento:</strong> ${seguimiento.observaciones}</p>
                    <p style="padding:0.1em"><strong>Fecha de Seguimiento:</strong> ${seguimiento.fecha}</p>
                </td>
                <td width="20%" align="right"> 
                    <div class="btn-catalogo">
                        <a href="controladorseguimiento?operacion=imprimir&id_solicitud=${solicitud.id_solicitud}" target="new"><img  src="imagenes/reportesb.png"  width="30" height="30"alt="Imprimir"/><p>Imprimir</p></a>
                    </div>
                    
                    <div class="btn-catalogo">
                        <button value="controladorseguimiento?operacion=capturar&id_solicitud=${solicitud.id_solicitud}" id="agregar" titulo="Confirme la adici�n." mensaje="Est� Ud. seguro de agregar este seguimiento!"><img  src="imagenes/agregar.png" width="30" height="30" alt="agregar" title="agregar" /><p>Agregar</p></button>
                        <!--<a href= value="controladorseguimiento?operacion=capturar&id_solicitud=${solicitud.id_solicitud}" id="agregar" ><img  src="imagenes/agregar.png" width="30" height="30" alt="agregar" title="agregar" /><p>Agregar</p></a>!-->
                        
                    </div>
                </td>
            </tr>
             
        </table>
        
        <table id="adjuntos"  class="tablesorter" width="98%">
            <thead>
                <tr><th >Nombre del Archivo Adjunto</th><th >Usuario que Adjunta</th><th >Acciones</th></tr>
            </thead>
            <tbody>
                <c:forEach var="adjunto" items="${requestScope.adjuntos}" varStatus="loop"> 
                    <tr class="${loop.index % 2 == 0 ? 'odd' : 'impar'}"> 
                        <td width="50%"><a href="${requestScope.pathadjuntos}${adjunto.nombre}" download="${adjunto.nombre}" ><c:out value="${adjunto.nombre}" /></a></td> 
                        <td width="30%"><c:out value="${adjunto.nombreusuario}" /></td> 
                        <td width="20%">
                            
                            <button value="controladoradjunto?operacion=eliminar&id_adjunto=${adjunto.id_adjunto}" id="eliminar" titulo="Confirme la eliminaci�n." mensaje="Est� Ud. seguro de eliminar este adjunto!">
                                <img src="imagenes/eliminar.png"  class="btn-tabla" width="24" height="24" alt="Eliminar"  title="borrar adjunto" />
                            </button>
                            
                        </td>
                    </tr>

                </c:forEach>
           </tbody>
        </table>

    </center>
    </body>
</html>
