/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import Modelo.GestionRequisito;
import Modelo.GestionTramite;
import Modelo.GestionUnidadAdministrativa;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javabeans.Tramite;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author arturo
 */
public class ControladorTramite extends ControladorBase {
    
    public void listar(HttpServletRequest request, HttpServletResponse response) throws Exception{
        GestionTramite modelo=new GestionTramite();
        ArrayList tramites=modelo.obtenerTodos();
        request.setAttribute("tramites",tramites);
            
        RequestDispatcher rd=request.getRequestDispatcher("listar_tramites.jsp");
        rd.forward(request,response);
    }
    
    public void nuevo(HttpServletRequest request, HttpServletResponse response) throws Exception{
        GestionUnidadAdministrativa modua=new GestionUnidadAdministrativa();
        ArrayList ua=modua.obtenerTodos();
        request.setAttribute("ua", ua);
        RequestDispatcher rd=request.getRequestDispatcher("frm_tramite.jsp");
        rd.forward(request, response);
    }
    
    public void nuevoGuardar(HttpServletRequest request, HttpServletResponse response) throws Exception{
        GestionTramite modelo=new GestionTramite();
           Tramite tram=new Tramite();
           tram.setNombre(request.getParameter("nombre"));
           tram.setDias_resolucion(Integer.parseInt(request.getParameter("dias_resolucion")));
           tram.setId_unidadadministrativa(Integer.parseInt(request.getParameter("id_unidadAdministrativa")));
           
           if(modelo.registroTramite(tram)){
               RequestDispatcher rd=request.getRequestDispatcher("controladortramite?operacion=listar");
                request.setAttribute("msg", "Datos guardados");
                rd.forward(request,response);
            }
            else{
                RequestDispatcher rd=request.getRequestDispatcher("controladortramite?operacion=nuevo");
                request.setAttribute("msg", "Error al guardar. Intente de nuevo más tarde");
                rd.forward(request,response);
            }
    }
    
    public void eliminar(HttpServletRequest request, HttpServletResponse response) throws Exception{
        GestionTramite modelo=new GestionTramite();
           int id=Integer.parseInt(request.getParameter("id"));
           if(modelo.eliminarPorId(id)){
               RequestDispatcher rd=request.getRequestDispatcher("controladortramite?operacion=listar");
                request.setAttribute("msg", "Registro eliminado");
                rd.forward(request,response);
           }
           else{
               RequestDispatcher rd=request.getRequestDispatcher("controladortramite?operacion=listar");
                request.setAttribute("msg", "Error al eliminar. El trámite se encuentra en uso");
                rd.forward(request,response);
           }
    }
    
    public void editar(HttpServletRequest request, HttpServletResponse response) throws Exception{
        GestionTramite modelo=new GestionTramite();
           int id=Integer.parseInt(request.getParameter("id"));
           Tramite tramite=modelo.obtenerPorId(id);
           
           GestionUnidadAdministrativa mod_ua=new GestionUnidadAdministrativa();
           ArrayList ua=mod_ua.obtenerTodos();
           
           request.setAttribute("ua", ua);
           request.setAttribute("tramite", tramite);
           RequestDispatcher rd=request.getRequestDispatcher("frm_modificatramite.jsp");
           rd.forward(request,response);
    }
    
    public void editarGuardar(HttpServletRequest request, HttpServletResponse response) throws Exception{
        Tramite tramite=new Tramite();
           tramite.setId_tramite(Integer.parseInt(request.getParameter("id_tramite")));
           tramite.setNombre(request.getParameter("nombre"));
           tramite.setDias_resolucion(Integer.parseInt(request.getParameter("dias_resolucion")));
           tramite.setId_unidadadministrativa(Integer.parseInt(request.getParameter("id_unidadAdministrativa")));
           
           GestionTramite modelo=new GestionTramite();
           if(modelo.actualizar(tramite))
                request.setAttribute("msg", "Datos actualizados");
           else
                request.setAttribute("msg", "Error al actualizar datos. Intente de nuevo más tarde");
           
           RequestDispatcher rd=request.getRequestDispatcher("controladortramite?operacion=listar");
           rd.forward(request,response);
    }
    
    public void verRequisitos(HttpServletRequest request, HttpServletResponse response) throws Exception{
        int id=Integer.parseInt(request.getParameter("id"));
        verRequisitosP(id, request, response);
    }
    
    public void verRequisitosP(int id, HttpServletRequest request, HttpServletResponse response) throws Exception{
        GestionTramite modelo=new GestionTramite();
        Tramite t=modelo.obtenerPorId(id);
        
        GestionRequisito mod_req=new GestionRequisito();
        ArrayList req=mod_req.obtenerPorTramite(id);
        ArrayList noreq=mod_req.obtenerSinTramite(id);
        
        request.setAttribute("tramite", t);
        request.setAttribute("req", req);
        request.setAttribute("noreq", noreq);
        
        RequestDispatcher rd=request.getRequestDispatcher("listar_requisitosTramite.jsp");
        rd.forward(request,response);
    }
    
    public void eliminarRequisito(HttpServletRequest request, HttpServletResponse response) throws Exception{
        int id_tramite=Integer.parseInt(request.getParameter("id_tramite"));
        int id_requisito=Integer.parseInt(request.getParameter("id_requisito"));
        GestionTramite modelo=new GestionTramite();
        
        if(modelo.eliminarRequisito(id_tramite, id_requisito))
            request.setAttribute("msg", "Requisito eliminado");
        else
            request.setAttribute("msg", "Error al eliminar");
        
        verRequisitosP(id_tramite, request,response);
    }
    
    public void guardarRequisito(HttpServletRequest request, HttpServletResponse response) throws Exception{
        int id_tramite=Integer.parseInt(request.getParameter("id_tramite"));
        int id_requisito=Integer.parseInt(request.getParameter("id_requisito"));
        GestionTramite modelo=new GestionTramite();
        
        if(modelo.agregarRequisito(id_tramite, id_requisito))
            request.setAttribute("msg", "Requisito agregado");
        else
            request.setAttribute("msg", "Error al guardar");
                
        verRequisitosP(id_tramite, request, response);
    }
    
    public void reporte(HttpServletRequest request, HttpServletResponse response) throws Exception{
        Map param = new HashMap();
        generarReporte("ReporteTramites.jasper", param, request, response);
    }
    
    public void reporteRequisitos(HttpServletRequest request, HttpServletResponse response) throws Exception{
        int id_tramite=Integer.parseInt(request.getParameter("id"));
        GestionTramite modelo=new GestionTramite();
        Tramite t=modelo.obtenerPorId(id_tramite);
        
        Map param = new HashMap();
        param.put("titulo", "Requisitos del trámite " + t.getNombre());
        param.put("sql", "where id_requisito in (select id_requisito from tramite_requisito where id_tramite='"+id_tramite+"')");
        generarReporte("ReporteRequisitos.jasper", param, request, response);
    }
}
