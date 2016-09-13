/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import java.sql.ResultSet;
import java.util.ArrayList;
import javabeans.Tramite;

/**
 *
 * @author arturo
 */
public class GestionTramite {
    
    public boolean registroTramite(Tramite t){
        Object params[]={t.getNombre(), t.getDias_resolucion(), t.getId_unidadadministrativa()};
        return Conexion.ejecutar("insert into tramite (nombre, dias_resolucion, id_unidadAdministrativa) values (?,?,?)", params);
    }
    
    public Tramite obtenerPorId(int id_tramite){
        Tramite t=null;
        Object params[]={id_tramite};
        ResultSet res=Conexion.ejecutarConsulta("select T.id_tramite as id_tramite, T.dias_resolucion as dias_resolucion, T.id_unidadadministrativa as id_unidadadministrativa, T.nombre as nombre, U.nombre as unidadAdministrativa from tramite T inner join unidadadministrativa U on T.id_unidadadministrativa=U.id_unidadadministrativa  where id_tramite=?", params);
        try{
            while(res.next()){
                t=new Tramite(res.getInt("id_tramite"), res.getInt("dias_resolucion"), res.getInt("id_unidadadministrativa"), res.getString("nombre"), res.getString("unidadAdministrativa"));
            }
            res.close();
        }catch(Exception e){}
        return t;
    }
    
    public ArrayList obtenerPorUnidadAdministrativa(int id_unidadadministrativa){
        ArrayList tramites=new ArrayList();
        Object params[]={id_unidadadministrativa};
        ResultSet res=Conexion.ejecutarConsulta("select * from tramite where id_unidadadministrativa=? order by nombre asc", params);
        try{
            while(res.next()){
                Tramite t=new Tramite(res.getInt("id_tramite"), res.getInt("dias_resolucion"), res.getInt("id_unidadadministrativa"), res.getString("nombre"));
                tramites.add(t);
            }
            res.close();
        }catch(Exception e){}
        return tramites;
    }
    
    public ArrayList obtenerTodos(){
        ArrayList tramites=new ArrayList();
        ResultSet res=Conexion.ejecutarConsulta("select T.id_tramite, T.dias_resolucion, T.id_unidadadministrativa, T.nombre, U.nombre as unidadAdministrativa from tramite T inner join unidadadministrativa U on T.id_unidadadministrativa=U.id_unidadadministrativa order by nombre asc", null);
        try{
            while(res.next()){
                Tramite t=new Tramite(res.getInt("id_tramite"), res.getInt("dias_resolucion"), res.getInt("id_unidadadministrativa"), res.getString("nombre"));
                t.setUnidadAdministrativa(res.getString("unidadAdministrativa"));
                tramites.add(t);
            }
            res.close();
        }catch(Exception e){}
        return tramites;
    }
    
    public boolean eliminarPorId(int id_tramite){
        Object params[]={id_tramite};
        Conexion.ejecutar("delete from tramite_requisito where id_tramite=?", params);
        return Conexion.ejecutar("delete from tramite where id_tramite=?", params);
    }
    
    public boolean actualizar(Tramite t){
        Object params[]={t.getNombre(), t.getDias_resolucion(), t.getId_unidadadministrativa(), t.getId_tramite()};
        return Conexion.ejecutar("update tramite set nombre=?, dias_resolucion=?, id_unidadadministrativa=? where id_tramite=?", params);
    }
    
    public boolean agregarRequisito(int id_tramite, int id_requisito){
        Object params[]={id_tramite, id_requisito};
        return Conexion.ejecutar("insert into tramite_requisito values (?,?)", params);
    }
    
    public boolean eliminarRequisito(int id_tramite, int id_requisito){
        Object params[]={id_requisito, id_tramite};
        return Conexion.ejecutar("delete from tramite_requisito where id_requisito=? and id_tramite=?", params);
    }
}
