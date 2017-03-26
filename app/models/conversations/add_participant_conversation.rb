class AddParticipantConversation < Conversation

  # Define el mensaje
  def set_conversation event
    self.subject = conversation_subject self.user_1, event

    message = AddParticipantMessage.new(author: self.user_1)
    set_attr message, event

    self.messages << message
  end

  private

    # Devuelve el asunto del mensaje
    def conversation_subject user, event
      "#{user.name} desea participar en el evento '#{event.name}'"
    end

    # Define los atributos del mensaje
    def set_attr message, event
      message.set_attr event
      message.set_body user_1
    end
end
