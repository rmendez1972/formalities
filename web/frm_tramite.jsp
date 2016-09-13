<%-- 
    Document   : frm_tramite
    Created on : 2/12/2013, 12:32:40 PM
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
                params.nombre=$("#nombre").val();
                params.dias_resolucion=$("#dias_resolucion").val();
                params.id_unidadAdministrativa=$("#unidadAdministrativa").val();
                
                if(params.id_unidadAdministrativa!=0){
                    $.post("controladortramite?operacion=nuevoGuardar", params, function(datos){
                        $("#admin").html(datos);
                    },"html");
                }
                
                return false;
            }
        </script>
    </head>
    <body>
        <h1>Nuevo trámite</h1>
        <form id="form_UA" onsubmit="return registrar()">
            <table border="0" align="center">
                <tr>
                    <td>Nombre:</td>
                    <td></td>
                </tr>
                <tr>
                    <td><input type="text" id="nombre" required style="width: 600px; font-size: 25px" pattern="([0-9a-zA-Z .-]{15,400})" placeholder="Escriba el nombre de un trámite (Mín.15 Máx.400 caracteres)" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Días para resolución:</td>
                    <td></td>
                </tr>
                <tr>
                    <!--<td><input type="text" id="dias_resolucion" required pattern="[0-9]{1,2}" placeholder="íMn.5 Máx.12 caracteres" style="width: 100px; font-size: 25px" /></td>!-->
                    <td><input type="number" id="dias_resolucion" required min="1" scroll="none" max="30" placeholder="de 1 a 30" style="width: 300px; font-size: 25px" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan='2'>Unidad administrativa responsable:</td>                    <td></td>
                </tr>
                <tr>
                    <td colspan='2'>
                        <select id="unidadAdministrativa" required style="width: 500px">
                            <option value="">Seleccione una opción</option>
                            <c:forEach var="ua" items="${requestScope.ua}"> 
                                <option value="${ua.id_unidadAdministrativa}">${ua.nombre}</option>
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
