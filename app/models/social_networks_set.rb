class SocialNetworksSet < ActiveRecord::Base
  # Redes Sociales
  def facebook
    name = 'Facebook'
    icono = icon (name)
    return SocialNetwork.new(name, facebook_url, icono)
  end

  def twitter
    name = 'Twitter'
    icono = icon (name)
    return SocialNetwork.new(name, twitter_url, icono)
  end

  def youtube
    name = 'YouTube'
    icono = icon (name)
    return SocialNetwork.new(name, youtube_url, icono)
  end

  def soundcloud
    name = 'Soundcloud'
    icono = icon (name)
    return SocialNetwork.new(name, soundcloud_url, icono)
  end

  def website
    name = 'Website'
    icono = icon (name)
    return SocialNetwork.new(name, website_url, icono)
  end

  def instagram
    name = 'Instagram'
    icono = icon (name)
    return SocialNetwork.new(name, instagram_url, icono)
  end

  def gplus
    icono = icon ('Gplus')
    return SocialNetwork.new('Google+', gplus_url, icono)
  end

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

  def blank?
    avaliables.blank?
  end

  private
    def icon (social_network)
      icons = {Facebook: 'facebook', Twitter: 'twitter', YouTube: 'youtube',
        Soundcloud: 'soundcloud', Website: 'globe', Instagram: 'instagram',
        Gplus: 'google-plus'}

      icons.each do |sn, icono|
        if sn.to_s == social_network
          return icono
        end
      end
    end
end
