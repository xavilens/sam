# Servicio encargado de enviar una solicitud de membresía
class SendAddParticipantMessage
  def initialize event, creator, participant
    @event = event
    @creator = creator
    @participant = participant
  end

  # Ejecuta el servicio
  def do
    # Construye la conversación
    @conversation = AddParticipantConversation.new(user_1: @participant, user_2: @creator, event: event)

    # Guarda y devuelve el resultado (éxito o error)
    return conversation.save
  end

  private
    attr_accessor :creator, :participant, :event, :conversation
end
