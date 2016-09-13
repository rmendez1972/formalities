/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javabeans.Solicitante;
/**
 *
 * @author arturo
 */
public class GestionSolicitante {
    
    private Solicitante fromResultSet(ResultSet res){
        Solicitante sol=null;
        try{
            sol=new Solicitante();
            sol.setId_solicitante(res.getInt("id_solicitante"));
            sol.setNombre(res.getString("nombre"));
            sol.setApellido_paterno(res.getString("apellido_paterno"));
            sol.setApellido_materno(res.getString("apellido_materno"));
            sol.setTelefono(res.getString("telefono"));
            sol.setRfc(res.getString("rfc"));
            sol.setSexo(res.getString("sexo"));
            sol.setEmail(res.getString("email"));
            sol.setDireccion(res.getString("direccion"));
        }catch(Exception e){}
        return sol;
    }
    
    public long registroSolicitante(Solicitante sol){
        Object params[]={ sol.getNombre(), sol.getApellido_paterno(), sol.getApellido_materno(), sol.getTelefono(), sol.getRfc(), sol.getSexo(), sol.getEmail(), sol.getDireccion()};
        long res=-1;
        if(Conexion.ejecutar("insert into solicitante (nombre, apellido_paterno, apellido_materno, telefono, rfc, sexo, email, direccion) values(?,?,?,?,?,?,?,?)", params)){
            Object tmp=Conexion.ejecutarEscalar("select last_insert_id() as last_id from solicitante", null);
            if(tmp instanceof java.math.BigInteger){
                java.math.BigInteger res2=(java.math.BigInteger)tmp;
                res=res2.longValue();
            }
            else
                res=(Long)tmp;
        }
        return res;
        
    }
    
    public boolean actualizarSolicitante(Solicitante sol){
        Object params[]={sol.getNombre(), sol.getApellido_paterno(), sol.getApellido_materno(), sol.getTelefono(), sol.getRfc(), sol.getSexo(), sol.getEmail(), sol.getDireccion(), sol.getId_solicitante()};
        return Conexion.ejecutar("update solicitante set nombre=?, apellido_paterno=?, apellido_materno=?, telefono=?, rfc=?, sexo=?, email=?, direccion=? where id_solicitante=?", params);
    }
    
    public Solicitante obtenerPorId(int id_solicitante){
        Solicitante sol=null;
        Object[] params={id_solicitante};
        ResultSet res=Conexion.ejecutarConsulta("select * from solicitante where id_solicitante=?", params);
        try {
            if(res.next()){
                sol=fromResultSet(res);
            }
            res.close();
        } catch (Exception ex) {}
        
        return sol;
    }
    
    public ArrayList obtenerPorNombre(String nombre){
        ArrayList solicitantes=new ArrayList();
        Object[] params={"%"+nombre+"%"};
        ResultSet res=Conexion.ejecutarConsulta("select * from solicitante where concat(nombre,' ',apellido_paterno,' ',apellido_materno) like ? order by concat(nombre,' ',apellido_paterno,' ',apellido_materno) asc", params);
        try{
            while(res.next()){
                Solicitante sol=fromResultSet(res);
                solicitantes.add(sol);
            }
            res.close();
        }catch(Exception e){}
        return solicitantes;
    }
    
    public ArrayList obtenerPor(String campo, String valor){
        ArrayList solicitantes=new ArrayList();
        Object[] params={valor};
        ResultSet res=Conexion.ejecutarConsulta("select * from solicitante where "+campo+" like ? order by concat(nombre,' ',apellido_paterno,' ',apellido_materno) asc", params);
        try{
            while(res.next()){
                Solicitante sol=fromResultSet(res);
                solicitantes.add(sol);
            }
            res.close();
        }catch(Exception e){}
        return solicitantes;
    }
    
    public ArrayList obtenerTodos(){
        ArrayList solicitantes=new ArrayList();
        ResultSet res=Conexion.ejecutarConsulta("select * from solicitante order by concat(nombre,' ',apellido_paterno,' ',apellido_materno) asc", null);
        try{
            while(res.next()){
                Solicitante sol=fromResultSet(res);
                solicitantes.add(sol);
            }
            res.close();
        }catch(Exception e){}
        return solicitantes;
    }
    
    public boolean eliminarPorId(int id_solicitante){
        Object params[]={id_solicitante};
        GestionSolicitud gsol=new GestionSolicitud();
        gsol.eliminarPorSolicitante(id_solicitante);
        return Conexion.ejecutar("delete from solicitante where id_solicitante=?", params);
    }
}
