class EventDecorator < Draper::Decorator
  delegate_all

  ##### PARTICIPANTS
  # Indica si se ha definido los participantes máximos
  def max_participants_define?
    !max_participants.blank?
  end

  # Devuelve el número de participantes que hay del máximo posible
  def participants_count type = nil
    if type == :long
      "#{participants_size} de #{max_participants} #{max_participants > 1 ? 'participantes' : 'participante'}"
    else
      "#{participants_size} de #{max_participants}"
    end
  end

  # Devuelve el número de participantes que hay del máximo posible
  def unlimited_participants
    "Abierto"
  end

  # Devuelve la cantidad de participantes apuntados al evento
  def participants_size
    participants.size
  end

  # Indica si un usuario puede participar en el evento
  def can_participate?
    open? and !max_participants_reached?
  end

  # Indica si el estado del evento es Abierto
  def max_participants_reached?
    if max_participants_define?
      participants_size == max_participants
    else
      false
    end
  end

  ##### STATUS
  # Indica si el estado del evento es Abierto
  def open?
    event_status_id == 1
  end

  ##### ADDRESS
  # Devuelve la localización formateada por completo
  def complete_location
    address.gaddress
  end

  # Devuelve la localización de la ciudad
  def location_city
    address.city
  end

  # Devuelve la localización de la comunidad
  def location_region
    "#{address.city}, #{address.region}"
  end

  # Devuelve la localización de la calle
  def location_street
    "#{address.street}, #{address.city}, #{address.region}"
  end

  ##### DESCRIPTION
  # Devuelve la descripición del evento debidamente formateada
  def description
    if description?
      (event.description.gsub(/\n/, '<br/>')).html_safe
    else
      ""
    end
  end

  ##### DATE
  # Devuelve el mes según el tipo pasado
  def month(type = nil)
    case type
    when :number
      month_number
    when :name
      month_name
    when :abbr
      month_abbr
    else
      month_name
    end
  end

  # Devuelve el nombre del mes de la fecha del evento
  def month_number
    date.month
  end

  # Devuelve el nombre del mes de la fecha del evento
  def month_name
    I18n.t('date.month_names')[month_number].camelize
  end

  # Devuelve el nombre del mes de la fecha del evento
  def month_abbr
    I18n.t('date.abbr_month_names')[month_number].upcase
  end

  # Devuelve el día del evento
  def day
    date.day
  end

  ##### PVP
  # Indica si se ha definido el PVP
  def pvp_define?
    !pvp.blank?
  end

  # Indica si se ha definido el PVP
  def no_pvp
    no_define
  end

  ##### TIME
  # Indica si se ha definido la hora
  def time_define?
    !time.blank?
  end

  # Indica si se ha definido el PVP
  def no_time
    no_define
  end

  ##### MISC
  # Devuelve el mensaje cuando no se ha definido un campo
  def no_define
    "No indicado"
  end
end
