class EventDecorator < Draper::Decorator
  delegate_all

  # Wrapper para colecciones
  def self.wrap(collection)
    collection.map do |obj|
        new obj
    end
  end

  # Devuelve la localización formateada
  def location_city
    "#{address.city}, #{address.region}"
  end

  # Devuelve la descripición del evento debidamente formateada
  def description
    (event.description.gsub(/\n/, '<br/>')).html_safe
  end
end
