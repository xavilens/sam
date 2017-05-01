class SocialNetworksSet < ActiveRecord::Base
  ######## CONSTANTS
  SOCIAL_NETWORKS = ['facebook', 'twitter', 'youtube', 'soundcloud', 'website',
    'instagram', 'gplus', 'vimeo', 'bandcamp']

  ######## VALIDATE
  SOCIAL_NETWORKS.each do |sn|

    if sn != 'website' && sn != 'gplus' && sn != 'bandcamp'
      url_format =  /((http|https):\/\/)?(www\.)?#{sn}\.[a-z]{2,5}(\/.*)?/i
    else

      case sn
      when 'website'
        # Formato de url
        # ref: http://stackoverflow.com/questions/1128168/validation-for-url-domain-using-regex-rails/
        url_format = /((http|https):\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(\/.*)?/i
      when 'gplus'
        url_format = /((http|https):\/\/)?plus.google.com(\/.*)?/i
      when 'bandcamp'
        url_format = /((http|https):\/\/)?[a-z0-9]+\.#{sn}\.[a-z]{2,5}(\/.*)?/i
      end

    end

    validates ("#{sn}_url").to_sym, allow_blank: true, format: {with: url_format, message: 'Formato inválido'}
  end

  ######## METHODS
  # Devuelve un objeto SocialNetwork con los datos de Facebook
  def facebook
    name = 'Facebook'
    icono = 'facebook'
    return SocialNetwork.new(name, facebook_url, icono)
  end

  # Devuelve un objeto SocialNetwork con los datos de Twitter
  def twitter
    name = 'Twitter'
    icono = 'twitter'
    return SocialNetwork.new(name, twitter_url, icono)
  end

  # Devuelve un objeto SocialNetwork con los datos de YouTube
  def youtube
    name = 'YouTube'
    icono = 'youtube'
    return SocialNetwork.new(name, youtube_url, icono)
  end

  # Devuelve un objeto SocialNetwork con los datos de Soundcloud
  def soundcloud
    name = 'Soundcloud'
    icono = 'soundcloud'
    return SocialNetwork.new(name, soundcloud_url, icono)
  end

  # Devuelve un objeto SocialNetwork con los datos de su Website
  def website
    name = 'Website'
    icono = 'globe'
    return SocialNetwork.new(name, website_url, icono)
  end

  # Devuelve un objeto SocialNetwork con los datos de Instagram
  def instagram
    name = 'Instagram'
    icono = 'instagram'
    return SocialNetwork.new(name, instagram_url, icono)
  end

  # Devuelve un objeto SocialNetwork con los datos de Google Plus
  def gplus
    name = 'Google+'
    icono = 'google-plus'
    return SocialNetwork.new(name, gplus_url, icono)
  end

  # Devuelve un objeto SocialNetwork con los datos de Bandcamp
  def bandcamp
    name = 'Bandcamp'
    icono = 'bandcamp'
    return SocialNetwork.new(name, bandcamp_url, icono)
  end

  # Devuelve un objeto SocialNetwork con los datos de Vimeo
  def vimeo
    name = 'Vimeo'
    icono = 'vimeo'
    return SocialNetwork.new(name, vimeo_url, icono)
  end

  # Devuelve un array de objetos SocialNetwork con los datos de las redes sociales definidas
  def avaliables
    # Comprobamos cada red social por si es valida y si así es lo incluimos
    # en el array final
    social_networks = []
    SOCIAL_NETWORKS.each do |sn|
      social_network = send(sn)
      social_networks << social_network if social_network.valid?
    end

    return social_networks
  end

  # Devuelve Cierto si alguna de las redes sociales está definida
  def blank?
    res = true

    # Comprueba cada campo para saver si está creado
    SOCIAL_NETWORKS.each do |sn|
      res = res && ("#{sn}_url".to_sym).blank?
    end

    return res
  end
end
