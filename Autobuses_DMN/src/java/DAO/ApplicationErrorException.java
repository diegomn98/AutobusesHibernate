/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

/**
 *
 * @author diego
 */
public class ApplicationErrorException extends Exception{
    
     int codigo;
    
    public ApplicationErrorException(String mensaje, int codigo){
        super(mensaje);
        this.codigo = codigo;  
    }
    
    @Override
    public String toString(){
        String s = "";
        s+="Error: "+super.getMessage()+"\n";
        s+="Codigo: "+this.codigo+"\n";
        return s;
    }
    
}
