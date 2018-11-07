<%-- 
    Document   : frm_munEditar
    Created on : 29/10/2018, 12:05:26 PM
    Author     : SEDETUS
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javabeans.Municipio"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function registrar(){
                var params=new Object();
                params.id_municipio=$("#id_municipio").val();
                params.nombre=$("#nombre").val();
                
                $.post("controladormunicipio?operacion=modificarGuardar", params, function(datos){
                    $("#admin").html(datos);
                },"html");
                
                return false;
            }
        </script>
    </head>
    <body>
        <form id="form_Mun" onsubmit="return registrar()">
            <h1>Editar Municipios</h1>
            <input type="hidden" id="id_municipio" value="${mun.id_municipio}" />
            <table border="0" align="center">
                <tr>
                    <td>Nombre del municipio:</td>
                    <td></td>
                </tr>
                <tr>
                    <td><input type="text" id="nombre"   style=" width: 500px; font-size: 14px" value="${mun.nombre}" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="Aceptar" class="frm-btn" /> 
                        <input type="reset" value="Cancelar" class="frm-btn" onclick="cargar('controladormunicipio?operacion=listar','#admin')" /></td>
                </tr>
            </table>
        </form>
    </body>
</html>
