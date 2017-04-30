class ConversationDecorator < Draper::Decorator
  delegate :current_page, :total_pages, :limit_value, :entry_name, :total_count, :offset_value, :last_page?
  delegate_all

  # Devuelve el UserDecorator del destinatario
  def recipent user_id
    conversation.recipent(user_id).decorate
  end

  # Devuelve las conversaciones no leídas
  def unread_messages
    current_user.conversations.unread
  end

  def unread_conversation_class user_id
    (unread? (user_id)) ? ' unread-conversation' : ''
  end

  # Formatea la fecha
  def formatted_time
    time = last_message_time
    "#{time.hour}:#{time.min} #{time.day} de #{time.mon} de #{time.year}"
  end
end
