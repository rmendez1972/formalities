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
public class Municipio {
    private int id_municipio;
    private String nombre;
    
    
    public Municipio(int id_municipio, String nombre){
        this.id_municipio=id_municipio;
        this.nombre=nombre;
    }
    
    public int getId_municipio() {
        return id_municipio;
    }
    public String getNombre() {
        return nombre;
    }
    
    public void setId_municipio(int id_municipio) {
        this.id_municipio = id_municipio;
    }
    public void setNombre(String nombre){
        this.nombre = nombre;
    }
    public Municipio(){}
    
    
}
