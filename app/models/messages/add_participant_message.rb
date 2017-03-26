class AddParticipantMessage < Message
  attr_accessor :event

  # Define los atributos para construir el cuerpo del mensaje
  def set_attr event
    @event = event
  end

  # Define el cuerpo del mensaje
  def set_body from_user
    self.body = message_body from_user
  end

  # Devuelve el cuerpo del mensaje
  def message_body from_user
    message_body = "#{from_user.name} desea participar al evento '#{event.name}'."
    message_body += "<br><br>"
    message_body += "Si deseas que participe en el evento pulsa en el siguiente botón:"
    message_body += "<br><br>"

    message_body += body_form from_user

    return message_body
  end

  # Devuelve el formulario que irá incrustado en el cuerpo del mensaje
  def body_form from_user
    submit_value = "Añadir a #{from_user.name}"

    return "<form action='/participants/new' data-remote='true' method='get'>" +
      "<input name='authenticity_token' value='<%= form_authenticity_token %>' type='hidden'>" +
      "<input name='event_participant[event_id]' value='#{event.id}' type='hidden' />" +
      "<input name='event_participant[participant_id]' value='#{from_user.id}' type='hidden' />" +
      "<input type='submit' value='#{submit_value}' />" +
    "</form>"
  end
end
