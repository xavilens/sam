class AddMemberConversation < Conversation
  after_initialize :set_subject
  after_initialize :set_message

  private

    def set_subject
      self.subject = conversation_subject self.user_1
    end

    def conversation_subject user
      if user.musician?
        "#{user.name} desea unirse al grupo"
      else
        "#{user.name} desea que te unas al grupo"
      end
    end

    def set_message
      message = AddMemberMessage.new(author: self.user_1)
      self.messages << message
    end
end
