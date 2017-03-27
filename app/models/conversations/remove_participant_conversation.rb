class RemoveParticipantConversation < Conversation

  # Define el mensaje
  def set_conversation event, is_creator
    debugger
    self.subject = conversation_subject event, is_creator

    message = RemoveParticipantMessage.new(author: self.user_1)
    message.set_attr event, is_creator

    self.messages << message
  end

  private

    # Devuelve el asunto del mensaje
    def conversation_subject event, is_creator
      if is_creator
        "Has sido expulsado del evento '#{event.name}'"
      else
        "#{user_1.name} ha dejado de participar en el evento '#{event.name}'"
      end
    end
end
