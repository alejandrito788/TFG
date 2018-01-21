/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package POJO;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

/**
 *
 * @author alejandroMac
 */
public class Mapping {
    private static Mapping instancia;
    
    private static final Double latMalaga = 36.7585406;
    private static final Double lngMalaga = -4.3971722;   
    private static final String coordenadasWS1 = "https://maps.googleapis.com/maps/api/geocode/json?address=";
    private static final String coordenadasWS2 = "&key=AIzaSyAqiLdrJbjNt9DpCmxAIgsIVen_0EF-5hI";
    
    private static List<String> deporteGenerico;
    private static String latGen;
    private static String lngGen;
    private static int tendenciaGeneral;
    private static Boolean condicion;
    
    private static final Lock mutex1=new ReentrantLock();      //para garantizar exclusion mutua en hebras
    private static final Lock mutex2=new ReentrantLock();
    private static final Lock mutex3=new ReentrantLock();
    private static final Lock mutex4=new ReentrantLock();
    
    private Mapping(){
        condicion=false;
        tendenciaGeneral=0;
        latGen=latMalaga.toString();       //por defecto
        lngGen=lngMalaga.toString();
        deporteGenerico = new ArrayList();
        
    }
    
    public static Mapping getInstancia(){
        if(instancia==null){
            instancia=new Mapping();
        }
        return instancia;
    }
    
    

    public static String getCoordenadasWS1() {
        return coordenadasWS1;
    }

    public static String getCoordenadasWS2() {
        return coordenadasWS2;
    }

    public static String getLatGen() {
        synchronized(mutex1){
            return Mapping.latGen;
        }
    }

    public static void setLatGen(String lat) {
        synchronized(mutex1){
            Mapping.latGen = lat;
        }
    }

    public static String getLngGen() {
        synchronized(mutex1){
            return Mapping.lngGen;
        }
    }

    public static void setLngGen(String lng) {
        synchronized(mutex1){
            Mapping.lngGen = lng;
        }
    }
    
    public static int getTendenciaGeneral(){
        synchronized(mutex3){
            return Mapping.tendenciaGeneral;
        }
    }
    
    public static void setTendencia(int v) {
        synchronized(mutex3){
            Mapping.tendenciaGeneral=v;
        }
    }

    public static List<String> getDeporteGenerico() {
        synchronized(mutex2){
            return Mapping.deporteGenerico;
        }
    }

    public static void setDeporteGenerico(String deporte, boolean add) {
        synchronized(mutex2){
        if(!add){
            Mapping.deporteGenerico.remove(deporte);
        }else{
            Mapping.deporteGenerico.add(deporte);
        }
        }
    }
    
    public synchronized static void setListaDeporte(List<String> lista){
        synchronized(mutex2){
            Mapping.deporteGenerico=lista;
        }
    }
    
    

    public static Double getLatMalaga() {
        return latMalaga;
    }

    public static Double getLngMalaga() {
        return lngMalaga;
    }
    
    public static void operativo(){
        synchronized(mutex4){
        while(!condicion){  try {
            //Si despierta por error vuelve a dormir
            mutex4.wait();
            } catch (InterruptedException ex) {}
        }
        }
    }

    public static Boolean isCondicion() {
        synchronized(mutex4){
            return condicion;
        }
    }

    public static void setCondicion(boolean condicion) {
        synchronized(mutex4){
            Mapping.condicion = condicion;  
            if(condicion){
                mutex4.notify();
            }
        }
    }
 
}
