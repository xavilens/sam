# Servicio encargado de enviar una solicitud de membresía
class SendRemoveParticipantMessage
  def initialize event_participant, current_user
    @event_participant = event_participant
    @current_user = current_user
  end

  # Ejecuta el servicio
  def do
    debugger
    # Definimos las variables
    event = event_participant.event
    creator = event.creator
    participant = event_participant.participant

    if current_user == creator
      user_1 = creator
      user_2 = participant
    else
      user_1 = participant
      user_2 = creator
    end

    # Construye la conversación
    @conversation = RemoveParticipantConversation.new(user_1: user_1, user_2: user_2)
    @conversation.set_conversation event, (current_user == creator)

    # Guarda y devuelve el resultado (éxito o error)
    return conversation.save
  end

  private
    attr_accessor :current_user, :event_participant, :conversation
end
