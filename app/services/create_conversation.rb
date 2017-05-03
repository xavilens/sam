# Servicio encargado de buscar usuarios
# TODO: BORRAR
class CreateConversation
  def initialize (params)
    @params = params
  end

  def create_conversation
    # Creamos la conversación
    conversation = Conversation.new(params)

    # Si la conversación es valida la guardamos, si no (o si hay  volvemos y mostramos los errores
    conversation.save
  end

  private

  attr_accessor :params
end
