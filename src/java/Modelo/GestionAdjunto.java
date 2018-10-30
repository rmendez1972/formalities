/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import java.sql.ResultSet;
import java.util.ArrayList;
import javabeans.Adjunto;
import javabeans.Seguimiento;

/**
 *
 * @author arturo
 */
public class GestionAdjunto {
    public boolean registroAdjunto(Adjunto adj){
        boolean res=false;
        Integer id_usuario=adj.getId_usuario();
        Integer id_seguimiento=adj.getId_seguimiento();
        String nombre=adj.getNombre();
          
        Object params[]={nombre,id_seguimiento,id_usuario};
        res=Conexion.ejecutar("insert into adjunto (nombre, id_seguimiento, id_usuario) values (?,?,?)", params);
        
        return res;
    }
    
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
        GestionAdjunto modelo= new GestionAdjunto();
        Adjunto adjunto=modelo.obtenerPorId(id_adjunto);
        int id_seguimiento=adjunto.getId_seguimiento();
        
        Boolean resultado=false;
        Object params[]={id_adjunto};
        resultado=Conexion.ejecutar("delete from adjunto where id_adjunto=?", params);
        if (resultado=true){
            int cuenta=cuentaAdjuntos(id_seguimiento);
            if (cuenta==0){
                GestionSeguimiento gs=new GestionSeguimiento();
                Seguimiento seguimiento=gs.obtenerPorIdDateTime(id_seguimiento);
                seguimiento.setAdjunto(false);
                gs.actualizarSeguimiento(seguimiento);
            }
        }
        return resultado;
    }
    
    public int cuentaAdjuntos(int id_seguimiento){
        int cuenta=0;
        Object params[]={id_seguimiento};
        ResultSet res=Conexion.ejecutarConsulta("select count(*) as cuenta from adjunto where id_seguimiento=?", params);
        try{
            while(res.next()){
                
                cuenta=res.getInt("cuenta");
                
            }
            res.close();
        }catch(Exception e){}
        return cuenta;
    }
}
