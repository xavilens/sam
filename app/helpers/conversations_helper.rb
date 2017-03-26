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

  # Devuelve el decorador con el número de mensajes recibidos
  def inbox_count
    inbox_count = Conversation.inbox(current_user.id).size
    if inbox_count > 0
      content_tag(:span, inbox_count, class: 'badge unread-conversations')
    end
  end

  # Devuelve el decorador con el número de mensajes recibidos no leídos
  def inbox_unread_count
    inbox_count = Conversation.inbox_unread_count(current_user.id)
    if inbox_count > 0
      content_tag(:span, inbox_count, class: 'badge unread-conversations')
    end
  end

  # Devuelve el decorador con el número de mensajes enviados
  def outbox_count
    outbox_count = Conversation.outbox(current_user.id).size
    if outbox_count > 0
      content_tag(:span, outbox_count, class: 'badge unread-conversations')
    end
  end

  # Devuelve el decorador con el número de mensajes enviados con respuestas no leídas
  def outbox_unread_count
    outbox_count = Conversation.outbox_unread_count(current_user.id)
    if outbox_count > 0
      content_tag(:span, outbox_count, class: 'badge unread-conversations')
    end
  end

  # Devuelve el decorador con el número de peticiones de membresía
  def membership_count
    membership_count = Conversation.membership(current_user.id).size
    if membership_count > 0
      content_tag(:span, membership_count, class: 'badge unread-conversations')
    end
  end

  # Devuelve el decorador con el número de peticiones de membresía no leídos
  def membership_unread_count
    membership_count = Conversation.membership_unread_count(current_user.id)
    if membership_count > 0
      content_tag(:span, membership_count, class: 'badge unread-conversations')
    end
  end

  # Devuelve el decorador con el número de peticiones de membresía
  def participants_count
    participants_count = Conversation.participants(current_user.id).size
    if participants_count > 0
      content_tag(:span, participants_count, class: 'badge unread-conversations')
    end
  end

  # Devuelve el decorador con el número de peticiones de membresía no leídos
  def participants_unread_count
    participants_count = Conversation.participants_unread_count(current_user.id)
    if participants_count > 0
      content_tag(:span, participants_count, class: 'badge unread-conversations')
    end
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
    if (params[:messages] && box == 'search') || params[:show] == box || (box == 'inbox' && params[:show] == box && params[:messages].blank?)
      'active'
    end
  end
end
