// ELLIPSIS

// Función que Captura el click en la opción 'Leer más' de la biografía de un usuario
$(document).on('page:load',function() {
  $('.ellipsis-control').click(function(event){
    expand_ellipsis_text();

    event.preventDefault();
  });
});

// Función que elimina el div que contiene el controlador de la ellipsis si el texto no llega a ser truncado
$(document).on('ready',function() {
  if ($('.ellipsis-text').outerHeight() < 60) {
    $('.ellipsis-control').text = '';
  }
});

// Función que controla el comportamiento de la opción 'Leer más' de la biografía de un usuario
function expand_ellipsis_text(){
  var ellipsis_control = $('.ellipsis-control');
  var ellipsis_text = $('.ellipsis-text');

  var truncate_text = ellipsis_text.hasClass("ellipsis");

  if(truncate_text){
    ellipsis_text.removeClass("ellipsis");
    ellipsis_control.html('<i class="fa fa-caret-up"></i> Leer menos...');
  }else{
    ellipsis_text.addClass("ellipsis");
    ellipsis_control.html('<i class="fa fa-caret-down"></i> Leer más...');
  }
}
