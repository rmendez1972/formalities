/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import java.sql.ResultSet;
import java.util.ArrayList;
import javabeans.Status;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;


/**
 *
 * @author arturo
 */
public class GestionStatus {
    private Object request;
    public boolean registroStatus(Status stat){
        Object params[]={stat.getNombre()};
        return Conexion.ejecutar("insert into status (nombre) values (?)", params);
    }
    
    public Status obtenerPorId(int id_status){
        Object params[]={id_status};
        Status stat=null;
        ResultSet res=Conexion.ejecutarConsulta("select * from status where id_status=?", params);
        try{
            if(res.next()){
                stat=new Status(res.getInt("id_status"), res.getString("nombre"));
            }
            res.close();
        }catch(Exception e){}
        return stat;
    }
    
    public ArrayList obtenerTodos(){
        ArrayList lista=new ArrayList();
        ResultSet res=Conexion.ejecutarConsulta("select * from status order by id_status asc", null);
             
        //Integer id_grupo=1;
        Integer mid_status;
        
        try{
            while(res.next()){
                Status st=new Status(res.getInt("id_status"), res.getString("nombre"));
                mid_status=(res.getInt("id_status"));
                lista.add(st);
            }
            res.close();
        }catch(Exception e){}
        return lista;
    }
    
    public ArrayList obtenerTodosGrupo(int id_grupo){
        ArrayList lista=new ArrayList();
        ResultSet res=Conexion.ejecutarConsulta("select * from status order by id_status asc", null);
             
        //Integer id_grupo=1;
        Integer mid_status;
        
        try{
            while(res.next()){
                Status st=new Status(res.getInt("id_status"), res.getString("nombre"));
                mid_status=(res.getInt("id_status"));
                if (mid_status!=7 && id_grupo==2){
                lista.add(st);
               }
                if (mid_status==7 && id_grupo==4){
                lista.add(st);
               }
            }
            res.close();
        }catch(Exception e){}
        return lista;
    }
    
    
    public boolean eliminarPorId(int id_status){
        Object params[]={id_status};
        return Conexion.ejecutar("delete from status where id_status=?", params);
    }
    
    public boolean actualizar(Status status){
        Object params[]={status.getNombre(), status.getId_status()};
        return Conexion.ejecutar("update status set nombre=? where id_status=?", params);
    }
}
