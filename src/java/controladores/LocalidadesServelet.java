/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

//
import Modelo.GestionLocalidad;//
//import java.io.File;
//import java.io.FileInputStream;
import java.io.IOException;
//import java.io.OutputStream;
import java.io.PrintWriter;
//import java.io.StringWriter;

import java.sql.Connection;
//import java.sql.SQLException;
import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
//import javabeans.Tramite;
import javabeans.Localidad;//

//import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
//import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import net.sf.jasperreports.engine.JREmptyDataSource;
//import net.sf.jasperreports.engine.JRException;
//import net.sf.jasperreports.engine.JRExporter;
//import net.sf.jasperreports.engine.JRExporterParameter;
//import net.sf.jasperreports.engine.JasperFillManager;
//import net.sf.jasperreports.engine.JasperPrint;
//import net.sf.jasperreports.engine.JasperReport;
//import net.sf.jasperreports.engine.JasperRunManager;
//import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
//import net.sf.jasperreports.engine.export.JRPdfExporter;
//import net.sf.jasperreports.engine.util.JRLoader;

/**
 *
 * @author igh
 */
@WebServlet(name = "LocalidadesServelet", urlPatterns = {"/localidades"})
public class LocalidadesServelet extends HttpServlet 
{
    public LocalidadesServelet () 
    {
        //super();
    }
    String lista = "";
    public Connection cn;
    
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
                GestionLocalidad localidad = new GestionLocalidad();
                //acceder al metodo buscaPaises
                
                Localidad localidades = new Localidad();
                Integer id_municipio;
                if (request.getParameter("id_muniicpio")==""){
                    id_municipio=0;
                }else
                {    
                    id_municipio = Integer.parseInt(request.getParameter("id_municipio").toString());
                }
                ArrayList tm = localidad.obtenerPorMunicipio(id_municipio);
                if (tm.size() != 0) 
                {
                    lista = "\"" + "Localidades" + "\":" + "[";
                        for (int x = 0; x < tm.size(); x=x+1) 
                        {
                            
                            localidades=(Localidad) tm.get(x);
                            Integer id_localidad= localidades.getId_localidad();
                            String nombre= localidades.getNombre_localidad();
                            
                            lista += "{" + "\"" + "id_localidad" + "\"" + ":" + id_localidad.toString() + "," +"\"" + "nombre" + "\"" + ":" + " \"" + nombre + "\"" + "}" + ",";
                            //formar la cadena en formato JSON para enviarlo a la vista con jquery
                        }
                        //quitar la ultima coma para parsear la cadena JSON
                        lista = lista.substring(0, lista.length() - 1);
                } else 
                {
                    //out.println("No se logro obtener datos");
                    Integer id_tramite=0;
                    String nombre= "Sin trámites";
                    lista = "\"" + "Tramites" + "\":" + "["+"{" + "\"" + "id_tramite" + "\"" + ":" + id_tramite.toString() + "," +"\"" + "nombre" + "\"" + ":" + " \"" + nombre + "\"" + "}";
                }
            } finally 
        { 
            out.println("{" + lista + "]}");
            System.out.println("{" + lista + "]}");
            out.close();
        }
    }
    
       
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
            processRequest(request, response);
        } 
        catch (Exception ex) 
        {
            Logger.getLogger(Tramites2.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    try {
            processRequest(request, response);
        } catch (Exception ex) 
        {
            Logger.getLogger(Tramites2.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    @Override
    public String getServletInfo() 
    {
        return "Short description";
    }// </editor-fold>
    
}
