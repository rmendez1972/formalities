/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import java.sql.ResultSet;
import java.util.ArrayList;
import javabeans.Adjunto;

/**
 *
 * @author arturo
 */
public class GestionAdjunto {
    /*public boolean registroStatus(Status stat){
        Object params[]={stat.getNombre()};
        return Conexion.ejecutar("insert into status (nombre) values (?)", params);
    }*/
    
    public Adjunto obtenerPorId(int id_adjunto){
        Object params[]={id_adjunto};
        Adjunto ad=null;
        ResultSet res=Conexion.ejecutarConsulta("select * from adjunto where id_adjunto=?", params);
        try{
            if(res.next()){
                ad=new Adjunto(res.getInt("id_adjunto"), res.getString("nombre"),res.getInt("id_seguimiento"),res.getInt("id_usuario"));
            }
            res.close();
        }catch(Exception e){}
        return ad;
    }
    
    public ArrayList obtenerTodos(){
        ArrayList lista=new ArrayList();
        ResultSet res=Conexion.ejecutarConsulta("select * from adjunto order by id_adjunto asc", null);
        try{
            while(res.next()){
                Adjunto ad=new Adjunto(res.getInt("id_adjunto"), res.getString("nombre"),res.getInt("id_seguimiento"),res.getInt("id_usuario"));
                lista.add(ad);
            }
            res.close();
        }catch(Exception e){}
        return lista;
    }
    
    
    public ArrayList obtenerPorSeguimiento(int id_seguimiento){
        ArrayList ad=new ArrayList();
        Object params[]={id_seguimiento};
        ResultSet res=Conexion.ejecutarConsulta("select AD.id_adjunto as id_adjunto, AD.nombre as nombre , AD.id_seguimiento as id_seguimiento, AD.id_usuario as id_usuario, U.nombre as nombreusuario  from adjunto AD inner join usuario U on AD.id_usuario=U.id_usuario  where AD.id_seguimiento=? order by id_adjunto desc", params);
        try{
            while(res.next()){
                Adjunto adjunto=new Adjunto(res.getInt("id_adjunto"), res.getString("nombre"), res.getInt("id_seguimiento"), res.getInt("id_usuario"));
                adjunto.setNombreusuario(res.getString("nombreusuario"));
                ad.add(adjunto);
            }
            res.close();
        }catch(Exception e){}
        return ad;
    }
    
    public boolean eliminarPorId(int id_adjunto){
        Object params[]={id_adjunto};
        return Conexion.ejecutar("delete from adjunto where id_adjunto=?", params);
    }
    /*
    public boolean actualizar(Status status){
        Object params[]={status.getNombre(), status.getId_status()};
        return Conexion.ejecutar("update status set nombre=? where id_status=?", params);
    }*/
}
