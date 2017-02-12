# Servicio encargado de enviar una solicitud de membresía
class SendMembership
  def initialize from_user, to_user
    @from_user = from_user
    @to_user = to_user
  end

  def do
    # Construye la conversación
    conversation = build_conversation
    # Si es valido lo guarda y envía un mensaje de noticia, si no envía uno de advertencia
    if conversation.valid?
      conversation.save

      return true
    else
      return false
    end
  end

  private
    attr_accessor :from_user, :to_user

    def build_conversation
      AddMemberConversation.new(user_1: @from_user, user_2: @to_user)
    end
end
