require 'delegate'

class MessagePresenter < SimpleDelegator
  # Wrapper para colecciones
  def self.wrap(collection)
    collection.map do |obj|
        new obj
    end
  end

  # Devuelve el autor del mensaje
  def author
    UserPresenter.new(message.author)
  end

  # Devuelve el cuerpo del mensaje
  def body
    (message.body.gsub(/\n/, '<br/>')).html_safe
  end

  # Devuelve el objeto del mensaje original
  def message
    __getobj__
  end
end
