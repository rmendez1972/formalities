/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import static Modelo.conectaMysql.getConnection;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;
import javax.faces.context.FacesContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;
import static jdk.nashorn.tools.ShellFunctions.input;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.export.JRXlsAbstractExporterParameter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.engine.xml.JRXmlLoader;


/**
 *
 * @author arturo
 */
public class ControladorBase extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String operacion=request.getParameter("operacion");

        try{
            Class[] mParams={HttpServletRequest.class, HttpServletResponse.class};
            Method metodo=this.getClass().getMethod(operacion, mParams);
            metodo.invoke(this, request, response);
        }
        catch(Exception e){
            e.printStackTrace();
            return;
        }
    }
    
    public void generarReporte(String reporte, Map param, HttpServletRequest request, HttpServletResponse response) throws Exception{

            Connection cn=Modelo.conectaMysql.getConnection();
            File reportFile = new File(getServletConfig().getServletContext().getRealPath("/Reportes/"+reporte));
            
            byte[] bytes = null;
            bytes = JasperRunManager.runReportToPdf(reportFile.getPath(),param, cn);
            
            ServletOutputStream servletOutputStream = response.getOutputStream();
            response.setContentType("application/pdf");
                
            response.setContentLength(bytes.length);
            servletOutputStream.write(bytes, 0, bytes.length);
                
            servletOutputStream.flush();
            servletOutputStream.close();
    }
    
    public void generarReporteExcel(String reporte, Map param, HttpServletRequest request, HttpServletResponse response) throws ServletException, Exception{
        
        Connection cn=Modelo.conectaMysql.getConnection();
        
        String ruta = getServletConfig().getServletContext().getRealPath("/Reportes/"+reporte);
        InputStream input = new FileInputStream(new File(ruta));
            
        try{   

            JasperReport report = JasperCompileManager.compileReport(input);
            JasperPrint print = JasperFillManager.fillReport(report,param,cn);
            
            OutputStream out = response.getOutputStream();

            ByteArrayOutputStream arrayOutputStream = new ByteArrayOutputStream(); 
                  
            JRXlsxExporter exporter = new JRXlsxExporter();
            
            
            //OutputStream outputfile = new FileOutputStream(new File("JasperReport.xlsx"));

            exporter.setParameter(JRXlsExporterParameter.JASPER_PRINT, print);
            exporter.setParameter(JRXlsExporterParameter.OUTPUT_FILE_NAME, arrayOutputStream);
            exporter.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.TRUE);
            exporter.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE);
            exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE);
            exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);
           
            exporter.exportReport();
            
            
            response.setHeader("Content-disposition", "attachment; filename=ListadoPDF.xlsx");
            response.setContentType("application/vnd.ms-excel");
            response.setContentLength(arrayOutputStream.toByteArray().length);
            out.write(arrayOutputStream.toByteArray());
            out.flush();
            out.close();
            
            }catch(JRException e)
            {
                JOptionPane.showMessageDialog(null,e);;
            }       
    }
  
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
