/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Twitter;


import POJO.Claves;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import POJO.Mapping;
import java.sql.Timestamp;
import java.util.ArrayList;
import twitter4j.GeoLocation;
import twitter4j.Paging;
import twitter4j.Query;
import twitter4j.QueryResult;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.conf.ConfigurationBuilder;

/**
 *
 * @author alejandroMac
 */
public class TwitterAnalisis extends Thread {
    
    private static final String userIdTwitter="534778501-";
    private static final String consumerKey= "g2HafRlquLwooEiujFhSOa9QV";
    private static final String consumerSecret= "k83rdLNpBIODwmsxCrIcU23u8B2QCwKOkSGXdj3ZwYSnhBTxEv";
    private static final String accessToken="EmUd0FarpkcNANdVpi1Fk1oj2dgLhtLbot5dsv19";
    private static final String tokenSecret="0jd2EGLpo92owFvSAWxlD8EvmrcZRLioAaZX1TcRKlv6I";
   
    private static final String[] correr = Claves.ClavesCorrer.getClaves();
    private static final String[] ciclismo = Claves.ClavesCiclismo.getClaves();
    private static final String[] nadar = Claves.ClavesNadar.getClaves();
    private static final String[] otros = Claves.ClavesOtros.getClaves();
    private static final int TIEMPO = 20000; //peticiones cada 20 segundos
    private static final int RADIO = 100; //km
    private static final int FACTOR = 3; //factor de reproduccion de tendencia

    private static TwitterAnalisis instancia;
    private TwitterFactory tFactory;
    private static Query query;
    private Twitter twitter;
    private static int tendencia;
    private static boolean coincidencia;
    private int[] numDeporte={0,0,0,0,0,0,0,0}; //valores actuales y totales de correr,ciclismo,nadar,otros
    private static List<String> deporte;
    private ConfigurationBuilder cb;
    
    
    private static int compara(String[]claves, String txt){
        if(txt!=null || !txt.equals(" ")){
        String[] palabras = txt.split(" ");
            for(int i=0;i<palabras.length;i++){
               for(int j=0; j<claves.length;j++){
                   if(claves[j].equalsIgnoreCase(palabras[i])){
                       coincidencia=true;
                      return 1;
                   }
               }
            }
        }
        return 0;
    }
    
    
    private TwitterAnalisis(){
        deporte = new ArrayList();
        this.configuraTwitter();
        tFactory = new TwitterFactory(cb.build());        
        twitter = tFactory.getInstance();
        coincidencia=false;
        query = new Query();
    }

    public static TwitterAnalisis getConexion() { //Singleton del stream
        if(instancia==null){
            instancia = new TwitterAnalisis();
        }
        return instancia;
    }
    
    private void configuraTwitter(){
        cb = new ConfigurationBuilder();
        cb.setDebugEnabled(true)
            .setOAuthAccessToken(userIdTwitter+accessToken)
            .setOAuthAccessTokenSecret(tokenSecret)
            .setOAuthConsumerKey(consumerKey)
            .setOAuthConsumerSecret(consumerSecret);
    }
    
   private void preparaContadores(int[] numDeporte){
       for(int i=0;i<(numDeporte.length-(numDeporte.length/2));i++){
           numDeporte[i+4]+=numDeporte[i];
           numDeporte[i]=0;
       }
   }
   
   private void recuerdaDeporteAnterior(List<String> deporteAnterior){
       deporteAnterior.removeAll(deporteAnterior);
                for(String s: deporte){
                    deporteAnterior.add(s);
                }
   }
    
    @Override
    public void run(){
        Timestamp tiempo = new Timestamp(1);
        int aumento=0;
        int numTweets=100;
        List<String> deporteAnterior=new ArrayList();
        while(true){

                Mapping.operativo();        //espera no activa si opcion twitter desactivada
                
            try {
                deporte = Mapping.getDeporteGenerico();
                
                if(deporte.size()<deporteAnterior.size()){   //si se han deseleccionado deportes
                    deportesBorrados(deporteAnterior);
                }
                
                if(!deporteAnterior.isEmpty() && !deporte.equals(deporteAnterior)){
                    tiempo.setTime(tiempo.getTime()-aumento);           //refresca cada vez que hay modificaciones en seleccion
                    aumento=0;
                }
                
                GeoLocation localizacion = new GeoLocation(Double.parseDouble(Mapping.getLatGen()),Double.parseDouble(Mapping.getLngGen()));
                query.setGeoCode(localizacion, RADIO, Query.Unit.km);
                query.setCount(100);                                     //Cada peticion obtiene 100 tweets o menos si no hay mas esperando
                QueryResult result = twitter.search(query);             //flujo tweets segun ubicacion usuario
                numTweets=query.getCount();
                aumento++;
                tiempo.setTime(tiempo.getTime()+1);

                for (Status status : (List<Status>) result.getTweets()) {
          
                  for(String s: deporte){
                    switch(s){
                    case "correr":
                        numDeporte[0] += compara(correr,status.getText());                        
                    break;
                    case "ciclismo":
                        numDeporte[1] += compara(ciclismo,status.getText());                
                    break;
                    case "nadar":
                         numDeporte[2] += compara(nadar,status.getText());
                    break;
                    case "otros":
                        numDeporte[3]+= compara(otros, status.getText());
                    break;
                    }
                  }
                }                 
                
                if(coincidencia){
                    for(int i=0;i<(numDeporte.length-(numDeporte.length/2));i++){                       
                        tendencia+=numDeporte[i];
                    }
                    tendencia=(int) ((int) tendencia/tiempo.getTime())*FACTOR;
                }
                    
                Mapping.setTendencia(tendencia);              
                recuerdaDeporteAnterior(deporteAnterior);
 
                coincidencia=false;
                preparaContadores(numDeporte);
                query.setSinceId(query.getSinceId()+100);
                
                if(numTweets<70){                           //avisara de que empieza a no ser significativo
                    Mapping.setNumeroTweets(numTweets); 
                }
              
                this.sleep(TIEMPO);
               
                
                } catch (TwitterException | InterruptedException ex) {
                Logger.getLogger(TwitterAnalisis.class.getName()).log(Level.SEVERE, null, ex);
            }
            
        }   
        
    }
 
    public void deportesBorrados(List<String> anterior){
        for(String s: anterior){
            if(!deporte.contains(s)){
              switch (s){
                    case "correr":
                        tendencia -= numDeporte[4];
                        numDeporte[4]=0;
                        break;
                    case "ciclismo":
                        tendencia -= numDeporte[5];
                        numDeporte[5]=0;                      
                        break;
                    case "nadar":
                        tendencia -= numDeporte[6];
                        numDeporte[6]=0;                     
                        break;
                    case "otros":
                        tendencia -= numDeporte[7];
                        numDeporte[7]=0;                     
                        break;
               }
            }
        }
        
    }
    
}