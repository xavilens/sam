class UserDecorator < Draper::Decorator
  delegate_all

  # Wrapper de colecciones
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
      band_genres
    end
  end

  # Devuelve un string con los géneros del grupo
  def band_genres
    genres = user.profile.genres

    genres_s = ""
    genres_size =  genres.size - 1

    0.upto(genres_size) do |i|
      genres_s += "#{genres[i]}"

      if(i != genres_size)
        genres_s += " / "
      end
    end

    return genres_s
  end

  # Indica cuando se registró
  def register_at
    time = created_at.time
    "el #{time.strftime("%d/%m/%Y")}"
  end

  # Indica cuando se vió por ultima vez
  def last_seen_at
    updated_at.time
  end

  # Devuelve la cabecera de la sección Members de la pantalla Show User
  def member_header
    if user.musician?
      'Grupos'
    elsif user.band?
      'Miembros'
    end
  end

  # Devuelve los miembros decorados
  def members
    user.members.decorate
  end

  # Devuelve el número de miembros en los que forma parte el usuario
  def members_size
    profile.members.size
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
    SocialNetworkDecorator.wrap(user.social_networks)
  end

  # Devuelve los N próximos conciertos en los que participa el usuario
  def events_user_show
    all_events.sort_by!{|event| event.date}.first(5)
  end

  # Devuelve los N próximos conciertos en los que participa el usuario y el nombre del grupo con el que los realiza
  def events_in_show n
    # show_events = []
    #
    # events.next(n).each do |event|
    #   show_events.push [event.decorate, name]
    # end
    #
    # reverse_events.next(n).each do |event|
    #   show_events.push [event.decorate, name]
    # end
    #
    # if musician?
    #   profile.bands.each do |band|
    #     band.events.next(n).each do |event|
    #       show_events.push [event.decorate, band.name]
    #     end
    #   end
    # end
    #
    # show_events.sort_by!{|array| array[0].date}.first(n)

    show_events = all_events
    show_events.sort_by!{|event| event.date}

    events_ids = []
    show_events.each do |event|
      if events_ids.include? event.id
        show_events.delete event
        show_events << event
      else
        events_ids << event.id
      end
    end
    
    return show_events.first(n)
  end

  # Indica si posee imagenes
  def images?
    !images.blank?
  end

  ## AVATAR
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
end
