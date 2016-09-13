/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package javabeans;

/**
 *
 * @author arturo
 */
public class Tramite {
    private int id_tramite, dias_resolucion, id_unidadadministrativa;
    private String nombre;
    private String unidadAdministrativa;
    
    public Tramite(){}
    
    public Tramite(int id_tramite, int dias_resolucion, int id_unidadadministrativa, String nombre){
        this.id_tramite=id_tramite;
        this.dias_resolucion=dias_resolucion;
        this.id_unidadadministrativa=id_unidadadministrativa;
        this.nombre=nombre;
    }
    
     public Tramite(int id_tramite, int dias_resolucion, int id_unidadadministrativa, String nombre, String unidadAdministrativa){
        this.id_tramite=id_tramite;
        this.dias_resolucion=dias_resolucion;
        this.id_unidadadministrativa=id_unidadadministrativa;
        this.nombre=nombre;
        this.unidadAdministrativa=unidadAdministrativa;
    }

    public int getId_tramite() {
        return id_tramite;
    }

    public void setId_tramite(int id_tramite) {
        this.id_tramite = id_tramite;
    }

    public int getDias_resolucion() {
        return dias_resolucion;
    }

    public void setDias_resolucion(int dias_resolucion) {
        this.dias_resolucion = dias_resolucion;
    }

    public int getId_unidadadministrativa() {
        return id_unidadadministrativa;
    }

    public void setId_unidadadministrativa(int id_unidadadministrativa) {
        this.id_unidadadministrativa = id_unidadadministrativa;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getUnidadAdministrativa() {
        return unidadAdministrativa;
    }

    public void setUnidadAdministrativa(String unidadAdministrativa) {
        this.unidadAdministrativa = unidadAdministrativa;
    }
    
}
