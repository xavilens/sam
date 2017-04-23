class AddParticipantConversation < Conversation
  ######## CALBACKS
  before_validation :set_conversation, on: [:create, :save]

  ######## ATTRIBUTES
  attr_accessor :event

  private
    # Define el mensaje
    def set_conversation
      self.subject = conversation_subject

      message = AddParticipantMessage.new(author: user_1, event: event)

      self.messages << message
    end

    # Devuelve el asunto del mensaje
    def conversation_subject
      "#{user_1.name} desea participar en el evento '#{event.name}'"
    end
end
