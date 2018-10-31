<%-- 
    Document   : listar_mun
    Created on : 29/10/2018, 08:54:15 AM
    Author     : SEDETUS
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <script>
            function eliminarMunicipio(id){
                confirma("", "Eliminar Municipio", "Confirmar eliminación", "eliminar", function(){
                    var params=new Object();
                    params.id=id;
                    $.post("controladormunicipio?operacion=eliminar",params,function(datos){
                        $("#admin").html(datos);
                    },"html");
                });
            }
            function editarMunicipio(id){
                var params=new Object();
                params.id=id;
                $.post("controladormunicipio?operacion=modificar",params,function(datos){
                    $("#admin").html(datos);
                },"html");
            }
            
            <c:if test="${msg != null}">
                alert('${msg}');
            </c:if>
        </script>
    </head>
    <body>
        <table width="960" border="0">
  <tr>
    <td width="750"><h3>Municipios</h3></td>
    <td width="210"><div style="display:table; margin-bottom: 5px;">
            <div class="btn-catalogo" onclick="cargar('controladormunicipio?operacion=nuevo','#admin')">
                <img src="imagenes/agregar.png" />
                <p>Agregar</p>
            </div>
            <a href="controladormunicipio?operacion=reporte" target="_blank">
                <div class="btn-catalogo">
                    <img src="imagenes/reportesb.png" />
                    <p>Imprimir</p>
                </div>
            </a>
        </div>  
    </td>
  </tr>
</table>

        
      
        
        <table id="municipio" class="tablesorter" style="margin:auto; width:70%; font-size: 14px">
            <thead>
                <tr>
                    <th style="font-size: 16px">Municipio</th>
                    <th style="font-size: 16px"width="20%">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="mun" items="${requestScope.mun}" varStatus="loop"> 
                    <tr class="${loop.index % 2 == 0 ? 'odd' : 'impar'}"> 
                        <td><c:out value="${mun.nombre}" /></td>
                        <td><img src="imagenes/editar.png" class="btn-tabla" title="Editar Municipio" onclick="editarMunicipio(${mun.id_municipio})" /><img src="imagenes/eliminar.png" class="btn-tabla" title="Eliminar Municipio" onclick="eliminarMunicipio(${mun.id_municipio})" /></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
