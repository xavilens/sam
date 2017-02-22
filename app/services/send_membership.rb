# Servicio encargado de enviar una solicitud de membresía
class SendMembership
  def initialize from_user, to_user, instrument
    @from_user = from_user
    @to_user = to_user
    @instrument = instrument
  end

  # Ejecuta el servicio
  def do
    # Construye la conversación
    # conversation = build_conversation
    build_conversation

    # Guarda y devuelve el resultado (éxito o error)
    # return conversation.save
  end

  private
    attr_accessor :from_user, :to_user, :instrument

    # Construye la conversación y define los atributos del mensaje
    def build_conversation
      conv = AddMemberConversation.new(user_1: @from_user, user_2: @to_user)

      conv.set_message_attr @instrument

      return conv
    end
end
