<%-- 
    Document   : listar_requisitosTramiteRegistrante
    Created on : 10/01/2014, 10:33:37 AM
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
            function eliminarRequisito(id_tramite, id_requisito){
                confirma("", "Eliminar Requisito", "Confirmar eliminación", "eliminar", function(){
                    var params=new Object();
                    params.id_tramite=id_tramite;
                    params.id_requisito=id_requisito;

                    $.post("controladortramite?operacion=eliminarRequisito", params, function(datos){
                        $("#admin").html(datos);
                    },"html");
                });
            }
            
            function guardarRequisito(){
                var params=new Object();
                params.id_tramite=$("#id_tram").val();
                params.id_requisito=$("#nuevoRequisito").val();
                
                if(params.id_requisito!=0){
                    $.post("controladortramite?operacion=guardarRequisito", params, function(datos){
                        $("#admin").html(datos);
                    },"html");
                }
                else
                    alert("Seleccione un requisito");
            }
            
            <c:if test="${msg != null}">
                alert('${msg}');
            </c:if>
        </script>
    </head>
    <body>
        <table width="100%" border="0">
  <tr>
    <td width="80%"><h3>Requisitos del trámite:<br> ${tramite.nombre}</h3></td>
    <td width="20%"><div style="display:table; margin-bottom: 5px;">
            
            <a href="controladortramite?operacion=reporteRequisitos&id=${tramite.id_tramite}" target="_blank">
                <div class="btn-catalogo">
                    <img src="imagenes/reportesb.png" />
                    <p>Imprimir</p>
                </div>
            </a>
        </div>  
    </td>
  </tr>
</table>
    
    <div id="d_nuevoRequisito" style="display:none; padding: 15px; margin:10px; border:1px solid #CDCDCD; font-size:13px">
        Nuevo requisito: 
        <input type="hidden" id="id_tram" value="${tramite.id_tramite}" />
        <br />
        <select id="nuevoRequisito">
            <option value="0">Seleccione uno</option>
            <c:forEach var="req" items="${requestScope.noreq}"> 
                        <option value="${req.id_requisito}"><c:out value="${req.nombre}" /></option>
                </c:forEach>
        </select>
        <br />
        <input type="button" value="Agregar" class="frm-btn" onclick="guardarRequisito()" /> 
        <input type="button" value="Cancelar" class="frm-btn" onclick="$('#d_nuevoRequisito').slideUp()" />
    </div>
    
    <table id="requisitos" class="tablesorter" style="margin:auto; width:60%">
            <thead>
                <tr>
                    <th>Nombre del Requisito</th>
                    
                </tr>
            </thead>
            <tbody>
                <c:forEach var="req" items="${requestScope.req}" varStatus="loop"> 
                    <tr class="${loop.index % 2 == 0 ? 'odd' : 'impar'}"> 
                        <td><c:out value="${req.nombre}" /></td>
                        
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    
    </body>
</html>
