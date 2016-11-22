/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import Modelo.GestionAdjunto;
import Modelo.GestionSeguimiento;
import Modelo.GestionSolicitante;
import Modelo.GestionSolicitud;
import Modelo.GestionTramite;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javabeans.Adjunto;
import javabeans.Seguimiento;
import javabeans.Solicitante;
import javabeans.Solicitud;
import javabeans.Tramite;
import javabeans.Usuario;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author arturo
 */
public class ControladorAdjunto extends ControladorBase {

    public void listar(HttpServletRequest request, HttpServletResponse response) throws Exception{
        Usuario usuario;
        ArrayList adjuntos;
        Seguimiento seguimiento;
        Solicitud solicitud;
        Solicitante solicitante;
        Tramite tramite;
        Integer id_seguimiento,id_tramite,id_solicitante,id_solicitud;
        String mensaje="Listado de archivos adjuntos exitoso";
        String pathadjuntos="build/web/adjuntos/";
        //recupero el usuario de la sesion 
        HttpSession objSession = request.getSession(); 
        usuario = (Usuario)(objSession.getAttribute("usuario")); 
            
        Integer id_grupo=usuario.getId_grupo();
        Integer id_unidadadministrativa=usuario.getId_unidadadministrativa();
            
        //obetnes datos del seguimiento por id_seguimiento
        String midseguimiento;   
        midseguimiento = request.getParameter("id_seguimiento");  
        id_seguimiento=Integer.parseInt(midseguimiento);
        
        
        GestionSeguimiento gs=new GestionSeguimiento(); 
        seguimiento = gs.obtenerPorId(id_seguimiento);
        id_solicitud = seguimiento.getId_solicitud();
        
            
        GestionSolicitud gsol=new GestionSolicitud(); 
        solicitud=gsol.obtenerPorId(id_solicitud);
        id_tramite = solicitud.getId_tramite();
        id_solicitante = solicitud.getId_solicitante();
            
        GestionSolicitante gsoli= new GestionSolicitante();
        solicitante= gsoli.obtenerPorId(id_solicitante);
                    
        GestionTramite gtm=new GestionTramite(); 
        tramite=gtm.obtenerPorId(id_tramite);
        id_unidadadministrativa=tramite.getId_unidadadministrativa();
            
            
            
             
            
            
        GestionAdjunto gad=new GestionAdjunto(); 
        adjuntos = gad.obtenerPorSeguimiento(id_seguimiento);
            
            
        request.setAttribute("mensaje",mensaje);
        request.setAttribute("seguimiento",seguimiento);
        request.setAttribute("solicitante",solicitante);
        request.setAttribute("solicitud",solicitud);
        request.setAttribute("tramite",tramite);
        request.setAttribute("adjuntos",adjuntos);
        request.setAttribute("pathadjuntos",pathadjuntos);
        if (id_grupo==1)
        {    
            RequestDispatcher rd=request.getRequestDispatcher("listaradjunto_registrante.jsp");
            rd.forward(request,response);
        }else
        {
            RequestDispatcher rd=request.getRequestDispatcher("listaradjunto.jsp");
            rd.forward(request,response);
            
        }
    }
    
