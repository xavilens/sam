require 'delegate'

class SocialNetworkDecorator < SimpleDelegator
  # Devuelve el icono de la red social
  def icon
    fa_icon
  end

  # Devuelve la url formateada
  def formatted_url
    if url_include?("http://") || url_include?("https://")
      social_network.url
    else
      "http://" + social_network.url
    end
  end

  # Indica si la url presenta una subcadena específica
  def url_include? (string)
    social_network.url.include? string
  end

  # Devuelve el objeto social_network original
  def social_network
    __getobj__
  end

  # Wrapper para colecciones
  def self.wrap(collection)
    collection.map do |obj|
        new obj
    end
  end
end
