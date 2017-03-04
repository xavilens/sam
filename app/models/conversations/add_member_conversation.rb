class AddMemberConversation < Conversation
  after_initialize :set_conversation

  private

    # Define el mensaje
    def set_conversation
      self.subject = conversation_subject self.user_1

      message = AddMemberMessage.new(author: self.user_1)
      self.messages << message

      set_message_attr
    end

    # Devuelve el asunto del mensaje
    def conversation_subject user
      if user.musician?
        "#{user.name} desea unirse al grupo"
      else
        "#{user.name} desea que te unas al grupo"
      end
    end

    # Define los atributos del mensaje
    def set_message_attr #instrument
      if user_1.band?
        band = user_1.profile
        musician = user_2.profile
      else
        band = user_2.profile
        musician = user_1.profile
      end

      messages.first.set_attr band, musician #, instrument
      messages.first.set_body user_1
    end
end
