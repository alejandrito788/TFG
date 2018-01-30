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
            <script src="https://code.jquery.com/jquery-latest.min.js"></script>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
            
        <!-- CartoDB para Mapas -->
        <link rel="stylesheet" href="https://cartodb-libs.global.ssl.fastly.net/cartodb.js/v3/3.15/themes/css/cartodb.css"/>
        <script src="https://cartodb-libs.global.ssl.fastly.net/cartodb.js/v3/3.15/cartodb.js"></script>

        <!--bootstrap -->
        <link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
        <script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
        <link href="https://seiyria.github.io/bootstrap-slider/css/bootstrap-slider.css" rel="stylesheet">
        <script src="https://seiyria.github.io/bootstrap-slider/js/bootstrap-slider.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">     
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
        <!-- css-->
        <link rel="stylesheet" type="text/css" href="https://rawgit.com/alejandrito788/TFG/master/src/main/resources/PPrincipal.css">
        <!-- modulacion de codigo javascript-->
        <script src="https://rawgit.com/alejandrito788/TFG/master/src/main/resources/AmanecerWebService.js"></script>
        <script src="https://rawgit.com/alejandrito788/TFG/master/src/main/resources/MapaUbicaciones.js"></script>
        <script src="https://rawgit.com/alejandrito788/TFG/master/src/main/resources/TendenciaPeriodica.js"></script>
        
    </head>

    <body>
        <script>       
          /* ${pageContext.request.contextPath} CDN CONTROLADOR https://rawgit.com/alejandrito788/TFG/master/src/main/java/Controlador/PrincipalController.java*/
</script>

    <div class="container">
        <div class="row">
            <div class="col-md-1 col-xs-1 col-lg-1 col-xl-1">
                <img id="logo" src="https://rawgit.com/alejandrito788/TFG/master/src/main/resources/logo.png"/>
            </div>
            <div class="col-md-11 col-xs-11 col-lg-11 col-xl-11">
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
                     <div class="col-md-8 col-xs-8 col-xl-8 col-lg-8">
                  <label class="checkbox-inline">
                      <input type="checkbox"  checked id="botonPolideportivo" name="botonera"  value="botonRecogidaBici"  onchange="cambiaCapa(this,1)" data-toggle="toggle"/> Centros Deportivos/Zonas Verdes
                    </label><br/>
                <label class="checkbox-inline">
                    <input type="checkbox"  id="botonCarrilesBici" name="botonera"  value="botonCarrilesBici" onchange="cambiaCapa(this,2)" data-toggle="toggle"/> Ciclismo
               </label><br/>
                <label class="checkbox-inline">
                    <input type="checkbox"  id="botonZonasMusculacion" name="botonera"  value="botonZonasMusculacion" onchange="cambiaCapa(this,3)" data-toggle="toggle"/> Musculacion
                </label><br/>
                <label class="checkbox-inline">
                    <input type="checkbox" id="botonRuido" value="botonRuido"  name="botonera"  onchange="cambiaCapa(this,4)" data-toggle="toggle"/> Natacion/Playas/Voley
                </label><br/>
                <label class="checkbox-inline">
                    <input type="checkbox" id="botonZVerde" value="botonZVerde" name="botonera"  onchange="cambiaCapa(this,5)" data-toggle="toggle"/> Ruido
                </label><br/>               
                     </div>
                     <div class="col-md-4 col-xs-4 col-lg-4 col-xl-4">
                         <div class="panel panel-default">
                            <div class="panel-heading">
                                    <h4 class="panel-title">Filtra por distancia a ti (Km)</h4> 
                            </div>
                         </div>
                          
                                        <input id="filtradoKm" data-slider-id='ex1Slider' type="text" onchange="filtraKm(this.value)" data-slider-min="1" data-slider-max="20" data-slider-step="1" data-slider-value="20" style="display:none"/>               
                            
                       
                 </div>
               </div>
             </div>
         </div>
        </div>
        <div class="panel panel-default">
          <div class="container">
              <div class="row">
                  <div class="col-md-6 col-xl-6 col-xs-6 col-lg-6">
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
            <div class="col-md-1 col-xs-1 col-lg-1 col-xl-1">
                <image id="icono" src="https://rawgit.com/alejandrito788/TFG/master/src/main/resources/peaton.png" style="display:none"/>
            </div>
            <div class="col-md-2 col-xs-2 col-lg-2 col-xl-2">
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
         <div class="col-md-6 col-xs-6 col-xl-6 col-lg-6">
         <div id="panelHorario" class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><span class="glyphicon glyphicon-time"></span>Horario</h3>
            </div>
            <div class="panel-body">
                <div class="container">
                    <div class="row">
                        <div class="col-md-2 col-xl-2 col-xs-2 col-lg-2">
                <div id="panelHorario1" class="panel panel-default">
                    <div class="panel-heading">
                        <h6 class="panel-title">Amanecer</h6>
                    </div>
                    <div class="panel-body">
                     <label id="amanecer" value=""/>
                     </div>
                </div>
                        </div>
                        <div class="col-md-2 col-xl-2 col-xs-2 col-lg-2">
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
                            <div class="col-md-11 col-xs-11 col-lg-11 col-xl-11">
                                <div class="progress">
                                    <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" id="tendenciaProg" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 0%"></div>                        
                                </div>
                            </div>
                            <div class="col-md-1 col-xs-1 col-lg-1 col-xl-1">
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
