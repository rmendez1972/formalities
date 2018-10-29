<%-- 
    Document   : frm_mun
    Created on : 29/10/2018, 11:07:19 AM
    Author     : SEDETUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function registrar(){
                var params=new Object();
                params.municipio=$("#nombre").val();
                $.post("controladormunicipio?operacion=guardarNuevo", params, function(datos){
                    $('#admin').html(datos);
                },"html");
                
                return false;
            }
        </script>
    </head>
    <body>
        <h1>Nuevo Municipio</h1>
        <form id="form_Mun" onsubmit="return registrar()">
            <table border="0" align="center">
                <tr>
                    <td>Nombre del Municipio</td>
                    <td></td>
                </tr>
                <tr>
                    <td><input type="text" id="nombre"  style="width: 500px; font-size: 14px" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" value="Aceptar" class="frm-btn" /> <input type="reset" value="Cancelar" class="frm-btn" /></td>
                </tr>
            </table>
        </form>
    </body>
</html>
