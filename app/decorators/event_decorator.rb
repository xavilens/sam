require 'delegate'

class EventDecorator < SimpleDelegator
  # Wrapper para colecciones
  def self.wrap(collection)
    collection.map do |obj|
        new obj
    end
  end

  # Devuelve la localización formateada
  def location
    "#{event.city}, #{event.state}"
  end

  # Devuelve el tipo del evento
  def type
    "#{event.event_type.name}"
  end

  # Devuelve la descripición del evento debidamente formateada
  def description
    (event.description.gsub(/\n/, '<br/>')).html_safe
  end

  # Devuelve el objeto del evento
  def event
    __getobj__
  end
end
