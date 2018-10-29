<%-- 
    Document   : frm_locEditar
    Created on : 29/10/2018, 01:03:40 PM
    Author     : SEDETUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="javabeans.Localidad"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function registrar(){
                var params=new Object();
                params.id_localidad=$("#id_localidad").val();
                params.id_municipio=$("#id_municipio").val();
                params.nombre_localidad=$("#nombre_localidad").val();
                
                $.post("controladorlocalidad?operacion=modificarGuardar", params, function(datos){
                    $("#admin").html(datos);
                },"html");
                
                return false;
            }
        </script>
    </head>
    <body>
        <form id="form_Loc" onsubmit="return registrar()">
            <h1>Editar Localidades</h1>
            <input type="hidden" id="id_localidad" value="${loc.id_localidad}" />
            <table border="0" align="center">
                <tr>
                    <td>Nombre de la localidad:</td>
                    <td></td>
                </tr>
                <tr>
                    <td><input type="text" id="nombre_localidad"   style=" width: 500px; font-size: 14px" value="${loc.nombre_localidad}" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" value="Aceptar" class="frm-btn" /> <input type="reset" value="Cancelar" class="frm-btn" /></td>
                </tr>
            </table>
        </form>
        
    </body>
</html>
