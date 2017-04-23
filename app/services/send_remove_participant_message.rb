# Servicio encargado de enviar una solicitud de membresía
class SendRemoveParticipantMessage
  def initialize event_participant, current_user
    @event_participant = event_participant
    @current_user = current_user
    @participant = event_participant.participant
    @event = event_participant.event
    @event_creator = event.creator
    @is_event_creator = (current_user.id == event_creator.id)
  end

  # Ejecuta el servicio
  def do
    # Definimos las variables de usuario
    set_users

    # Construye la conversación
    @conversation = RemoveParticipantConversation.new(user_1: user_1, user_2: user_2,
      event: event, is_event_creator: is_event_creator)

    # Guarda y devuelve el resultado (éxito o error)
    return conversation.save
  end

  def relate_to_event
    ConversationRelated.create(conversation: conversation, conversationable: event)
  end

  private
    attr_accessor :current_user, :event_participant, :conversation, :participant, :event, :event_creator, :is_event_creator
    attr_reader :user_1, :user_2

    # Definimos las variables de usuario
    def set_users
      if is_event_creator
        @user_1 = event_creator
        @user_2 = participant
      else
        @user_1 = participant
        @user_2 = event_creator
      end
    end
end
