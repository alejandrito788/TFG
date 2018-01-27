/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

   /* global fetch */

fetch('https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400&date=today').then((respuesta)=>{
               return respuesta.json();
            }).then((respuesta)=>{
                if(respuesta.status==="OK"){                   
                    document.getElementById("amanecer").innerHTML=respuesta.results.sunrise;
                    document.getElementById("atardecer").innerHTML=respuesta.results.astronomical_twilight_end;
                }else{
                    alert("Horario indeterminado");
                }
            });
            
//CARRUSEL DE FOTOS
     $(document).ready(function(){
        $('.myCarousel').carousel({
            interval: 7000
        });
    });
   
//BOTON DE AYUDA EN ANALISIS DE TENDENCIA
function ayuda(){
           alert('Muestra del % de personas en Twitter que habla sobre los deportes que has marcado.');
       }