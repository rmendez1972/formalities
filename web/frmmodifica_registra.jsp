<%-- 
    Document   : frmmoidifca_registra
    Created on : 12/11/2013, 03:08:25 PM
    Author     : Ismael García Hernández (igh1@hotmail.com)
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="javabeans.UnidadAdministrativa"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javabeans.Solicitante"%>
<%@page import="javabeans.Solicitud"%>
<%@page import="javabeans.Tramite"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- framework jquery -->
        <link rel="stylesheet" type="text/css" href="css/estilos.css"/>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
       
        <!-- framework jquery -->
      
        
        <script type="text/javascript" language="JavaScript" src="js/jquery.tablesorter.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.js"></script>  
        
        <!-- Librerias javaScript de la aplicacion tramites -->
        <script type="text/javascript" language="JavaScript" src="js/script_tramites.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.full.min.js"></script>
        
    
        
        
        <title>frm_registra</title>
        
        <script type="text/javascript">
            
            function semaforo(){
              
            }
               /* if (${solicitud.id_status}==1){
                    document.getElementById("semaforo").style.backgroundPosition="0px -195px";
            }
            
            if (${solicitud.id_status}==2){
                    document.getElementById("semaforo").style.backgroundPosition="0px -95px";
            }
            
            if (${solicitud.id_status}==3){
                    document.getElementById("semaforo").style.backgroundPosition="0px 0px";
            }*/
            
            
            $(document).ready(function()
            {
                
                var $select3 = $('.js-example-basic-single').select2();
        
                //evento change del selector unidadadtva
                $("#unidadadtva").change(function()
                {
                    //la respuesta viene del servlet tramites2
                    $.getJSON("tramites2", 
                    {
                        //evaluar el id de unidad administrativa del lado del modelo
                        id_unidadAdministrativa: $(this).val(),    
                        ajax: 'true'
                    },
                    function(data)
                    {
                                                
                        //limpiamos el selector para poblar
                        $("#tramites").html(" ");
                        $.each(data.Tramites, function(i,item){
                            $("#tramites").append("<option value='"+item.id_tramite+"'>"+item.nombre+"</option>");
                        });
                    });
                });
                //evento change del selector municipio
                $("#municipio").change(function()
                {
                   //la respuesta viene del servlet LocalidadesServelet
                    $.getJSON("localidades", 
                    {
                        //evaluar el id de unidad administrativa del lado del modelo
                        id_municipio: $(this).val(),    
                        ajax: 'true'
                    },
                    function(data)
                    {
                        //limpiamos el selector para poblar
                        $("#localidades").html(" ");
                        $.each(data.Localidades, function(i,item){
                            $("#localidades").append("<option value='"+item.id_localidad+"'>"+item.nombre+"</option>");
                        });
                    });
                });
                
                
                
                $('#registra').submit(function(event) 
                {  
                    event.preventDefault();  
                    var url = $(this).attr('action');  
                    var datos = $(this).serialize();  
                    $.post(url, datos, function(resultado) 
                    {  
                        $('#contenido').html(resultado);  
                    });  
                });  
                            
            });
        </script>
        
    </head>
    
       
        
    <body>

       
<div id="numSolic" style="float: left;height: 20px;width: 200px;margin-left: 10px">
    <button class="btn btn-primary" type="button">
        Solicitud Núm: <span class="badge">${solicitud.id_solicitud}</span>
    </button>
    
</div>
    

<div style="float: right">
    <div id="preview" style="float:right">
        <button value="controladorregistro?operacion=borrar&id_solicitud=${solicitud.id_solicitud}" id="eliminar"
            titulo="Confirme la eliminación." mensaje="Está Ud. seguro de borrar esta solicitud!" 
            onclick="$.post(document.getElementById('eliminar').value,function(resultado) {$('#contenido').html(resultado);},'html');">
            <img src="imagenes/eliminar.png" class="btn-tabla" alt="eliminacion"  title="Eliminar solicitud"/>
        </button>

        <button value="controladorseguimiento?operacion=listar&id_solicitud=${solicitud.id_solicitud}" id="listar" 
            titulo="Confirme listado de seguimiento." mensaje="Está Ud. seguro de listar los seguimientos de esta solicitud!"
            onclick="$.post(document.getElementById('listar').value,function(resultado) {$('#contenido').html(resultado);},'html');">
            <img src="imagenes/listar.png" class="btn-tabla" alt="lista" title="Listar seguimientos de la solicitud"/>
        </button>

        <button value="controladorregistro?operacion=verRequisitos&id=${solicitud.id_solicitud}" id="requisitos" 
                 titulo="Confirme listado de Requisitos." mensaje="Está Ud. seguro de listar los requisitos de esta solicitud!"

               onclick="$.post('controladorregistro?operacion=verRequisitos&id='+document.getElementById('tramites').value,function(resultado) {$('#contenido').html(resultado);},'html');">
                <!--onclick="alert(document.getElementById('tramites').value);">!-->

             <img src="imagenes/requisitos.png" class="btn-tabla" alt="requisitos" title="Listar Requisitos de la solicitud"/>
        </button>

        <button value="controladorregistro?operacion=enviarcorreo&id_solicitud=${solicitud.id_solicitud}" id="mail"
                 titulo="Confirme el envió." mensaje="Está Ud. seguro de enviar los requisitos por email!"
                 onclick="$.post(document.getElementById('mail').value,function(resultado) {$('#contenido').html(resultado);},'html');">
             <img src="imagenes/mail.png"  class="btn-tabla" width="24" height="24" alt="Enviar requisitos por correo"  title="Enviar requisitos por correo"/> 
        </button>  


    </div>
