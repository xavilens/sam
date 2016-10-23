module ConversationHelper
  # Devuelve el destinatario de la conversación
  def conversation_recipent conversation
    conversation.recipent (@user.id)
  end

  # Indica si hay mensajes sin leer en la conversación
  def conversation_unread? conversation
    conversation.unread? (@user.id)
  end
end
