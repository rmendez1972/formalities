/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;
import Modelo.GestionMunicipio;
import java.io.File;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javabeans.Municipio;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JasperRunManager;


/**
 *
 * @author SEDETUS
 */
@WebServlet(name = "ControladorMunicipio", urlPatterns = {"/controladormunicipio"})
public class ControladorMunicipio extends ControladorBase {
    
    public void listar(HttpServletRequest request, HttpServletResponse response) throws Exception{
        GestionMunicipio modelo=new GestionMunicipio();
        ArrayList mun=modelo.obtenerTodos();
        request.setAttribute("mun",mun);
        RequestDispatcher rd=request.getRequestDispatcher("listar_mun.jsp");
        rd.forward(request,response);
    }
    public void nuevo(HttpServletRequest request, HttpServletResponse response) throws Exception{
        RequestDispatcher rd=request.getRequestDispatcher("frm_mun.jsp");
        rd.forward(request,response);
    }
    public void guardarNuevo(HttpServletRequest request, HttpServletResponse response) throws Exception{
        String municipio=request.getParameter("municipio");
        GestionMunicipio modelo=new GestionMunicipio();
        Municipio mun=new Municipio();
        mun.setNombre(municipio);
        if(modelo.registro(mun)){
            RequestDispatcher rd=request.getRequestDispatcher("controladormunicipio?operacion=listar");
            request.setAttribute("msg", "Datos guardados");
            rd.forward(request,response);
            }
            else{
                RequestDispatcher rd=request.getRequestDispatcher("controladormunicipio?operacion=nuevo");
                request.setAttribute("msg", "Error al guardar. Intente de nuevo más tarde");
                rd.forward(request,response);
            }
        
    }
    public void eliminar(HttpServletRequest request, HttpServletResponse response) throws Exception{
        int id_municipio=Integer.parseInt(request.getParameter("id"));
            GestionMunicipio modelo=new GestionMunicipio();
            if(modelo.eliminarPorId(id_municipio)){
                RequestDispatcher rd=request.getRequestDispatcher("controladormunicipio?operacion=listar");
                request.setAttribute("msg", "Datos eliminados");
                rd.forward(request,response);
            }
            else{
                RequestDispatcher rd=request.getRequestDispatcher("controladormunicipio?operacion=listar");
                request.setAttribute("msg", "Error al eliminar. El municipio se encuentra en uso.");
                rd.forward(request,response);
            }
    }
    
    public void modificar(HttpServletRequest request, HttpServletResponse response) throws Exception{
        int id_municipio=Integer.parseInt(request.getParameter("id"));
        GestionMunicipio modelo=new GestionMunicipio();
        Municipio mun=modelo.obtenerPorId(id_municipio);
        request.setAttribute("mun", mun);
        RequestDispatcher rd=request.getRequestDispatcher("frm_munEditar.jsp");
        rd.forward(request,response);
    }
    
    public void modificarGuardar(HttpServletRequest request, HttpServletResponse response) throws Exception{
        Municipio mun=new Municipio(Integer.parseInt(request.getParameter("id_municipio")), request.getParameter("nombre"));
            GestionMunicipio modelo=new GestionMunicipio();
            if(modelo.actualizar(mun)){
                RequestDispatcher rd=request.getRequestDispatcher("controladormunicipio?operacion=listar");
                request.setAttribute("msg", "Datos guardados");
                rd.forward(request,response);
            }
            else{
                RequestDispatcher rd=request.getRequestDispatcher("controladormunicipio?operacion=listar");
                request.setAttribute("msg", "Error al guardar");
                rd.forward(request,response);
            }
    }
    
    public void reporte(HttpServletRequest request, HttpServletResponse response) throws Exception{
        Map param = new HashMap();
        //generarReporte("ReporteUnidades.jasper", param, request, response);
    }
    
    
}
