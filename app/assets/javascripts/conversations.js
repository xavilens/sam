// CONVERSATIONS

$(document).ready(function(){
  $('.conversation').click(function(event){
    event.preventDefault();

    var target = $(event.target);
    var selector = $('.checkbox input', this);
    if(!target.is(selector)){
      location.href = "/messages/" + $(this).data('conversation') + "/";
    }
  });
});
