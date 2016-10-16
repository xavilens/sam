$(document).ready(function() {
  $('#ellipsis-control').click(function(event){
    expand_ellipsis_text();

    event.preventDefault();
  });
});

function expand_ellipsis_text(){
  var ellipsis_control = $('#ellipsis-control');
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
