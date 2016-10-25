// CONVERSATIONS

// Redirige desde la lista de conversaciones hasta la vista de una concreta
$(document).on('page:load', function(){
  $('.conversation').click(function(event){
    event.preventDefault();

    var target = $(event.target);
    var selector = $('.checkbox input', this);
    if(!target.is(selector)){
      location.href = "/messages/" + $(this).data('conversation') + "/";
    }
  });
});
