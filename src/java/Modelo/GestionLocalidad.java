/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;
import java.sql.ResultSet;
import java.util.ArrayList;
import javabeans.Localidad;
import javabeans.Tramite;
/**
 *
 * @author SEDETUS
 */
public class GestionLocalidad {
    public boolean registro(Localidad localidad){
        Object params[]={localidad.getId_municipio(),localidad.getNombre_localidad()};
        return Conexion.ejecutar("insert into localidad (id_municipio, nombre_localidad) values(?,?)", params);
    }
    
    public boolean actualizar(Localidad localidad){
        Object params[]={localidad.getNombre_localidad(),localidad.getId_municipio(),localidad.getId_localidad() };
        return Conexion.ejecutar("update localidad set nombre_localidad=?, id_municipio=? where id_localidad=?", params);
    }
    
    public Localidad obtenerPorId(int id_localidad){
        Localidad loc=null;
        Object params[]={id_localidad};
        ResultSet res=Conexion.ejecutarConsulta("select * from localidad where id_localidad=?", params);
        try{
            while(res.next()){
                loc=new Localidad(res.getInt("id_localidad"),res.getInt("id_municipio"),res.getString("nombre_localidad"));
            }
            res.close();
        }catch(Exception e){}
        return loc;
    }
    
    public ArrayList obtenerTodos(){
        ArrayList loc=new ArrayList();
        ResultSet res=Conexion.ejecutarConsulta("select * from localidad order by nombre_localidad asc", null);
        try{
            while(res.next()){
                Localidad localidad=new Localidad(res.getInt("id_localidad"),res.getInt("id_municipio"),res.getString("nombre_localidad"));
                loc.add(localidad);
            }
            res.close();
        }catch(Exception e){}
        return loc;
    }
    
    
    public boolean eliminarPorId(int id_localidad){
        Object params[]={id_localidad};
        return Conexion.ejecutar("delete from localidad where id_localidad=?", params);
    }
    
    //30-10-2018 igh
    public ArrayList obtenerPorMunicipio(int id_municipio){
        ArrayList localidades=new ArrayList();
        Object params[]={id_municipio};
        ResultSet res=Conexion.ejecutarConsulta("select * from localidad where id_municipio=? order by nombre_localidad asc", params);
        try{
            while(res.next()){
                Localidad t=new Localidad(res.getInt("id_localidad"), res.getInt("id_municipio"), res.getString("nombre_localidad"));
                localidades.add(t);
            }
            res.close();
        }catch(Exception e){}
        return localidades;
    }
}
