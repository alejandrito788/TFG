/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

window.onload=horario();

 function horario(){      
            $.ajax({
                type: 'GET',
                url: 'https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400&date=today',
                success: function(respuesta){      
                    document.getElementById("amanecer").innerHTML=respuesta.results.sunrise;
                    document.getElementById("atardecer").innerHTML=respuesta.results.astronomical_twilight_end;
               
                },
                error: function(){
                    alert('Horario no disponible');
                }
            });
        }
            
//CARRUSEL DE FOTOS
     $(document).ready(function(){
        $('.myCarousel').carousel({
            interval: 7000
        });
    });
   
//BOTON DE AYUDA EN ANALISIS DE TENDENCIA
function ayuda(){
           alert('Muestra del porcentaje de personas en Twitter que habla sobre los deportes que has marcado.');
       }