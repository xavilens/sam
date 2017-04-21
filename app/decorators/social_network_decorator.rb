class SocialNetworkDecorator < Draper::Decorator
  delegate_all

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
end
