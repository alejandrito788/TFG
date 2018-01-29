/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import POJO.Mapping;
import Twitter.TwitterAnalisis;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

/**
 *
 * @author alejandroMac
 */

@Controller
@RequestMapping(value="/")

public class PrincipalController {   
    private TwitterAnalisis twitter;
    
    @RequestMapping(method=RequestMethod.GET)
    public String init(Locale local){
        Mapping map = Mapping.getInstancia();
        
        if(twitter==null){      //INICIO           
            twitter = TwitterAnalisis.getConexion();
            twitter.start();
        }
        
        return "PPrincipal";
    }
    
    @RequestMapping(value="actualizaTendencia", method=RequestMethod.GET)
    @ResponseBody
    public String actualizaTendencia() {
            Integer tendencia = Mapping.getTendenciaGeneral();
            Integer numTweets = Mapping.getNumeroTweets();
            
            return tendencia.toString()+";"+numTweets.toString();
    }
    
    
    @RequestMapping(value="mostrarMapa/{direccion}", method=RequestMethod.GET)
    @ResponseBody
    public String[] mostrarMapa(@PathVariable("direccion") String direccion) {
            
           String[] aux=addUbicacion(direccion);
           Mapping.setLatGen(aux[0]);
           Mapping.setLngGen(aux[0]);
           
           return aux;
    }
     
    @RequestMapping(value="miTendencia/{deporte}", method=RequestMethod.POST)
    @ResponseBody
    public String miTendencia(@PathVariable("deporte") String deporte) {

           if(Mapping.getDeporteGenerico().contains(deporte)){
               Mapping.setDeporteGenerico(deporte,false);   //ELIMINA
               if(Mapping.getDeporteGenerico().isEmpty()){
                    Mapping.setTendencia(0);
               }
           }else{
               Mapping.setDeporteGenerico(deporte,true); //ADD A LISTA DEPORTIVA SELECCIONADA
               if(!Mapping.isCondicion()){
                    Mapping.setCondicion(true);                   
                }
           }
            
            return "PPrincipal";
    }
    
    @RequestMapping(value="flujoTwitter", method=RequestMethod.POST)
    @ResponseBody
    public String flujoTwitter() {
        List<String> lista = new ArrayList(); //vacia
        Mapping.setListaDeporte(lista);

                Mapping.setCondicion(false);        //PARA FLUJO TWITTER
                
                return "PPrincipal";
                
    }
    
    private String[] addUbicacion(String dir){      //CLIENTE WEB SERVICE GEOCODING

        String direccion = dir.replace(' ', '+');
        RestTemplate rt = new RestTemplate();
        String res = rt.getForObject(Mapping.getCoordenadasWS1()+direccion+Mapping.getCoordenadasWS2(),String.class);
        JSONObject obj = new JSONObject(res);
        String lat = Double.toString(obj.getJSONArray("results").getJSONObject(0).getJSONObject("geometry").getJSONObject("location").getDouble("lat"));
        String lng = Double.toString(obj.getJSONArray("results").getJSONObject(0).getJSONObject("geometry").getJSONObject("location").getDouble("lng"));
        
        return new String[]{lat,lng};
    }  
}
