class AddMemberMessage < Message
  attr_accessor :band, :musician, :instrument

  # Define los atributos para construir el cuerpo del mensaje
  def set_attr band, musician, instrument
    @band = band
    @musician = musician
    @instrument = instrument
  end

  # Define el cuerpo del mensaje
  def set_body from_user
    self.body = message_body from_user
  end

  # Devuelve el cuerpo del mensaje
  def message_body from_user
    if from_user.musician?
      message_body = "#{from_user.name} desea unirse al grupo como '#{instrument.name}'."
      message_body += "<br><br>"
      message_body += "Si deseas añadirle al grupo pulsa en el siguiente botón:"
      message_body += "<br><br>"
    else
      message_body = "#{from_user.name} desea que te unas al grupo como '#{instrument.name}'."
      message_body += "<br><br>"
      message_body += "Si deseas unirte al grupo pulsa en el siguiente botón:"
      message_body += "<br><br>"
    end

    message_body += body_form from_user

    return message_body
  end

  # Devuelve el formulario que irá incrustado en el cuerpo del mensaje
  def body_form from_user
    submit_value = if from_user.musician?
      "Añadir a #{from_user.name}"
    else
      "Unirte a #{from_user.name}"
    end

    return "<form action='/members/create' method='POST'>" +
      "<input name='authenticity_token' value='<%= form_authenticity_token %>' type='hidden'>" +
      "<input name='band_id' value='#{band.id}' type='hidden' />" +
      "<input name='musician_id' value='#{musician.id}' type='hidden' />" +
      "<input name='instrument_id' value='#{instrument.id}' type='hidden' />" +
      "<input type='submit' value='#{submit_value}' />" +
    "</form>"
  end
end