</div>



<div style="float: left;width:100%">
    <h1>Datos del solicitante</h1>
</div>
                 <form name="registra" id="registra" action="controladorregistro?operacion=modificar"  method="post">
                     <table style="width:100%">
                         <tr style="width:90%">
            <td style="width:30%">Nombre:</td>
                <td style="width:30%">Apellido paterno:</td>
                <td style="width:30%">Apellido materno:</td>
                </tr>
                <tr style="width:90%">
                    <td style="width:30%"><input style="width:80%" name="nombre" id="nombre" type="text" size="20" maxlength="15" autofocus required pattern="([a-zA-ZñÑáéíóúÁÉÍÓÚ ]{3,15})" placeholder="Mínimo 3 caracteres" value="${solicitante.nombre}" ><input name="id_solicitante" id="id_solicitante" type="hidden" size="20" maxlength="15" value="${solicitante.id_solicitante}" ></td>
                    <td style="width:30%"><input style="width:80%" name="apellido_p" id="apellido_p" type="text" size="20" pattern="([a-zA-ZñÑáéíóúÁÉÍÓÚ ]{2,15})" maxlength="15" required placeholder="Mínimo 2, max. 15 letras" value="${solicitante.apellido_paterno}"></td>
                    <td style="width:30%"><input style="width:80%" name="apellido_m" id="apellido_m" type="text" size="20" pattern="([a-zA-ZñÑáéíóúÁÉÍÓÚ ]{2,15})"  maxlength="15" placeholder="Mínimo 2, max. 15 letras" value="${solicitante.apellido_materno}"></td>
                    
                </tr>
                <tr style="width:90%">
                    <td style="width:30%">RFC:</td>
                    <td style="width:30%">Sexo:</td>
                </tr>
                
                <tr style="width:90%">
                    <td style="width:30%"><input style="width:80%" name="rfc" id="rfc" type="text" size="20" pattern="^[a-zA-Z]{3,4}(\d{6})((\D|\d){3})?$" maxlength="13" placeholder="XXX?AAMMDD???" title="ejemplo: GAHI691125PQ9"value="${solicitante.rfc}" ></td>
                    <td style="width:30%">
                        
                        <select style="width:80%;height: 50px;" name="sexo" id="sexo">
                            <c:forEach  var="sexo" items="${requestScope.sexo}">
                                <OPTION VALUE="${sexo.clave}" ${solicitante.sexo == sexo.clave ? 'selected' : ''}>${sexo.descripcion}</OPTION>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                
    </table>
    
    <p>
            <br><h1>Datos del contacto</h1></p> 
        <table style="width:100%">
            <tr style="width:90%">
                    <td style="width:30%">Domicilio:</td>
                    <td style="width:30%">Municipio:</td>
                    <td style="width:30%">Localidad:</td>
                </tr>
                <tr style="width:90%">
                    <td style="width:30%"><textarea textarea style="width:80%;height: 50px;" name="domicilio" id="domicilio"  rows="4" pattern="([a-zA-ZñÑáéíóúÁÉÍÓÚ ]{20,150})" required maxlength="150" placeholder="Escriba una dirección válida" title="No es una dirección válida" >${solicitante.direccion}</textarea></td>
      
                    
                    <td style="width:30%">
                        <select style="width:80%" name="municipio" id="municipio" required class="js-example-basic-single">
                            <option value="" selected="selected" >Selecciona una opción del catálogo...</option>
                            <c:forEach  var="mun" items="${requestScope.mun}">
                                <OPTION VALUE="${mun.id_municipio}" ${localidad.id_municipio== mun.id_municipio ? 'selected' : ''}>${mun.nombre}</OPTION>

                            </c:forEach>
                        </select>
                    </td>
                    <td style="width:30%" >
                        <select style="width:80%" name="localidades" id="localidades" class="js-example-basic-single">
                                <c:forEach  var="loc" items="${requestScope.loc}">
                                    <OPTION VALUE="${loc.id_localidad}" ${localidad.id_localidad == loc.id_localidad ? 'selected' : ''} >${loc.nombre_localidad}</OPTION>
                                 </c:forEach>
                        </select>
                    </td> 
                </tr>
            <tr style="width:90%">
                <td style="width:30%">Teléfono:</td>
                <td style="width:30%">Email:</td>
                <td style="width:30%">PASSWORD:</td>
            </tr>
            <tr style="width:90%">
                <td style="width:30%"><input style="width:80%" name="telefono" id="telefono" type="tel" size="20" pattern="([0-9]{10})" maxlength="10" placeholder="Escriba 10 dígitos" value="${solicitante.telefono}"></td>
                <td style="width:30%"><input style="width:80%" name="email" id="email" type="email" size="20" pattern="^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$" maxlength="60" placeholder="ejemplo@ejemplo.com"value="${solicitante.email}"></td>
                <td style="width:30%" ><input style="width:80%"name="password" id="password" type="text" size="20" pattern="([a-zA-ZñÑáéíóúÁÉÍÓÚ\0-9]{8,15})" maxlength="15" placeholder="Password para api. 8 caracteres" title="password" value="${solicitante.password}" ></td>
            </tr>
            
        </table>

        <p>
        <br><h1>Datos del trámite</h1></p>
        <table style="width:100%">
            <tr style="width:90%">
                <td style="width:30%">Subsecretaría:</td>
            </tr>
            <tr style="width:90%">
                <td style="width:30%">
                    <select name="unidadadtva" id="unidadadtva" class="js-example-basic-single">
                        <c:forEach  var="ua" items="${requestScope.ua}">
                          <OPTION VALUE="${ua.id_unidadAdministrativa}" ${tramite.id_unidadadministrativa == ua.id_unidadAdministrativa ? 'selected' : ''}>${ua.nombre}</OPTION>
                        </c:forEach>
                    </select>
                </td> 
            </tr>
            <tr>
            <td>&nbsp;</td>
            <td colspan="2">
          </tr>
            <tr style="width:90%">
                <td style="width:30%">Trámite:</td>
            </tr>
            <tr style="width:90%">
                <td style="width:30%" >
                    <select name="tramites" id="tramites" class="js-example-basic-single">
                        <c:forEach  var="tm" items="${requestScope.tm}">
                          <OPTION VALUE="${tm.id_tramite}" ${tramite.id_tramite == tm.id_tramite ? 'selected' : ''} >${tm.nombre}</OPTION>
                        </c:forEach>
                    </select>
                </td> 
            </tr>

            <tr>
            <td>&nbsp;</td>
            <td colspan="2">
          </tr>
          <tr style="width:90%">
            <td>Fecha de registro:</td>
          </tr>

          <tr>
              <td>
                  <input type="date" name="fecha_r" id="fecha_r" value="${solicitud.fecha_ingreso}" required>
              </td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td colspan="2">
          </tr>
          <tr style="width:90%">
            <td >Estatus</td>
          </tr>
          <tr>
              <td>
                  <input name="id_solicitud" id="id_solicitud" type="hidden" size="20" maxlength="15" value="${solicitud.id_solicitud}" >
                  <input name="id_status" id="id_status" type="hidden"  value="${solicitud.id_status}" >
              </td>
          </tr>
          <div> 
            <c:choose>
                <c:when test="${solicitud.id_status=='1'}">
                    <!--<td width="8%" style="font-size: 8px"><div class="statusTurnado"></div><div class="circulo"></div><div class="circulo"></div><c:out value="${solicitudes.status}"/></td>-->
                    <td style="font-size: 14px;text-align: center; color:#FF0000;"><div class="colorturnado circulo turnado"></div>Turnado</td>
                </c:when>
                <c:when test="${solicitud.id_status=='2'}">
                    <!--<td width="8%"style="font-size: 8px;text-align: center;"><div class="circulo"></div><div class="statusTramite"></div><div class="circulo"></div><c:out value="${solicitudes.status}"/></td>-->
                    <td style="font-size: 14px;text-align: center; color:#FFBF00;"><div class="circulo tramite"></div>Tramite</td>
                </c:when>
                <c:when test="${solicitud.id_status=='3'}">
                    <!--<td width="8%"style="font-size: 8px"><div class="circulo"></div><div class="circulo"></div><div class="statusConcluido"></div><c:out value="${solicitudes.status}"/></td>-->
                <td style="font-size: 14px;text-align: center; color:#00FF00;"><div class="circulo concluido"></div>Concluido</td>
                </c:when> 

                <c:when test="${solicitud.id_status=='4'}">
                    <td style="font-size: 14px;text-align: center; color:#2E9AFE;"><div class="circulo inconcluso"></div>Inconcluso</td>
                </c:when> 
                <c:when test="${solicitud.id_status=='5'}">
                <td style="font-size: 14px;text-align: center; color:#8258FA;"><div class="circulo revertido"></div>Revertido</td>
                </c:when>         

                <c:otherwise>
                    <!--<td width="8%" ><c:out value="${solicitud.id_status}"/></td>-->
                </c:otherwise>
            </c:choose>
       </div>
          <tr>
            <td>&nbsp;</td>
            <td colspan="2">
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td colspan="2">
          </tr>
          <td style="text-align: center">
        <input type="submit" name="enviarrequisitos" id="enviarrequisitos" value="Modificar solicitud" class="botona" style="margin-left: 20%">
    </td>
    
          </table>


</form>
    
</body>
</html>
