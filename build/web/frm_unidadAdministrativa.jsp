<%-- 
    Document   : frm_unidadAdministrativa
    Created on : 25/11/2013, 04:28:08 PM
    Author     : arturo
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
                params.nombre=$("#nombre").val();
                params.email=$("#email").val();
                $.post("controladorunidadadtva?operacion=guardarNuevo", params, function(datos){
                    $('#admin').html(datos);
                },"html");
                
                return false;
            }
        </script>
    </head>
    <body>
        <h1>Nueva Unidad Administrativa</h1>
        <form id="form_UA" onsubmit="return registrar()">
            <table border="0" align="center">
                <tr>
                    <td>Nombre</td>
                    <td></td>
                </tr>
                <tr>
                    <td><input type="text" id="nombre" pattern="([a-zA-ZñÑçÇáéíóúüÁÉÍÓÚÜ ]{15,60})"  placeholder="Mínimo 15 caracteres" required style="width: 500px; font-size: 14px" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Email</td>
                    <td></td>
                </tr>
                <tr>
                    <td><input type="text" id="email" required style="text-transform:none; width: 300px; font-size: 13px" /></td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" value="Aceptar" class="frm-btn" /> <input type="reset" value="Cancelar" class="frm-btn" /></td>
                </tr>
            </table>
        </form>
    </body>
</html>
