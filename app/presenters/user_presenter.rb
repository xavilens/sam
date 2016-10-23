require 'delegate'

class UserPresenter < SimpleDelegator
  def self.wrap(collection)
    collection.map do |obj|
        new obj
    end
  end

  # Devuelve la subcabecera para la pantalla Show User
  def sub_header
    if user.musician?
      user.status #+ ' | ' + user.profile.instruments
    elsif user.band?
      user.status #+ ' | ' + user.profile.genres
    end
  end

  # Indica cuando se registró
  def register_at
    time = created_at.time
    "el #{time.strftime("%d/%m/%Y")}"
  end

  # Indica cuando se registró
  def last_seen_at
    updated_at.time
    # time = updated_at.time
    # "el #{time.strftime("%d/%m/%Y")}"
  end

  # Devuelve la cabecera de la sección Members de la pantalla Show User
  def member_header
    if user.musician?
      'Grupos'
    elsif user.band?
      'Miembros'
    end
  end

  # Devuelve la bio formateada
  def bio
    if bio?
      (user.bio.gsub(/\n/, '<br/>')).html_safe
    end
  end

  # Devuelve la localización formateada
  def location
    address = user.address

    "#{address.city} (#{address.province}), #{address.region}"
  end

  # Devuelve todas las redes sociales
  def social_networks
    SocialNetworkPresenter.wrap(user.social_networks)
  end

  # Indica si posee imagenes
  def images?
    !images.blank?
  end

  # AVATAR
  # Indica si posee un avatar de la version pasada
  def avatar?(version = nil)
    !user.avatar_url(version).blank?
  end

  # Devuelve el avatar para el index de usuarios de tipo 1
  def index_avatar
    user.avatar_url(:index_1)
  end

  # Devuelve el avatar para el index de usuarios de tipo 2
  def index_2_avatar
    user.avatar_url(:index_2)
  end

  # Devuelve la miniatura de avatar
  def thumb_avatar
    avatar_url(:thumb)
  end

  # Devuelve la miniatura pequeña de avatar
  def thumb_s_avatar
    avatar_url(:thumb_s)
  end

  # Devuelve la miniatura pequeña de avatar
  def conversation_avatar
    avatar_url(:thumb_s)
  end

  def s_avatar
    avatar_url(:s)
  end

  def thumb_xs_avatar
    avatar_url(:thumb_xs)
  end

  def user
    __getobj__
  end
end
