module ConversationHelper
  # Devuelve el destinatario de la conversación
  def conversation_recipent conversation
    conversation.recipent (@user.id)
  end

  # Indica si hay mensajes sin leer en la conversación
  def conversation_unread? conversation
    conversation.unread? (@user.id)
  end

  # Devuelve clase para conversaciones con mensajes sin leer
  def unread_class conversation
    conversation.unread_conversation_class current_user.id
  end
end
