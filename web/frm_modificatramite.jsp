<%-- 
    Document   : frm_modificatramite
    Created on : 17/12/2013, 10:30:57 AM
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
            function registrar(){
                var params=new Object();
                params.id_tramite=$("#id_tramite").val();
                params.nombre=$("#nombre").val();
                params.dias_resolucion=$("#dias_resolucion").val();
                params.id_unidadAdministrativa=$("#unidadAdministrativa").val();
                
                if(params.id_unidadAdministrativa!=0){
                    $.post("controladortramite?operacion=editarGuardar", params, function(datos){
                        $("#admin").html(datos);
                    },"html");
                }
                
                return false;
            }
        </script>
    </head>
    <body>
        <h1>Editar trámite</h1>
        <form id="form_UA" onsubmit="return registrar()">
            <input type="hidden" id="id_tramite" name="id_tramite" value="${tramite.id_tramite}" />
            <table border="0" align="center">
                <tr>
                    <td>Nombre:</td>
                    <td></td>
                </tr>
                <tr>
                    <td><input type="text" id="nombre" required style="width: 600px; font-size: 14px"pattern="([0-9a-zA-Z .-]{15,400})" placeholder="Escriba el nombre de un trámite (Mín.15 Máx.400 caracteres)" value="${tramite.nombre}" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Días para resolución:</td>
                    <td></td>
                </tr>
                <tr>
                    <td><input type="text" id="dias_resolucion" required pattern="[0-9]+" style="text-transform:none; width: 100px; font-size: 14px" value="${tramite.dias_resolucion}" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan='2'>Unidad administrativa responsable:</td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan='2'>
                        <select id="unidadAdministrativa" required style="width: 500px; font-size: 14px">
                            <option value="">Seleccione una opción</option>
                            <c:forEach var="ua" items="${requestScope.ua}"> 
                                <option value="${ua.id_unidadAdministrativa}" ${ua.id_unidadAdministrativa == tramite.id_unidadadministrativa ? "selected":""}>${ua.nombre}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" value="Aceptar" class="frm-btn" /> <input type="reset" value="Cancelar" class="frm-btn" /></td>
                </tr>
            </table>
        </form>
    </body>
</html>
