/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import Modelo.GestionLocalidad;
import Modelo.GestionMunicipio;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.File;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javabeans.Localidad;
import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JasperRunManager;

/**
 *
 * @author SEDETUS
 */
@WebServlet(name = "ControladorLocalidad", urlPatterns = {"/controladorlocalidad"})
public class ControladorLocalidad extends ControladorBase {
    public void listar(HttpServletRequest request, HttpServletResponse response) throws Exception{
        GestionLocalidad modelo=new GestionLocalidad();
        ArrayList loc=modelo.obtenerTodos();
        request.setAttribute("loc",loc);
        RequestDispatcher rd=request.getRequestDispatcher("listar_loc.jsp");
        rd.forward(request,response);
    }
    public void nuevo(HttpServletRequest request, HttpServletResponse response) throws Exception{
        GestionMunicipio mod_mun = new GestionMunicipio();
        ArrayList mun =mod_mun.obtenerTodos();
        request.setAttribute("mun", mun);
        RequestDispatcher rd=request.getRequestDispatcher("frm_loc.jsp");
        rd.forward(request,response);
    }
    public void guardarNuevo(HttpServletRequest request, HttpServletResponse response) throws Exception{
        GestionLocalidad modelo=new GestionLocalidad();

        Localidad loc=new Localidad();
        loc.setNombre_localidad(request.getParameter("localidad"));
        loc.setId_municipio(Integer.parseInt(request.getParameter("municipio")));
        

        if(modelo.registro(loc)){
            RequestDispatcher rd=request.getRequestDispatcher("controladorlocalidad?operacion=listar");
            request.setAttribute("msg", "Datos guardados");
            rd.forward(request,response);
            }
            else{
                RequestDispatcher rd=request.getRequestDispatcher("controladorlocalidad?operacion=nuevo");
                request.setAttribute("msg", "Error al guardar. Intente de nuevo más tarde");
                rd.forward(request,response);
            }
        
    }
    public void eliminar(HttpServletRequest request, HttpServletResponse response) throws Exception{
        int id_localidad=Integer.parseInt(request.getParameter("id"));
            GestionLocalidad modelo=new GestionLocalidad();
            if(modelo.eliminarPorId(id_localidad)){
                RequestDispatcher rd=request.getRequestDispatcher("controladorlocalidad?operacion=listar");
                request.setAttribute("msg", "Datos eliminados");
                rd.forward(request,response);
            }
            else{
                RequestDispatcher rd=request.getRequestDispatcher("controladorlocalidad?operacion=listar");
                request.setAttribute("msg", "Error al eliminar. La localidad se encuentra en uso.");
                rd.forward(request,response);
            }
    }
    
    public void modificar(HttpServletRequest request, HttpServletResponse response) throws Exception{
        int id_localidad=Integer.parseInt(request.getParameter("id"));
        GestionLocalidad modelo=new GestionLocalidad();
        Localidad loc =modelo.obtenerPorId(id_localidad);
        GestionMunicipio modmunicipio = new GestionMunicipio();
        ArrayList municipios = modmunicipio.obtenerTodos();
        request.setAttribute("municipios", municipios);
        request.setAttribute("loc", loc);
        RequestDispatcher rd=request.getRequestDispatcher("frm_locEditar.jsp");
        rd.forward(request,response);
    }
    
    public void modificarGuardar(HttpServletRequest request, HttpServletResponse response) throws Exception{
        int id_localidad = Integer.parseInt(request.getParameter("id_localidad"));
        int id_municipio = Integer.parseInt(request.getParameter("id_municipio"));;
        String nombre_localidad = request.getParameter("nombre_localidad");
        Localidad loc =new Localidad(id_localidad,id_municipio,nombre_localidad);
        GestionLocalidad modelo=new GestionLocalidad();
        if(modelo.actualizar(loc)){
            RequestDispatcher rd=request.getRequestDispatcher("controladorlocalidad?operacion=listar");
            request.setAttribute("msg", "Datos guardados");
            rd.forward(request,response);
            }
            else{
                RequestDispatcher rd=request.getRequestDispatcher("controladorlocalidad?operacion=listar");
                request.setAttribute("msg", "Error al guardar");
                rd.forward(request,response);
            }
    }
    
    public void reporte(HttpServletRequest request, HttpServletResponse response) throws Exception{
        Map param = new HashMap();
        generarReporte("ReporteLocalidades.jasper", param, request, response);
    }

    }
