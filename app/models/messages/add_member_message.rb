class AddMemberMessage < Message
  after_initialize :set_body

  private

    def set_body
      self.body = message_body self.author
    end

    def message_body user
      if user.musician?
        message_body = "#{user.name} desea unirse al grupo."
        message_body += "<br><br>"
        message_body += "Si deseas añadirle al grupo pulsa en el siguiente botón:"
        message_body += "<br><br>"
      else
        message_body = "#{user.name} desea que te unas al grupo."
        message_body += "<br><br>"
        message_body += "Si deseas unirte al grupo pulsa en el siguiente botón:"
        message_body += "<br><br>"
      end

      message_body += body_form user

      return message_body
    end

    def body_form user
      submit_value = if user.musician?
        "Añadir a #{user.name}"
      else
        "Unirte a #{user.name}"
      end

      return "<form action='/membership/add' method='POST'>" +
        "<input name='authenticity_token' value='<%= form_authenticity_token %>' type='hidden'>" +
        "<input name='user_id' value='#{user.id}' type='hidden' />" +
        "<input type='submit' value='#{submit_value}' />" +
      "</form>"
    end
end
