module MessagesHelper
  # Devuelve el destinatario del mensaje
  def recipent_message message
    message.conversation.recipent message.author_id
  end


end
