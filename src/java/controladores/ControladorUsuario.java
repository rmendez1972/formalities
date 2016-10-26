/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import Modelo.GestionGrupo;
import Modelo.GestionUnidadAdministrativa;
import Modelo.GestionUsuario;
import java.io.File;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javabeans.Usuario;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JasperRunManager;

/**
 *
 * @author arturo
 */
public class ControladorUsuario extends ControladorBase {

    public void listar(HttpServletRequest request, HttpServletResponse response) throws Exception{
        GestionUsuario modelo=new GestionUsuario();
            ArrayList usuarios=modelo.obtenerUsuarios();
            request.setAttribute("usuarios", usuarios);
            
            RequestDispatcher rd=request.getRequestDispatcher("listar_usuarios.jsp");
            rd.forward(request,response);
    }
    
    public void eliminar(HttpServletRequest request, HttpServletResponse response) throws Exception{
        int id=Integer.parseInt(request.getParameter("id"));
            GestionUsuario modelo=new GestionUsuario();
            if(modelo.eliminarPorId(id))
                request.setAttribute("msg", "Registro eliminado");
            else
                request.setAttribute("msg", "No es posible eliminar. El usuario tiene solicitudes registradas.");
            
            RequestDispatcher rd=request.getRequestDispatcher("controladorusuario?operacion=listar");
            rd.forward(request,response);
    }
    
    public void editar(HttpServletRequest request, HttpServletResponse response) throws Exception{
        int id=Integer.parseInt(request.getParameter("id"));
            GestionUsuario modelo=new GestionUsuario();
            Usuario usr=modelo.obtenerPorId(id);
            
            GestionUnidadAdministrativa mod_ua=new GestionUnidadAdministrativa();
            GestionGrupo mod_grp=new GestionGrupo();
            ArrayList ua=mod_ua.obtenerTodos();
            ArrayList grupos=mod_grp.obtenerTodos();
            
            request.setAttribute("usr", usr);
            request.setAttribute("ua", ua);
            request.setAttribute("grupo", grupos);
            
            RequestDispatcher rd=request.getRequestDispatcher("frm_modificausuario.jsp");
            rd.forward(request,response);
    }
    
    public void editarGuardar(HttpServletRequest request, HttpServletResponse response) throws Exception{
        Usuario usr=new Usuario();
            usr.setId_usuario(Integer.parseInt(request.getParameter("id_usuario")));
            usr.setNombre(request.getParameter("nombre"));
            usr.setApellido_paterno(request.getParameter("apellido_paterno"));
            usr.setApellido_materno(request.getParameter("apellido_materno"));
            usr.setId_unidadadministrativa(Integer.parseInt(request.getParameter("id_unidadadministrativa")));
            usr.setId_grupo(Integer.parseInt(request.getParameter("id_grupo")));
            usr.setUsuario(request.getParameter("usuario"));
            
            GestionUsuario modelo=new GestionUsuario();
            if(modelo.actualizarUsuario(usr)){
                RequestDispatcher rd=request.getRequestDispatcher("controladorusuario?operacion=listar");
                request.setAttribute("msg", "Datos guardados");
                rd.forward(request,response);
            }
            else{
                RequestDispatcher rd=request.getRequestDispatcher("controladorusuario?operacion=editar");
                request.setAttribute("msg", "Error al guardar. Intente de nuevo más tarde");
                rd.forward(request,response);
            }
    }
    
    public void nuevo(HttpServletRequest request, HttpServletResponse response) throws Exception{
            GestionUnidadAdministrativa mod_ua=new GestionUnidadAdministrativa();
            GestionGrupo mod_grp=new GestionGrupo();
            ArrayList ua=mod_ua.obtenerTodos();
            ArrayList grupos=mod_grp.obtenerTodos();
            
            request.setAttribute("ua", ua);
            request.setAttribute("grupo", grupos);
            
            RequestDispatcher rd=request.getRequestDispatcher("frm_usuario.jsp");
            rd.forward(request,response);
    }
    
    public void nuevoGuardar(HttpServletRequest request, HttpServletResponse response) throws Exception{
        Usuario usr=new Usuario();
            usr.setUsuario(request.getParameter("usuario"));
            usr.setPassword(request.getParameter("password"));
            usr.setNombre(request.getParameter("nombre"));
            usr.setApellido_paterno(request.getParameter("apellido_paterno"));
            usr.setApellido_materno(request.getParameter("apellido_materno"));
            usr.setId_unidadadministrativa(Integer.parseInt(request.getParameter("id_unidadadministrativa")));
            usr.setId_grupo(Integer.parseInt(request.getParameter("id_grupo")));
            
            GestionUsuario modelo=new GestionUsuario();
            if(modelo.registroUsuario(usr)){
                RequestDispatcher rd=request.getRequestDispatcher("controladorusuario?operacion=listar");
                request.setAttribute("msg", "Datos guardados");
                rd.forward(request,response);
            }
            else{
                RequestDispatcher rd=request.getRequestDispatcher("controladorusuario?operacion=nuevo");
                request.setAttribute("msg", "Error al guardar. Intente de nuevo más tarde");
                rd.forward(request,response);
            }
    }
    
    public void reporte(HttpServletRequest request, HttpServletResponse response) throws Exception{
        Map param = new HashMap();
        generarReporte("ReporteUsuarios.jasper", param, request, response);
    }
}