    public void eliminar(HttpServletRequest request, HttpServletResponse response) throws Exception{
        Integer id_seguimiento,id_tramite,id_solicitante,id_solicitud;
        //String mensaje=request.getParameter("mensaje");
        int id_adjunto=Integer.parseInt(request.getParameter("id_adjunto"));
        GestionAdjunto modelo=new GestionAdjunto();
        Adjunto adjunto = modelo.obtenerPorId(id_adjunto);
        id_seguimiento= adjunto.getId_seguimiento();
        String midseguimiento=Integer.toString(id_seguimiento);
        if(modelo.eliminarPorId(id_adjunto))
        {    
            request.setAttribute("mensaje", "Registro eliminado");
            
        }
        else
        {
            request.setAttribute("mensaje", "No se pudo eliminar, el adjunto se encuentra en uso");
        }
        
        Usuario usuario;
        ArrayList adjuntos;
        Seguimiento seguimiento;
        Solicitud solicitud;
        Solicitante solicitante;
        Tramite tramite;
        
        
        String pathadjuntos="build/web/adjuntos/";
        //recupero el usuario de la sesion 
        HttpSession objSession = request.getSession(); 
        usuario = (Usuario)(objSession.getAttribute("usuario")); 
            
        Integer id_grupo=usuario.getId_grupo();
        Integer id_unidadadministrativa=usuario.getId_unidadadministrativa();
            
        //obetnes datos del seguimiento por id_seguimiento
        //String midseguimiento;   
        //midseguimiento = request.getParameter("id_seguimiento");  
        id_seguimiento=Integer.parseInt(midseguimiento);
        
        
        GestionSeguimiento gs=new GestionSeguimiento(); 
        seguimiento = gs.obtenerPorId(id_seguimiento);
        id_solicitud = seguimiento.getId_solicitud();
        
            
        GestionSolicitud gsol=new GestionSolicitud(); 
        solicitud=gsol.obtenerPorId(id_solicitud);
        id_tramite = solicitud.getId_tramite();
        id_solicitante = solicitud.getId_solicitante();
            
        GestionSolicitante gsoli= new GestionSolicitante();
        solicitante= gsoli.obtenerPorId(id_solicitante);
                    
        GestionTramite gtm=new GestionTramite(); 
        tramite=gtm.obtenerPorId(id_tramite);
        id_unidadadministrativa=tramite.getId_unidadadministrativa();
            
            
            
             
            
            
        GestionAdjunto gad=new GestionAdjunto(); 
        adjuntos = gad.obtenerPorSeguimiento(id_seguimiento);
        
        
        
        request.setAttribute("seguimiento",seguimiento);
        request.setAttribute("solicitante",solicitante);
        request.setAttribute("solicitud",solicitud);
        request.setAttribute("tramite",tramite);
        request.setAttribute("adjuntos",adjuntos);
        request.setAttribute("pathadjuntos",pathadjuntos);
        
       
        RequestDispatcher rd=request.getRequestDispatcher("listaradjunto.jsp");
        rd.forward(request,response);
        
    }
    /*
    public void nuevo(HttpServletRequest request, HttpServletResponse response) throws Exception{
        RequestDispatcher rd=request.getRequestDispatcher("frm_status.jsp");
        rd.forward(request,response);
    }
    
    public void nuevoGuardar(HttpServletRequest request, HttpServletResponse response) throws Exception{
        GestionStatus modelo=new GestionStatus();
        Status status=new Status();
        status.setNombre(request.getParameter("nombre"));
        if(modelo.registroStatus(status))
            request.setAttribute("msg", "Datos guardados");
        else
            request.setAttribute("msg", "Error al guardar, intente de nuevo más tarde");
        RequestDispatcher rd=request.getRequestDispatcher("controladorestatus?operacion=listar");
        rd.forward(request,response);
    }
    
    public void editar(HttpServletRequest request, HttpServletResponse response) throws Exception{
        int id=Integer.parseInt(request.getParameter("id"));
        GestionStatus modelo=new GestionStatus();
        Status status=modelo.obtenerPorId(id);
        request.setAttribute("status", status);
        RequestDispatcher rd=request.getRequestDispatcher("frm_modificastatus.jsp");
        rd.forward(request,response);
    }
    
    public void editarGuardar(HttpServletRequest request, HttpServletResponse response) throws Exception{
        GestionStatus modelo=new GestionStatus();
        Status status=new Status();
        status.setId_status(Integer.parseInt(request.getParameter("id_status")));
        status.setNombre(request.getParameter("nombre"));
        if(modelo.actualizar(status))
            request.setAttribute("msg", "Datos guardados");
        else
            request.setAttribute("msg", "Error al guardar, intente de nuevo más tarde");
        RequestDispatcher rd=request.getRequestDispatcher("controladorestatus?operacion=listar");
        rd.forward(request,response);
    }
    
    public void reporte(HttpServletRequest request, HttpServletResponse response) throws Exception{
        Map param = new HashMap();
        generarReporte("ReporteStatus.jasper", param, request, response);
    }*/
}
