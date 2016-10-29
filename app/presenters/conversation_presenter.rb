require 'delegate'

class ConversationPresenter < SimpleDelegator
  # Devuelve el UserPresenter del destinatario
  def recipent user_id
    UserPresenter.new(conversation.recipent(user_id))
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

  # Wrapper para colecciones
  def self.wrap(collection)
    collection.map do |obj|
        new obj
    end
  end

  # Devuelve la conversation original
  def conversation
    __getobj__
  end
end
