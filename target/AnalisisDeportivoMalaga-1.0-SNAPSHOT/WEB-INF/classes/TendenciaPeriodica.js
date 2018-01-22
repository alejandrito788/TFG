/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
        var temporizador;
        var deporteInactivo = "list-group-item";
        var deporteActivo = "list-group-item active";
        var seleccionados = ["No", "No", "No","No"];
        var opera=0;    //Marca si el procesamiento esta operando o detenido

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
        }
