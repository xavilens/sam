class MessageDecorator < Draper::Decorator
  delegate_all

  # Devuelve el autor del mensaje
  def author
    message.author.decorate
  end

  # Devuelve el cuerpo del mensaje
  def body
    (message.body.gsub(/\n/, '<br/>')).html_safe
  end
end
