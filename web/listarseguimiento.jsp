<%-- 
    Document   : listarseguimiento
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
                   titulo=$(this,"button").attr("titulo");//Se obtiene el id del botón para presentarlo como titulo del confirm
                   logo=$(this,"button").attr("id");
                   mensaje=$(this,"button").attr("mensaje");
                     

                   var url = $(this).attr('value'); //Obteniendo la opcion que ejecutará el controlador.
                   
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
                    <h1>Listado de Seguimientos de la Solicitud</h1>
                    Tramite: ${tramite.nombre}<br>
                    Solicitante: ${solicitante.nombre} ${solicitante.apellido_paterno} ${solicitante.apellido_materno}</a>
                </td>
                <td width="20%" align="right"> 
                    <div class="btn-catalogo">
                        <a href="controladorseguimiento?operacion=imprimir&id_solicitud=${solicitud.id_solicitud}" target="new"><img  src="imagenes/reportesb.png"  width="30" height="30"alt="Imprimir"/><p>Imprimir</p></a>
                    </div>
                    
                    <div class="btn-catalogo">
                        <button value="controladorseguimiento?operacion=capturar&id_solicitud=${solicitud.id_solicitud}" id="agregar" titulo="Confirme la adición." mensaje="Está Ud. seguro de agregar este seguimiento!"><img  src="imagenes/agregar.png" width="30" height="30" alt="agregar" title="agregar" /><p>Agregar</p></button>
                        <!--<a href= value="controladorseguimiento?operacion=capturar&id_solicitud=${solicitud.id_solicitud}" id="agregar" ><img  src="imagenes/agregar.png" width="30" height="30" alt="agregar" title="agregar" /><p>Agregar</p></a>!-->
                        
                    </div>
                </td>
            </tr>
             
        </table>
        
        <table id="seguimientos"  class="tablesorter" width="98%">
            <thead>
                <tr><th >Fecha</th><th>Observaciones</th><th>Estatus</th><th>Archivo adjunto</th><th>Acciones</th></tr>
            </thead>
            <tbody>
                <c:forEach var="seguimientos" items="${requestScope.seguimientos}" varStatus="loop"> 
                    <tr class="${loop.index % 2 == 0 ? 'odd' : 'impar'}"> 
                        <td width="8%"><c:out value="${seguimientos.fecha}" /></td> 
                        <td width="50%"><c:out value="${seguimientos.observaciones}" /></td>
                        
                        <c:choose>
                                <c:when test="${seguimientos.estatus=='TURNADO'}">
                                    <td width="10%" style="font-size: 8px"><div class="statusTurnado"><c:out value="${seguimientos.estatus}"/></td>
                                </c:when>
                                    
                                <c:when test="${seguimientos.estatus=='TRAMITE'}">
                                    <td width="10%" style="font-size: 8px"><div class="statusTramite"></div><c:out value="${seguimientos.estatus}"/></td>
                                </c:when>
                                    
                                <c:when test="${seguimientos.estatus=='CONCLUIDO'}">
                                    <td width="10%" style="font-size: 8px"><div class="statusConcluido"></div><c:out value="${seguimientos.estatus}"/></td>
                                </c:when>
                                    
                                <c:otherwise>
                                    <td width="10%" style="font-size: 8px"><c:out value="${seguimientos.estatus}"/>
                                </c:otherwise>
                                        
                            </c:choose>
                        
                    
                        
                        <td width="15%"><a href="${requestScope.pathadjuntos}${seguimientos.adjunto}" download="${seguimientos.adjunto}" ><c:out value="${seguimientos.adjunto}" /></a></td>
                        <td width="12%">
                            <button value="controladorseguimiento?operacion=localizar&id_seguimiento=${seguimientos.id_seguimiento}" id="editar"  titulo="Confirme la edición." mensaje="Está Ud. seguro de editar este seguimiento!">
                                <img class="btn-tabla" src="imagenes/editar.png" width="24" height="24" alt="editar" title="editar seguimiento" />
                            </button>
                            <button value="controladorseguimiento?operacion=borrar&id_seguimiento=${seguimientos.id_seguimiento}" id="eliminar" titulo="Confirme la eliminación." mensaje="Está Ud. seguro de eliminar este seguimiento!">
                                <img src="imagenes/eliminar.png"  class="btn-tabla" width="24" height="24" alt="Eliminar"  title="borrar seguimiento" />
                            </button>
                            <button value="controladorseguimiento?operacion=enviarcorreo&id_seguimiento=${seguimientos.id_seguimiento}" id="mail" titulo="Confirme el envio por correo." mensaje="Está Ud. seguro de enviar por correo este seguimiento!"><img src="imagenes/mail.png"  class="btn-tabla" width="24" height="24" alt="Enviar correo"  title="enviar correo" />
                            </button>
                        </td>
                    </tr>

                </c:forEach>
           </tbody>
        </table>

    </center>
    </body>
</html>
