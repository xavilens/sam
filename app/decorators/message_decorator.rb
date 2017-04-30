class MessageDecorator < Draper::Decorator
  delegate :current_page, :total_pages, :limit_value, :entry_name, :total_count, :offset_value, :last_page?
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
