require 'delegate'

class MessagePresenter < SimpleDelegator
  # Wrapper para colecciones
  def self.wrap(collection)
    collection.map do |obj|
        new obj
    end
  end

  # Devuelve el objeto del mensaje original
  def message
    __getobj__
  end
end
