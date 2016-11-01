module ConversationsHelper
  # Devuelve el destinatario de la conversación
  def conversation_recipent conversation
    conversation.recipent (@user.id)
  end

  # Devuelve el nombre del destinatario de la conversación
  def conversation_recipent_name conversation
    recipent = conversation_recipent conversation

    recipent.name
  end

  # Indica si hay mensajes sin leer en la conversación
  def conversation_unread? conversation
    conversation.unread? (@user.id)
  end

  # Devuelve clase para conversaciones con mensajes sin leer
  def unread_class conversation
    conversation.unread_conversation_class current_user.id
  end

  # Devuelve la clase active cuando se encuentra en alguna bandeja de conversaciones
  def active_conversation_box box
    if params[:show] == box || (box == 'inbox' && params[:show].blank?)
      'active'
    end
  end
end
