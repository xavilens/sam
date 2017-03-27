class RemoveParticipantMessage < Message
  attr_accessor :event

  # Define los atributos para construir el cuerpo del mensaje
  def set_attr event, is_creator
    @event = event
    set_body is_creator
  end

  private
    # Define el cuerpo del mensaje
    def set_body is_creator
      debugger
      self.body = if is_creator
        "#{author.name} te ha expulsado del evento '#{event.name}'."
      else
        "#{author.name} ha dejado de participar en el evento '#{event.name}'."
      end
    end
end
