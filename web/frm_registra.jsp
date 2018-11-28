<%-- 
    Document   : frm_registra
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
<%@page import="javabeans.Municipio"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- framework jquery
        <script type="text/javascript" language="JavaScript" src="js/jquery-1.10.2.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/estilos.css"/> -->
        <title>frm_registra</title>
        
        <script type="text/javascript">
            
            $(document).ready(function()
            {
                
                $("#loading").hide();
                var $select2 = $('.js-example-basic-single').select2();
                
                $( "#adjunto" ).click(function() {
                    $("#loading").show('slow');
                });
                
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
                
                
                /*$('#registra').submit(function(event) 
                {  
                    event.preventDefault();  
                    var url = $(this).attr('action');  
                    var datos = $(this).serialize();  
                    $.post(url, datos, function(resultado) 
                    {  
                        $('#contenido').html(resultado);  
                    });  
                });*/
                
                $("form#registra").submit(function()
                {
                    $(this).find("button[type='submit']").prop('disabled',true);
                    var formData = new FormData($(this)[0]);
                    $.ajax(
                    {
                    
                        url: $(this).attr('action'),
                        type: 'POST',
                        data: formData,
                        async: false,
                        success: function (resultado) 
                        {
                        
                            $('#contenido').html(resultado);  
                        },
                        cache: false,
                        contentType: false,
                        processData: false
                    });

                    return false;
                });
                
                            
            });
            
            
        </script>
        
         <script> //obtener la fecha actual y asignarla al elemento fecha_r(date) 
            f=new Date();
            var mes="";
            var dia="";
            mes=(f.getMonth() +1);
            dia=(f.getDate());
            if ((f.getMonth() +1)<10){
                mes="0"+(f.getMonth() +1);
                
            }
             if (f.getDate()<10){
                 dia="0"+(f.getDate());
             }
             
                //if (f.getDate()<10){
                  //  var fecha=(f.getFullYear()+ "-"+ (f.getMonth() +1) + "-0" +f.getDate());
               // }
                //else{
                  //  var fecha=(f.getFullYear()+ "-"+ (f.getMonth() +1) + "-" +f.getDate());
                //}
                var fecha=(f.getFullYear()+ "-"+ mes+ "-" +dia);
           //alert(fecha);    
           
           document.getElementById('fecha_r').value=fecha;
        </script>

   
    </head>  
    
    <body>
        <!--<div id="frm_titulo">Datos del solicitante</div>-->
        <form name="registra" id="registra" action="controladorregistro?operacion=grabar"  method="post" width="100%">
            <h1>Datos del solicitante</h1>
            <table style="width:100%">
                
                <tr style="width:90%">
                    <td style="width:30%">Nombre:</td>
                    <td style="width:30%">Apellido paterno:</td>
                    <td style="width:30%">Apellido materno:</td>
                </tr>
                <tr style="width:90%">
                    <td style="width:30%"><input style="width:80%" name="nombre" id="nombre"  type="text" size="20" maxlength="30" autofocus required  placeholder="Mínimo 3 caracteres"></td>
                    <td style="width:30%"><input style="width:80%" name="apellido_p" id="apellido_p" type="text" size="20"  maxlength="15" placeholder="Mínimo 2, max. 15 letras"></td>
                    <td style="width:30%"><input style="width:80%" name="apellido_m" id="apellido_m" type="text" size="20" maxlength="15" placeholder="Mínimo 2, max. 15 letras"></td>
                </tr>
                <tr style="width:90%">
                    <td style="width:30%">Sexo:</td>
                    <td style="width:30%">RFC:</td>
                </tr>
                
                <tr style="width:90%">
                    <td style="width:30%">
                        <select style="width:80%;height: 50px;" name="sexo" id="sexo" required >
                            <!--<option value="0" selected="selected">Selecciona una opción.</option>!-->
                            <option value="">Seleccione una opción.</option>
                            <option value="M">MUJER</option>
                            <option value="H">HOMBRE</option>
                        </select>
                    </td>
                    <td style="width:30%"><input style="width:80%"name="rfc" id="rfc" type="text" size="20" pattern="^[a-zA-Z]{3,4}(\d{6})((\D|\d){3})?$" maxlength="13" placeholder="XXX?AAMMDD???" title="ejemplo: GAHI691125PQ9"></td>
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
                    <td style="width:30%"><textarea style="width:80%;height: 50px;" type="text" name="domicilio" id="domicilio" rows="4" maxlength="200"required  placeholder="Solo letras" title="No es una dirección válida"></textarea></td>
                    
                    <td style="width:30%">
                        <select style="width:80%"  name="municipio" id="municipio" required class="js-example-basic-single">
                            <option value="" selected="selected" >Selecciona una opción del catálogo...</option>
                            <c:forEach  var="mun" items="${requestScope.mun}">
                                <option   required value="${mun.id_municipio}">${mun.nombre}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <td style="width:30%" >
                        <select style="width:80%"  name="localidades" id="localidades" required class="js-example-basic-single">
                            <option value="" selected="selected">Selecciona una opción del catálogo...</option>
                        </select>
                    </td> 
                </tr>
            <tr style="width:90%">
                <td style="width:30%">Teléfono:</td>
                <td style="width:30%">Email:</td>
                <td style="width:30%">PASSWORD:</td>
            </tr>
            <tr style="width:90%">
                <td style="width:30%"><input style="width:80%" name="telefono" id="telefono" type="tel" size="20" pattern="([0-9]{10})" maxlength="10" placeholder="Escriba 10 dígitos"></td>
                <td style="width:30%"><input style="width:80%" name="email" id="email" type="email" size="20" pattern="^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$" maxlength="60" placeholder="ejemplo@ejemplo.com"></td>
                <td style="width:30%"><input style="width:80%" name="password" id="password" type="text" size="20" pattern="([a-zA-ZñÑáéíóúÁÉÍÓÚ\0-9]{8,15})" maxlength="15" placeholder="Password para api" title="Password para api"></td>
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
                    <select name="unidadadtva" id="unidadadtva" required class="js-example-basic-single">
                        <option value="" selected="selected" >Selecciona una opción del catálogo...</option>
                        <c:forEach  var="ua" items="${requestScope.ua}">
                            <option  required value="${ua.id_unidadAdministrativa}">${ua.nombre}</option>
                        </c:forEach>
                    </select>
                </td> 
            </tr>
            <tr style="width:90%">
                <td style="width:30%">Trámite:</td>
            </tr>
            <tr style="width:90%">
                <td style="width:30%" >
                    <select name="tramites" id="tramites" required class="js-example-basic-single">
                        <option value="" selected="selected">Selecciona una opción del catálogo...</option>
                    </select>
                </td> 
            </tr>

          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>Fecha de registro:</td>
            <td><!--Requisitos en formato zip/rar:--></td>
          </tr>

          <tr>

              <td><input type="date" name="fecha_r" id="fecha_r" required value="fecha()"></td>
              <td><!--<div class="uploadx"><input  name="adjunto" id="adjunto" type="file"></div>--></td>

          </tr>
          <tr>
            <td>&nbsp;</td>
            <td colspan="2">
          </tr>
          <tr>    
            <td><div id="envio"><input type="submit" name="enviarrequisitos" id="enviarrequisitos"  class="botona" value="Enviar solicitud"></div></td>
            <td colspan="2" >
                <div id="loading" >
                        <img  src="imagenes/cargando.gif" width="100" height="100" style="margin-left: auto; margin-right: auto;
            display: block;" />
                </div>
            </td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td colspan="2"></tr>
          </table>
<p>&nbsp;</p>
</form>
        
    </body>
</html>
