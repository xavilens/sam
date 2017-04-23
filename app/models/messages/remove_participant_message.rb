class RemoveParticipantMessage < Message
  ######## CALLBACKS
  before_validation :set_body, on: [:create, :save]

  ######## ATTRIBUTES
  attr_accessor :event, :is_event_creator

  private
    # Define el cuerpo del mensaje
    def set_body
      self.body = if is_event_creator
        "#{author.name} te ha expulsado del evento '#{event.name}'."
      else
        "#{author.name} ha dejado de participar en el evento '#{event.name}'."
      end
    end
end
