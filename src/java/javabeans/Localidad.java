/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package javabeans;

/**
 *
 * @author SEDETUS
 */
public class Localidad {
    private int id_localidad;
    private int id_municipio;
    private String nombre_localidad;
    private String municipio;

    public Localidad(int id_localidad,int id_municipio,String nombre_localidad){
        this.id_localidad = id_localidad;
        this.id_municipio=id_municipio;
        this.nombre_localidad=nombre_localidad;
    }
    
    
    public int getId_localidad(){
        return id_localidad;
    }
    
    public int getId_municipio() {
        return id_municipio;
    }
    public String getNombre_localidad() {
        return nombre_localidad;
    }
    
    public void setId_localidad(int id_localidad){
        this.id_localidad = id_localidad;
    }
    
    public void setId_municipio(int id_municipio) {
        this.id_municipio = id_municipio;
    }

    public void setNombre_localidad(String nombre_localidad){

        this.nombre_localidad= nombre_localidad;
    }
    public String getMunicipio() {
        return municipio;
    }

    public void setMunicipio(String municipio) {
        this.municipio = municipio;
    }
    public Localidad(){}
    
}
