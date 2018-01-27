<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Analisis Deportivo Ciudad Malaga</title>
         <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
        
        <!-- javascript jquery -->
            <script src="http://code.jquery.com/jquery-latest.min.js"></script>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
            
        <!-- CartoDB para Mapas -->
        <link rel="stylesheet" href="https://cartodb-libs.global.ssl.fastly.net/cartodb.js/v3/3.15/themes/css/cartodb.css"/>
        <script src="https://cartodb-libs.global.ssl.fastly.net/cartodb.js/v3/3.15/cartodb.js"></script>

        <!--bootstrap -->
        <link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
        <script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
        <link href="http://seiyria.github.io/bootstrap-slider/css/bootstrap-slider.css" rel="stylesheet">
        <script src="http://seiyria.github.io/bootstrap-slider/js/bootstrap-slider.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">     
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
        <!-- css-->
        <link rel="stylesheet" type="text/css" href="https://rawgit.com/alejandrito788/TFG/master/src/main/resources/PPrincipal.css">
        <!-- modulacion de codigo javascript-->
        <script src="https://rawgit.com/alejandrito788/TFG/master/src/main/resources/AmanecerWebService.js"></script>
        <script src="https://rawgit.com/alejandrito788/TFG/master/src/main/resources/MapaUbicaciones.js"></script>
        <script src="https://rawgit.com/alejandrito788/TFG/master/src/main/resources/TendenciaPeriodica.js"></script>
    
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      /*#map {
        height: 80%;        
        width: 100%;
      }
  
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      
      div.cartodb-tooltip {
        position: absolute;
        width: 350px;
        max-width: none; 
        overflow-y: hidden;
        z-index: 50;        
      }
      
      h1{
        font-family: Vegur, Verdana, Sans-serif;
        font-weight: 800;
        font-size: 500%;
        text-align: center;
        }
        .page-header{
            background: lightblue url("http://3.bp.blogspot.com/-Ahb4YdtrgUg/T-UyP31pc5I/AAAAAAAAABs/8mjzvDAE4M8/s1600/cielo%20claro.JPG") no-repeat
        }
        #map{
            border: solid;
        }
        #panelHorario{
            width: 450px;        
            position: relative;
            margin-left: 110px;
        }
        #panelHorario1{
            width:170px;
        }
        #panelHorario2{
            width:170px;
        }
        
        #panelUbicacion{
            width: 300px;
            margin-left:10px;
        }
        #icono{
            height: 50px;
            width: 50px;
        }
        #logo{
            height:80px;
            width:80px;
            left:150px;
            top:30px;
            padding: 5px;
            position:absolute;
        }
        .item{
           padding:50px;      
        } */

    </style>
    
    
    
    </head>

    <body>
        <script>       
          /* ${pageContext.request.contextPath} CDN CONTROLADOR https://rawgit.com/alejandrito788/TFG/master/src/main/java/Controlador/PrincipalController.java
           * fetch('https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400&date=today').then((respuesta)=>{
               return respuesta.json();
            }).then((respuesta)=>{
                if(respuesta.status==="OK"){                   
                    document.getElementById("amanecer").innerHTML=respuesta.results.sunrise;
                    document.getElementById("atardecer").innerHTML=respuesta.results.astronomical_twilight_end;
                }else{
                    alert("Horario indeterminado");
                }
            });   */                                       //asincrono. Llama a la funcion cuando recibe respuesta del servicio
        </script>
        <script>          
           /* var centrosdeportivos = 1; //esta mostrandose
            var piscinas=0;
            var musculacion=0;
        function cambiaCapa(obj,i){
            
            if(obj.checked){
              switch (i){
                  case 1:     //centros deportivos + zonas verdes 
                    if(piscinas===0 && musculacion===0){
                        capas[2].setSQL("SELECT * FROM centrosdeportivos");
                        capas[2].show();  
                    }
                    capas[4].show();
                    centrosdeportivos=1;
                    break;
                case 2:     //estacionamientos bici + carriles bici
                    capas[0].show();
                    capas[1].show();
                    break;
                case 3:     //musculacion
                    capas[2].show();
                    capas[2].setSQL("SELECT * FROM centrosdeportivos WHERE nombre LIKE 'ZONA DE%' OR nombre LIKE 'GIM%'");
                    musculacion=1;
                    break;
                case 4:     //piscinas + playas accesibles + voley
                    capas[5].show();
                    capas[6].show();
                    capas[2].show();
                    capas[2].setSQL("SELECT * FROM centrosdeportivos WHERE nombre_ins LIKE 'PISCINA%'");
                    piscinas=1;
                    break;
                case 5:     //ruido
                    capas[3].show();  
                    break;
              }
          }else{
              switch (i){
                  case 1:     //centros deportivos + zonas verdes 
                    if(piscinas===1){
                        capas[2].setSQL("SELECT * FROM centrosdeportivos WHERE nombre_ins LIKE 'PISCINA%'");
                    }else if(musculacion===1){
                        capas[2].setSQL("SELECT * FROM centrosdeportivos WHERE nombre LIKE 'ZONA DE%' OR nombre LIKE 'GIM%'");
                    }else{
                        capas[2].hide();                 
                    }
                    capas[4].hide();
                    centrosdeportivos=0;
                    break;
                case 2:     //estacionamientos bici + carriles bici
                    capas[0].hide();
                    capas[1].hide();
                    break;
                case 3:     //musculacion
                    if(piscinas===1){
                        capas[2].setSQL("SELECT * FROM centrosdeportivos WHERE nombre_ins LIKE 'PISCINA%'");
                    }else if(centrosdeportivos===1){
                        capas[2].setSQL("SELECT * FROM centrosdeportivos");
                    }else{
                        capas[2].hide();
                    }
                    musculacion=0;
                    break;
                case 4:     //piscinas + playas accesibles + voley
                    if(musculacion===1){
                        capas[2].setSQL("SELECT * FROM centrosdeportivos WHERE nombre LIKE 'ZONA DE%' OR nombre LIKE 'GIM%'");
                    }else if(centrosdeportivos===1){
                        capas[2].setSQL("SELECT * FROM centrosdeportivos");
                    }else{
                        capas[2].hide();
                    }
                    capas[5].hide();
                    capas[6].hide();
                    piscinas=0;
                    break;
                case 5:     //ruido
                    capas[3].hide();  
                    break;
              }
          }
        }
        
        function detieneProceso(){
            opera=0;
            clearInterval(temporizador);
            
            $.ajax({
                type: 'POST',
                url: '${pageContext.request.contextPath}/flujoTwitter',
                success: function(){
                    deseleccionaCampo(null);
                    document.getElementById('numTendencia').value=0;
                    iniciaBarraSeleccion();
                }
            });
      
        }

        
        function tendenciaPeriodica(){
            $.ajax({
                type: 'GET',
                url: '${pageContext.request.contextPath}/actualizaTendencia',
                success: function(result){                   
                    $('#numTendencia').val(result);
                    iniciaBarraSeleccion();
                }
            });
                                 
        }

            
        function ubicacionManual(){
            direccion = document.getElementById('direccionConcreta').value;
            
                $.ajax({
                type: 'GET',
                url: '${pageContext.request.contextPath}/mostrarMapa/'+direccion,
                success: function(result){                   
                    $('#miLat').val(result[0]);
                    $('#miLng').val(result[1]);
                    marcarPunto();
               
                },
                error: function(){
                    alert('Direccion no valida');
                }
            });
            
        }
        
        function formaConsulta(result,val){
            var primero=true;
                    var lista = "(";
                    for(i=0;i<result.total_rows;i++){                       
                        if(result.rows[i].area/1000<=val){
                            if(primero){
                                lista+=result.rows[i].cartodb_id;
                                primero=false;
                            }else{
                                lista+=","+result.rows[i].cartodb_id;
                            }
                        }
                    }
                    lista+=")";
                    return lista;
        }
        
        function filtraKm(val){ //distancia requerida en km
            coorY = document.getElementById('miLng').value;
            coorX = document.getElementById('miLat').value;
        
            $.ajax({
                type: 'GET',
                url: 'https://alejandroruiz3cstudent.carto.com/api/v2/sql?q=SELECT cartodb_id, ST_Distance(the_geom::geography, ST_SetSRID(ST_Point('+coorY+','+ coorX+'),4326)::geography) as area FROM centrosdeportivos',
                success: function(result){  //devuelve el resultado con la distancia en metros
                    var lista = formaConsulta(result,val);
                   
                    if(piscinas===1){
                        capas[2].setSQL("SELECT * FROM centrosdeportivos WHERE (nombre_ins LIKE 'PISCINA%') AND (cartodb_id IN"+lista+")");
                    }else if(musculacion===1){
                        capas[2].setSQL("SELECT * FROM centrosdeportivos WHERE (nombre LIKE 'ZONA DE%' OR nombre LIKE 'GIM') AND (cartodb_id IN"+lista+")");
                    }else if(centrosdeportivos===1){
                        capas[2].setSQL("SELECT * FROM centrosdeportivos WHERE cartodb_id IN"+lista);
                    }else{
                        alert('Centros deportivos no visibles');
                    }
                }
            });
        

        }
        
        function marcarPunto(){
            coorX = document.getElementById('miLat').value;
            coorY = document.getElementById('miLng').value;
            $.ajax({
                type: 'GET',
                url: 'https://alejandroruiz3cstudent.carto.com/api/v2/sql?q=UPDATE ubicacion SET the_geom = ST_SetSRID(ST_Point('+coorY+', '+coorX+'),4326)&api_key=023233c224c77f28720b02d0ab79fbd9fbca3dec',
                success: function(){   
                    $.ajax({
                            type: 'GET',
                            url: 'https://alejandroruiz3cstudent.carto.com/api/v2/sql?q=UPDATE ubicacion SET lon = '+coorY+'&api_key=023233c224c77f28720b02d0ab79fbd9fbca3dec'
                
                            });
                    $.ajax({
                            type: 'GET',
                            url: 'https://alejandroruiz3cstudent.carto.com/api/v2/sql?q=UPDATE ubicacion SET lat = '+coorX+'&api_key=023233c224c77f28720b02d0ab79fbd9fbca3dec'               
                            });
                            
                    miUbicacion.show();
                    
                    filtrakm = document.getElementById('filtradoKm');
                    
                    if(filtrakm.value<20){
                        filtraKm(filtrakm.value);
                    }
               
                },
                error: function(){
                    alert('Ubicacion no disponible');
                }
            });   

        }
        
            function procesaInformacion(obj){  
                if(obj===null){
                    if(navigator.geolocation){          
                        navigator.geolocation.getCurrentPosition(function(objPosicion){
                        var iLat = objPosicion.coords.latitude;
                        var iLng = objPosicion.coords.longitude;
                        document.getElementById('miLat').value=iLat;
                        document.getElementById('miLng').value=iLng;
                        marcarPunto();                  
                        }); 
                        
                    }else{
                        alert('Su ubicacion no pudo actualizarse automaticamente. \n\Compruebe si su navegador lo permite.');
                    }
                    
                }else if(obj.checked){                   
                     
                        document.getElementById("direccionConcreta").style.display='block';
                        document.getElementById("icono").style.display='block';
                        document.getElementById("btnUbicacion").style.display='block';

                                  
                    
               }else{
                        document.getElementById("direccionConcreta").style.display='none';
                        document.getElementById("icono").style.display='none';
                        document.getElementById("btnUbicacion").style.display='none';
                        miUbicacion.hide();
                }
            }
            
        function esUltimo(){
             for(i=0;i<seleccionados.length;i++){
                 if(seleccionados[i]==="Si")return false;
             }
             return true;
        }

        function deporteSeleccionado(i){           
          var deporte;
          switch(i){
                case 1:
                    deporte='correr';
                    document.getElementById('deporteConcreto').value='correr';                    
                    break;
                case 2:
                    deporte='ciclismo';
                    document.getElementById('deporteConcreto').value='ciclismo'; 
                    break;
                case 3:
                    deporte='nadar';
                    document.getElementById('deporteConcreto').value='nadar'; 
                    break;
                case 4:
                    deporte='otros';
                    document.getElementById('deporteConcreto').value='otros'; 
                    break;
            }
          
           
          if(seleccionados[i-1]==="Si"){
              seleccionados[i-1]="No";
              if(esUltimo()){               
                  detieneProceso();
              }else{
                  deseleccionaCampo(i);
                  $.ajax({
                    type: 'POST',
                    url: '${pageContext.request.contextPath}/miTendencia/'+deporte
                  });
              }
                
          }else{

            $.ajax({
                type: 'POST',
                url: '${pageContext.request.contextPath}/miTendencia/'+deporte,
                success: function(){
                    seleccionados[i-1]="Si";
                    iniciaDeporteSeleccionado();
                    if(opera===0){
                        temporizador=setInterval('tendenciaPeriodica()',30000);
                        opera=1;
                    }
                }
            });
         
          }    
            
        }
        
        function deseleccionaCampo(obj){   //el ultimo solo se quitara pulsando stop
        
            if(obj===null){  //quita todo porque es con stop
                document.getElementById('Correr').className=deporteInactivo;
                document.getElementById('Ciclismo').className=deporteInactivo;
                document.getElementById('Nadar').className=deporteInactivo;
                document.getElementById('Otros').className=deporteInactivo;
                seleccionados = ["No", "No", "No","No"];
            }else{
                switch(obj){
                    case 1:
                        document.getElementById('Correr').className=deporteInactivo;
                        break;
                    case 2:
                        document.getElementById('Ciclismo').className=deporteInactivo;
                     break;
                 case 3:
                        document.getElementById('Nadar').className=deporteInactivo;
                     break;
                 case 4:
                        document.getElementById('Otros').className=deporteInactivo;
                     break;

                }
                seleccionados[obj-1]="No";
            }
        }*/
        </script>
        <script>
