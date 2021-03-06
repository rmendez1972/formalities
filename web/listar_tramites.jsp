<%-- 
    Document   : listar_tramites
    Created on : 2/12/2013, 12:13:41 PM
    Author     : arturo
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            //alert('dentro de javascript');
            function eliminarTramite(id){
                confirma("", "Eliminar Trámite", "Confirmar eliminación", "eliminar", function(){
                    var params=new Object();
                    params.id=id;
                    $.post("controladortramite?operacion=eliminar", params, function(datos){
                        $("#admin").html(datos);
                    },"html");
                });
            };
            function editarTramite(id){
                var params=new Object();
                params.id=id;
                $.post("controladortramite?operacion=editar", params, function(datos){
                    $("#admin").html(datos);
                },"html");
            }
            function verRequisitos(id){
                var params=new Object();
                params.id=id;
                $.post("controladortramite?operacion=verRequisitos", params, function(datos){
                    $("#admin").html(datos);
                },"html");
            };
            
            $(document).ready(function(){
            
                $('#tramitestab').DataTable();
            });
            
            
            <c:if test="${msg != null}">
                console.log('${msg}');
                //alert('${msg}');
                
            </c:if>
        </script>
    </head>
    <body>
        <table width="90%" border="0">
            <tr>
                <td width="80%"><h3>Listado de Trámites</h3></td>
                <td width="20%">
                    <div style="display:table; margin-bottom: 5px;">
                        <div class="btn-catalogo" onclick="cargar('controladortramite?operacion=nuevo','#admin')">
                                <img src="imagenes/agregar.png" />
                                <p>Agregar</p>
                        </div>
                        <a href="controladortramite?operacion=reporte" target="_blank">
                            <div class="btn-catalogo">
                                <img src="imagenes/reportesb.png" />
                                <p>Imprimir</p>
                            </div>
                        </a>
                    </div>  
                </td>
            </tr>
        </table>
        <c:if test="${msg != null}">
            <div  class="alert alert-lg <c:out value="${tipo_alert}" /> role="alert" style="margin:17px;" >
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <strong><c:out value="${msg}" /></strong> 
            </div>
        </c:if>    
            
             
        
        <table id="tramitestab" class="table" style="margin:auto; width:90%; font-size: 14px">
            <thead >
                <tr >
                    <th style="margin:auto; width:10%; font-size: 14px">Nombre</th>
                    <th >Días de resolución</th>
                    <th>Costo</th>
                    <th >Subsecretarías</th>
                    <th>Direccion</th>
                    <th >Acciones</th>
                </tr>
            </thead>
            <tbody >
                <c:forEach var="tram" items="${requestScope.tramites}" varStatus="loop"> 
                    <tr class="${loop.index % 2 == 0 ? 'odd' : 'impar'}"> 
                        <td ><c:out value="${tram.nombre}" /></td>
                        <td ><c:out value="${tram.dias_resolucion}" /></td>
                        <td ><c:out value="${tram.costo}" /></td>
                        <td ><c:out value="${tram.unidadAdministrativa}" /></td>
                        <td ><c:out value="${tram.direccion}" /></td>
                        <td >
                            <img src="imagenes/editar.png" class="btn-tabla" title="Editar Trámite" onclick="editarTramite(${tram.id_tramite});" />
                            <img src="imagenes/listar.png" class="btn-tabla" title="Ver requisitos" onclick="verRequisitos(${tram.id_tramite});" />
                            <img src="imagenes/eliminar.png" class="btn-tabla" title="Eliminar Trámite" onclick="eliminarTramite(${tram.id_tramite})" />
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
