// CONVERSATIONS

// Redirige desde la lista de conversaciones hasta la vista de una concreta
// $(document).ready(function(){
//   alert('test');
//   $('.conversation').click(function(event){
//     alert('test');
//     event.preventDefault();
//
//     var target = $(event.target);
//     var selector = $('.checkbox input', this);
//     if(!target.is(selector)){
//       location.href = "/messages/" + $(this).data('conversation') + "/";
//     }
//   });
// });


$(document).on('ready page:change page:load', function(){
  $('.conversation').click(function(event){
    event.preventDefault();

    var target = $(event.target);
    var selector = $('.checkbox input', this);
    if(!target.is(selector)){
      location.href = "/messages/" + $(this).data('conversation') + "/";
    }
  });
});
