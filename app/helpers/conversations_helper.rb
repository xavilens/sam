module ConversationsHelper
  # Devuelve el destinatario de la conversación
  def conversation_recipent conversation
    conversation.recipent (current_user.id)
  end

  # Devuelve el nombre del destinatario de la conversación
  def conversation_recipent_name conversation
    recipent = conversation_recipent conversation

    recipent.name
  end

  # Devuelve el decorador con el número de mensajes no leídos
  def unread_conversations_count
    unread_count = Conversation.unread_count(current_user.id)
    if unread_count > 0
      content_tag(:span, unread_count, class: 'badge unread-conversations')
    end
  end

  # Devuelve el decorador con el número de mensajes no leídos
  def inbox_count
    inbox_count = Conversation.inbox(current_user.id).size
    if inbox_count > 0
      content_tag(:span, inbox_count, class: 'badge unread-conversations')
    end
  end

  # Devuelve el decorador con el número de mensajes no leídos
  def outbox_count
    outbox_count = Conversation.outbox(current_user.id).size
    if outbox_count > 0
      content_tag(:span, outbox_count, class: 'badge unread-conversations')
    end
  end

  # Devuelve el decorador con el número de mensajes no leídos
  def saved_count
    # saved_count = Conversation.outbox(current_user.id).size
    # if saved_count > 0
    #   content_tag(:span, saved_count, class: 'badge unread-conversations')
    # end
  end

  # Indica si hay conversaciones
  def any_conversation?
    !@conversations.blank?
  end

  # Indica si hay mensajes sin leer en la conversación
  def conversation_unread? conversation
    conversation.unread? (current_user.id)
  end

  # Devuelve clase para conversaciones con mensajes sin leer
  def unread_class conversation
    conversation.unread_conversation_class current_user.id
  end

  # Devuelve la clase active cuando se encuentra en alguna bandeja de conversaciones
  def active_conversation_box box
    if (params[:messages] && box == 'search') || params[:show] == box || (box == 'inbox' && params[:show].blank? && params[:messages].blank?)
      'active'
    end
  end
end