/*
        function iniciaDeporteSeleccionado(){
            deporte = document.getElementById('deporteConcreto').value;

             switch(deporte){
                case "correr":
                    document.getElementById('Correr').className=deporteActivo;
             
                    break;
                case "ciclismo":
                   document.getElementById('Ciclismo').className = deporteActivo;
                
                    break;
                case "nadar":
                    document.getElementById('Nadar').className=deporteActivo;
                  
                    break;
                case "otros":
                    document.getElementById('Otros').className=deporteActivo;
              
                    break;
            }
            
            
        }
        
        function iniciaBarraSeleccion(){
            x = "width: "+document.getElementById('numTendencia').value+"%"; 
               document.getElementById('tendenciaProg').style=x;
        }

        
        function iniciaMapa(){
            vizJson = 'http://alejandroruiz3cstudent.carto.com/api/v2/viz/59be2c0c-39a4-4c98-b28e-153f01fd531e/viz.json';
              cartodb.createVis('map', vizJson).done(function(vis, layers) {
                map = L.map('map');
                cartoMap=vis;
                layerPrincipal=layers[1];
                layers[1].getSubLayer(0).hide();layers[1].getSubLayer(1).hide();
                layers[1].getSubLayer(3).hide();
                layers[1].getSubLayer(5).hide();layers[1].getSubLayer(6).hide();
                layers[1].getSubLayer(7).hide();
         
                capas = [layers[1].getSubLayer(0),layers[1].getSubLayer(1),layers[1].getSubLayer(2),
                         layers[1].getSubLayer(3),layers[1].getSubLayer(4),layers[1].getSubLayer(5),
                          layers[1].getSubLayer(7)];
                
                miUbicacion = layers[1].getSubLayer(6);

        });

        }

	function init(){
            coorX = document.getElementById('miLat').value;
            coorY = document.getElementById('miLng').value;
            sql = new cartodb.SQL({ user: 'alejandroruiz3cstudent' });
            iniciaMapa();   
            procesaInformacion(null);
            var slider = new Slider("#filtradoKm", {
                            tooltip: 'always'
                          });

        }
        var capas;
        var layerPrincipal;
        var map;
        var sql;
        var miUbicacion;
        var cartoMap;
        var temporizador;
        deporteInactivo = "list-group-item";
        deporteActivo = "list-group-item active";
        seleccionados = ["No", "No", "No","No"];
        opera=0;    //Marca si el procesamiento esta operando o detenido
	window.onload = init;
        */
        
        </script>

    <div class="container">
        <div class="row">
            <div class="col-md-1">
                <img id="logo" src="https://rawgit.com/alejandrito788/TFG/master/src/main/resources/logo.png"/>
            </div>
            <div class="col-md-11">
                <h1>2TRAIN<small>Ciudad de Málaga</small></h1>
            </div>
        </div>
    </div>
        
                
    <div class="page-header">           
        <div id="contenedor">
            <div id="myCarousel" class="carousel slide">
                <ol class="carousel-indicators">
                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#myCarousel" data-slide-to="1"></li>
                    <li data-target="#myCarousel" data-slide-to="2"></li>
                </ol>
                <!-- Carousel items -->
                <div class="carousel-inner">
                    <div class="active item"><img  src="https://rawgit.com/alejandrito788/TFG/master/src/main/resources/natacion.jpg" alt="banner2" /></div>
                    <div class="item"><img  src="https://rawgit.com/alejandrito788/TFG/master/src/main/resources/ciclismo.jpg" alt="banner3" /></div>
                    <div class="item"><img  src="https://rawgit.com/alejandrito788/TFG/master/src/main/resources/correr.jpg" alt="banner4" /></div>     
                </div>
            <!-- Carousel nav -->
            <a class="carousel-control left" href="#myCarousel" data-slide="prev">&lsaquo;</a>
            <a class="carousel-control right" href="#myCarousel" data-slide="next">&rsaquo;</a>
            </div>
        </div>
    </div>
        
         <div id="map" class="media"></div>
       
         
        <div id="panelBotonera" class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Filtrado</h3>
            </div>
        <div class="panel-body">
             <div class="container">
                 <div clas="row">
                     <div class="col-md-8">
                  <label class="checkbox-inline">
                      <input type="checkbox"  checked id="botonPolideportivo" name="botonera"  value="botonRecogidaBici"  onchange="cambiaCapa(this,1)" data-toggle="toggle"/> Polideportivo
                    </label><br/>
                <label class="checkbox-inline">
                    <input type="checkbox"  id="botonCarrilesBici" name="botonera"  value="botonCarrilesBici" onchange="cambiaCapa(this,2)" data-toggle="toggle"/> Ciclismo
               </label><br/>
                <label class="checkbox-inline">
                    <input type="checkbox"  id="botonZonasMusculacion" name="botonera"  value="botonZonasMusculacion" onchange="cambiaCapa(this,3)" data-toggle="toggle"/> Musculacion
                </label><br/>
                <label class="checkbox-inline">
                    <input type="checkbox" id="botonRuido" value="botonRuido"  name="botonera"  onchange="cambiaCapa(this,4)" data-toggle="toggle"/> Natacion/Playas
                </label><br/>
                <label class="checkbox-inline">
                    <input type="checkbox" id="botonZVerde" value="botonZVerde" name="botonera"  onchange="cambiaCapa(this,5)" data-toggle="toggle"/> Ruido
                </label><br/>               
                     </div>
                     <div class="col-md-4">
                         <div class="panel panel-default">
                            <div class="panel-heading">
                                    <h4>Filtra por distancia a ti (Km)</h4> 
                            </div>
                             <div class="panel-body">
                                        <input id="filtradoKm" data-slider-id='ex1Slider' type="text" onchange="filtraKm(this.value)" data-slider-min="0" data-slider-max="20" data-slider-step="1" data-slider-value="20" style="display:none"/>               
                             </div>
                       </div>
                 </div>
               </div>
             </div>
         </div>
        </div>
          <div class="container">
              <div class="row">
                  <div class="col-md-6">
        <div id="panelUbicacion" class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Modifica tu ubicacion manualmente</h3>
            </div>
           <label id="etiquetaUbi" class="checkbox-inline" style="margin-left:15px">
                <input id="btnActivarUbicacion" value="activarUbicacion" type="checkbox" onchange="procesaInformacion(this)" data-toggle="toggle" data-onstyle="success"/>Visualizar              
           </label> 
            <br/>
            <div class="container">
                <div class="row">
            <div class="col-md-1">
                <image id="icono" src="https://rawgit.com/alejandrito788/TFG/master/src/main/resources/peaton.png" style="display:none"/>
            </div>
            <div class="col-md-2">
            <div class="panel-body">
                <input  type="text" id="direccionConcreta" value="C/..." style="display:none"/>
                <button id="btnUbicacion" onclick="ubicacionManual()" value="add" style="display:none"/>Actualizar  <br/>              
                <input type="hidden" id="miLat" value="36.7585406"/>
                <input type="hidden" id="miLng" value="-4.3971722"/>
            </div>
            </div>
                </div>
            </div>
        </div>
        </div>
         <div class="col-md-6">
         <div id="panelHorario" class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><span class="glyphicon glyphicon-time"></span>Horario</h3>
            </div>
            <div class="panel-body">
                <div class="container">
                    <div class="row">
                        <div class="col-md-2">
                <div id="panelHorario1" class="panel panel-default">
                    <div class="panel-heading">
                        <h6 class="panel-title">Amanecer</h6>
                    </div>
                    <div class="panel-body">
                     <label id="amanecer" value=""/>
                     </div>
                </div>
                        </div>
                        <div class="col-md-2">
                <div id="panelHorario2" class="panel panel-default">
                    <div class="panel-heading">
                        <h6 class="panel-title">Atardecer</h6>
                    </div>
                    <div class="panel-body">
                        <label id="atardecer" value=""/>
                    </div>
                </div>
                        </div>
                </div>
                </div>
            </div>
        </div>
              </div>
              </div>
          </div>
         <div id="panelCEP" class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Tendencia deportiva</h3>
            </div>
            <div class="panel-body">
                
                    <input type="hidden" id="deporteConcreto" value=""/>
                
                <div class="list-group">
                    <a id="Correr" onclick="deporteSeleccionado(1)" class="list-group-item" >Correr</a>
                    <a id="Ciclismo" onclick="deporteSeleccionado(2)" class="list-group-item" >Ciclismo</a>
                    <a id="Nadar" onclick="deporteSeleccionado(3)" class="list-group-item" >Nadar</a>
                    <a id="Otros" onclick="deporteSeleccionado(4)" class="list-group-item" >Otros</a>
                </div><br/><br/>
           
            
            <div id="panelProgress" class="panel panel-default">
                    <div class="panel-heading">
                        <h6 class="panel-title">Personas pensando en tus deportes seleccionados(%)</h6>
                    </div>
                    
                <div class="panel-body">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-11">
                                <div class="progress">
                                    <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" id="tendenciaProg" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 0%"></div>                        
                                </div>
                            </div>
                            <div class="col-md-1">
                                    <button type="button" onclick="ayuda()" class="btn btn-info">
                                        <span class="glyphicon glyphicon-question-sign"></span> 
                                     </button>
                            </div>
                        </div>
                    </div>
                    
                    <button type="button" onclick="detieneProceso()" class="btn btn-danger">Stop</button>
                </div>               
            </div>
            </div>

               <input type="hidden" id="numTendencia" value=""/>

    </body>
</html>
