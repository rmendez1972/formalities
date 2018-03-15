/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import Modelo.GestionUsuario;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author SEDUVI
 */
public class ControladorAdministrador extends ControladorBase{
    
    public void mostrarAdmin(HttpServletRequest request, HttpServletResponse response) throws Exception{
        
            
            RequestDispatcher rd=request.getRequestDispatcher("scr_admin.jsp");
            rd.forward(request,response);
    }
    
    public void mostrarVentanilla(HttpServletRequest request, HttpServletResponse response) throws Exception{
        
            
            RequestDispatcher rd=request.getRequestDispatcher("scr_tramites.jsp");
            rd.forward(request,response);
    }
    
}
