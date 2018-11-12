<%-- 
    Document   : listar_loc
    Created on : 29/10/2018, 12:49:54 PM
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
            $(document).ready(function(){
            
                $('#localidad').DataTable();
            });
            
            function eliminarLocalidad(id){
                confirma("", "Eliminar Localidad", "Confirmar eliminación", "eliminar", function(){
                    var params=new Object();
                    params.id=id;
                    $.post("controladorlocalidad?operacion=eliminar",params,function(datos){
                        $("#admin").html(datos);
                    },"html");
                });
            }
            function editarLocalidad(id){
                var params=new Object();
                params.id=id;
                $.post("controladorlocalidad?operacion=modificar",params,function(datos){
                    $("#admin").html(datos);
                },"html");
            }
            
            <c:if test="${msg != null}">
                alert('${msg}');
            </c:if>
                
            
        </script>
    </head>
    <body>
        
        <table width="100%">
            <tr>
                <td width="80%"><h3>Localidades</h3></td>
                <td width="20%" ><div style="display:table; margin-bottom: 5px;">
                        <div class="btn-catalogo" onclick="cargar('controladorlocalidad?operacion=nuevo','#admin')">
                            <img src="imagenes/agregar.png" />
                            <p>Agregar</p>
                        </div>
                  <a href="controladorlocalidad?operacion=reporte" target="_blank">
                      <div class="btn-catalogo">
                          <img src="imagenes/reportesb.png" />
                          <p>Imprimir</p>
                      </div>
                  </a>
              </div>  
          </td>
        </tr>
      </table>
        <table id="localidad" class="display" style="margin:auto; width:90%; font-size: 14px">
                  <thead>
                      <tr>
                          <th style="font-size: 16px">Municipio</th>
                          <th style="font-size: 16px">Nombre de la Localidad</th>
                          <th style="font-size: 16px"width="20%">Acciones</th>
                      </tr>
                  </thead>
                  <tbody>
                      <c:forEach var="loc" items="${requestScope.loc}" varStatus="loop"> 
                          <tr class="${loop.index % 2 == 0 ? 'odd' : 'impar'}"> 
                              <td> <c:out value="${loc.municipio}" /></td>
                              <td><c:out value="${loc.nombre_localidad}" /></td>
                              <td><img src="imagenes/editar.png" class="btn-tabla" title="Editar Localidad" onclick="editarLocalidad(${loc.id_localidad})" /><img src="imagenes/eliminar.png" class="btn-tabla" title="Eliminar Localidad" onclick="eliminarLocalidad(${loc.id_localidad})" /></td>
                          </tr>
                      </c:forEach>
                  </tbody>
              </table>
    </body>
</html>
