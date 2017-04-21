// MESSAGES

// Evita enviar un mensaje sin haber sido escrito
$('#send_message').click(function(event){
  if ($(".conversation_message_body").text() == "")
    event.preventDefault();
});
