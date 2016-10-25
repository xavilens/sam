class SocialNetworksSet < ActiveRecord::Base
  ######## VALIDATE
  ['facebook', 'twitter', 'youtube', 'soundcloud', 'website', 'instagram', 'gplus'].each do |sn|

    if sn != 'website' && sn != 'gplus'
      url_format =  /((http|https):\/\/)?(www\.)?#{sn}\.[a-z]{2,5}(\/.*)?/i
    else

      case sn
      when 'website'
        # Formato de url
        # ref: http://stackoverflow.com/questions/1128168/validation-for-url-domain-using-regex-rails/
        url_format = /((http|https):\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(\/.*)?/i
      when 'gplus'
        url_format = /((http|https):\/\/)?plus.google.com(\/.*)?/i
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

  # Devuelve un objeto SocialNetwork con los datos de Facebook
  def twitter
    name = 'Twitter'
    icono = 'twitter'
    return SocialNetwork.new(name, twitter_url, icono)
  end

  # Devuelve un objeto SocialNetwork con los datos de Facebook
  def youtube
    name = 'YouTube'
    icono = 'youtube'
    return SocialNetwork.new(name, youtube_url, icono)
  end

  # Devuelve un objeto SocialNetwork con los datos de Facebook
  def soundcloud
    name = 'Soundcloud'
    icono = 'soundcloud'
    return SocialNetwork.new(name, soundcloud_url, icono)
  end

  # Devuelve un objeto SocialNetwork con los datos de Facebook
  def website
    name = 'Website'
    icono = 'globe'
    return SocialNetwork.new(name, website_url, icono)
  end

  # Devuelve un objeto SocialNetwork con los datos de Facebook
  def instagram
    name = 'Instagram'
    icono = 'instagram'
    return SocialNetwork.new(name, instagram_url, icono)
  end

  # Devuelve un objeto SocialNetwork con los datos de Facebook
  def gplus
    icono = 'google-plus'
    return SocialNetwork.new('Google+', gplus_url, icono)
  end

  # Devuelve un array de objetos SocialNetwork con los datos de las redes sociales definidas
  def avaliables
    social_networks_avaliable = ['facebook', 'twitter', 'youtube', 'soundcloud',
      'website', 'instagram', 'gplus']

    # Comprobamos cada red social por si es valida y si así es lo incluimos
    # en el array final
    social_networks = []
    social_networks_avaliable.each do |sn|

      case sn
      when 'facebook'
        social_network = facebook
      when 'twitter'
        social_network = twitter
      when 'youtube'
        social_network = youtube
      when 'soundcloud'
        social_network = soundcloud
      when 'website'
        social_network = website
      when 'instagram'
        social_network = instagram
      when 'gplus'
        social_network = gplus
      end

      social_networks << social_network if social_network.valid?
    end

    return social_networks
  end

  # Devuelve Cierto si alguna de las redes sociales está definida
  def blank?
    res = true

    # Comprueba cada campo para saver si está creado
    ['facebook', 'twitter', 'youtube', 'soundcloud', 'website', 'instagram', 'gplus'].each do |sn|
      res = res && ("#{sn}_url".to_sym).blank?
    end

    return res
  end
end
