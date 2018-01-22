/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
    window.onload = init;
            var capas;
            var layerPrincipal;
            var map;
            var sql;
            var miUbicacion;
            var cartoMap;
            var centrosdeportivos = 1; //esta mostrandose
            var piscinas=0;
            var musculacion=0;
            var ruta = 'http://localhost:8080/AnalisisDeportivoMalaga';
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

    function ubicacionManual(){
            direccion = document.getElementById('direccionConcreta').value;
            
                $.ajax({
                type: 'GET',
                url: ruta+'/mostrarMapa/'+direccion,
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
