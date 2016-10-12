class SocialNetworksSet < ActiveRecord::Base
  # Redes Sociales
  def facebook
    name = 'Facebook'
    icono = icon (name)
    SocialNetwork.new(name, facebook_url, icono)
  end

  def twitter
    name = 'Twitter'
    icono = icon (name)
    SocialNetwork.new(name: name, url: twitter_url, fa_icon: icono)
  end

  def youtube
    name = 'YouTube'
    icono = icon (name)
    SocialNetwork.new(name: name, url: youtube_url, fa_icon: icono)
  end

  def soundcloud
    name = 'Soundcloud'
    icono = icon (name)
    SocialNetwork.new(name: name, url: soundcloud_url, fa_icon: icono)
  end

  def website
    name = 'Website'
    icono = icon (name)
    SocialNetwork.new(name: name, url: website_url, fa_icon: icono)
  end

  def instagram
    name = 'Instagram'
    icono = icon (name)
    SocialNetwork.new(name: name, url: instagram_url, fa_icon: icono)
  end

  def gplus
    icono = icon ('Gplus')
    SocialNetwork.new(name: 'Google+', url: gplus_url, fa_icon: icono)
  end

  def avaliables
    social_networks_avaliable = ['facebook', 'twitter', 'youtube', 'soundcloud',
      'website', 'instagram', 'gplus']

    # Comprobamos cada red social por si es valida y si así es lo incluimos
    # en el array final
    social_networks = []
    social_networks_avaliable.each do |sn|
      social_network = SocialNetworksSet.send(sn)
      social_networks << social_network if social_network.valid?
    end

    return social_networks
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
