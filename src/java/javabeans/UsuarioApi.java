/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package javabeans;

/**
 *
 * @author arturo
 */
public class UsuarioApi {
    
    public UsuarioApi () {
        super();
    }
    
    private int id;
    private String username;
    private String password;
    private String firstname;
    private String lastname;
    private int id_grupo;
    private int id_unidadadministrativa;
    private int id_direccion;

      
    
    
    
    public UsuarioApi( String username, String password){
        this.username=username;
        this.password=password;
     }
    
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }
    
    public int getId_grupo() {
        return id_grupo;
    }

    public void setId_grupo(int id_grupo) {
        this.id_grupo = id_grupo;
    }
    
    public int getId_unidadadministrativa() {
        return id_unidadadministrativa;
    }

    public void setId_unidadadministrativa(int id_unidadadministrativa) {
        this.id_unidadadministrativa = id_unidadadministrativa;
    }

    public int getId_direccion() {
        return id_direccion;
    }

    public void setId_direccion(int id_direccion) {
        this.id_direccion = id_direccion;
    }

    
}
