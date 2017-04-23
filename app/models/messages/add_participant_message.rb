class AddParticipantMessage < Message
  ######## CALLBACKS
  before_validation :set_body, on: [:create, :save]

  ######## ATTRIBUTES
  attr_accessor :event

  private
    # Define el cuerpo del mensaje
    def set_body
      self.body = message_body
    end

    # Devuelve el cuerpo del mensaje
    def message_body
      message_body = "#{author.name} desea participar al evento '#{event.name}'."
      message_body += "<br><br>"
      message_body += "Si deseas que participe en el evento pulsa en el siguiente botón:"
      message_body += "<br><br>"

      message_body += body_form

      return message_body
    end

    # Devuelve el formulario que irá incrustado en el cuerpo del mensaje
    def body_form
      submit_value = "Añadir a #{author.name}"

      return "<form action='/participants/new' data-remote='true' method='get'>" +
        "<input name='authenticity_token' value='<%= form_authenticity_token %>' type='hidden'>" +
        "<input name='event_participant[event_id]' value='#{event.id}' type='hidden' />" +
        "<input name='event_participant[participant_id]' value='#{author.id}' type='hidden' />" +
        "<input type='submit' value='#{submit_value}' />" +
      "</form>"
    end
end
