/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;
import java.sql.ResultSet;
import java.util.ArrayList;
import javabeans.Municipio;
/**
 *
 * @author SEDETUS
 */
public class GestionMunicipio {
    public boolean registro(Municipio municipio){
        Object params[]={municipio.getNombre()};
        return Conexion.ejecutar("insert into municipio (nombre) values(?)", params);
    }
    
    public boolean actualizar(Municipio municipio){
        Object params[]={municipio.getNombre(), municipio.getId_municipio()};
        return Conexion.ejecutar("update municipio set nombre=? where id_municipio=?", params);
    }
    
    public Municipio obtenerPorId(int id_municipio){
        Municipio mun=null;
        Object params[]={id_municipio};
        ResultSet res=Conexion.ejecutarConsulta("select * from municipio where id_municipio=?", params);
        try{
            while(res.next()){
                mun=new Municipio(res.getInt("id_municipio"),res.getString("nombre"));
            }
            res.close();
        }catch(Exception e){}
        return mun;
    }
    
    public ArrayList obtenerTodos(){
        ArrayList mun=new ArrayList();
        ResultSet res=Conexion.ejecutarConsulta("select * from municipio order by nombre asc", null);
        try{
            while(res.next()){
                Municipio municipio=new Municipio(res.getInt("id_municipio"), res.getString("nombre"));
                mun.add(municipio);
            }
            res.close();
        }catch(Exception e){}
        return mun;
    }
    
    public boolean eliminarPorId(int id_municipio){
        Object params[]={id_municipio};
        return Conexion.ejecutar("delete from municipio where id_municipio=?", params);
    }
    
}
