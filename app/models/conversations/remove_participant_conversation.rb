class RemoveParticipantConversation < Conversation
  ######## CALBACKS
  before_validation :set_conversation, on: [:create, :save]

  ######## ATTRIBUTES
  attr_accessor :event, :is_event_creator

  private
    # Define el mensaje
    def set_conversation
      self.subject = conversation_subject

      message = RemoveParticipantMessage.new(author: user_1, event: event, is_event_creator: is_event_creator)

      self.messages << message
    end

    # Devuelve el asunto del mensaje
    def conversation_subject
      if is_event_creator
        "Has sido expulsado del evento '#{event.name}'"
      else
        "#{user_1.name} ha dejado de participar en el evento '#{event.name}'"
      end
    end
end
