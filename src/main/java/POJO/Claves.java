/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package POJO;

/**
 *
 * @author alejandroMac
 */
public enum Claves {
    ClavesCorrer(new String[]{"run","running","correr","footing","trotar","entrenamiento", "entrenar", "aerobico", "anaerobico",
    "cross","tartan","pista","atletismo","lisos","zapatillas","miles","pronacion","supinacion","pronador", "entrenamientos",
    "supinador","maraton","carrera","olimpiadas","olimpicos","carreras","zancada","zancadas","trote","calentar","calentamiento","series","atleta","atletas","competicion",
    "competiciones","racetrack","trail","training","trainings", "train","jogging","aerobic","anaerobic","countryside","marathon","track","athletics", "thousands",
    "smooths","race","races","diamong","olimpics","sneakers","stride","strides","competition","competitions","athlete","athletes","Bolt","Jamaica","Lewis","Powell",
    "Bekele","Etiopia"}),
    
    ClavesCiclismo(new String[]{"bici","bicis","bicicleta","bicicletas","ciclista","ciclistas","ruta","rutas","pedal","pedales","equipos","equipo","calentar","calientan","entrenamiento","rodar",
    "entrenamientos","tour","vuelta","giro","etapa","etapas","carrera","carreras","peloton","pelotones","specialized","scott","orbea","look","palo","ataque","escalar","ataques",
    "escalador","sprint","sprints","sprinter","sprinters","carretera","montaña","descenso","bike","bikes","bicycle","bicycles","route","routes","team","teams","warm","train",
    "training","trainings","ride","race","races","stage","stages","squad","squads","attack","attacks","climb","scaler","road","mountain","downhill","Contador","Purito",
    "Valverde","Froome","Nibali","Astana","Movistar","Sky"}),
    
    ClavesNadar(new String[]{"piscina","piscinas","playa","playas","marea","ola","olas","nadar","natacion","nadando","equipos","equipo","calentar","calientan","entrenamiento", "entrenamientos",
    "brazada","brazadas","olimpica","olimpicas","olimpico","olimpicos","corta","crol","rolido","apnea","buceo","baño","baños","chapuzon","chapuzones","bañador","bañadores",
    "gorro","gorros","gafas","neopreno","arena","neoprenos","espalda","braza","mariposa","estilos","pool","pools","beach","beaches","wave","waves","tide","swim","swimming","teams","team","warm",
    "train","training","armful","strokes","olimpic","olimpics", "short","diving","bath","baths","dip","dips","swimsuit","swimsuits","cap","googles","neoprene","wetsuits","styles",
    "butterfly","backstroke","breaststroke","Phelps","Thorp","record","records","Belmonte"}),
    
    ClavesOtros(new String[]{"entrenar","entrenamiento","entrenamientos","calentar","calentamiento","calentamientos","descalentar","equipo","equipos","tenis","futbol","baloncesto","golf","hockey",
    "boxeo","petanca","baseball","rugby","triatlon","delantero","delanteros","atacante","atacantes","defensa","defensas","portero","liga","ligas","porteros","alero","aleros","pivot","pivots","vision","juego","juegos",
    "olimpico","olimpicos","olimpica","olimpicas","extremos","extremo","centrales","central","aspirantes","pistas","campeones","estadios","cuadrilateros","redes","pelotas","golpeos","remates",
    "paradas","equipaciones","aspirante","campeon","pista","estadio","cuadrilatero","voleybol","red","pelota","bola","golpeo","cruzada","remate","parada","equipacion","entrenador","entrenadores",
    "gol","goles","punto","puntos","train","training","trainings","warm","warming","dimay","team","teams","tennis","football","basketball","boxing","petanque","triathlon","soccer","forward",
    "defense","defenses","goalkeeper","goalkeepers","eaves","game","games","olimpic","olimpics","central","centrals","aspirants","racetracks","champions","ring","rings","stadiums","stadium",
    "net","nets","ball","balls","hit","hits","attempts","detention","detentions","equipment","equipments","champion","volleyball","coach","coaches","crusade","goal","goals","point","points",
    "league","leagues","Madrid","Barcelona","Malaga","Sevilla","Cristiano","Messi","Michel","Ontiveros","Lebron","Curry","NBA","Nadal","Wilson","Alonso","Mclaren","Ferrari","Marquez","Honda",
    "Rossi","Yamaha","Noya","Brownlee","Mayweather","McGregor"});
    
    private final String[] claves;
    
    Claves(String[] aux){
        claves=aux;
    }
    
    public String[] getClaves(){
        return claves;
    }
}
