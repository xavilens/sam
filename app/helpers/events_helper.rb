module EventsHelper
  ##### MISC
  # Indica si el creador del evento es el usuario actual
  def is_creator?
    @user == current_user
  end

  ##### SHOW
  def event_status_class status
    if status == 'Abierto'
      'text-success'
    elsif status == 'Cerrado'
      'text-danger'
    end
  end

  # Indica si hay un evento previo
  def prev_event?
    !@prev_event.blank?
  end

  # Indica si el evento previo será activo
  def prev_event_active
    if !prev_event?
      "disabled"
    end
  end

  # Devuelve la url del evento anterior
  def prev_event_url
    user_event_path(user_id: @user.id, id: @prev_event) if prev_event?
  end

  # Indica si hay un evento siguiente
  def next_event?
    !@next_event.blank?
  end

  # Indica si el siguiente evento será activo
  def next_event_active
    if !next_event?
      "disabled"
    end
  end

  # Devuelve la url del evento siguiente
  def next_event_url
    user_event_path(user_id: @user.id, id: @next_event) if next_event?
  end

  ##### CALENDAR
  # Devuelve la cadena de cabecera para las fechas
  def calendar_month_header date
    "#{I18n.translate('date.month_names')[date.month]} #{date.year}"
  end

  # Devuelve la cadena de cabecera para las fechas
  def calendar_date_header date
    "#{I18n.translate('date.day_names')[date.wday]} #{I18n.localize date, format: :long}"
  end

  # Devuelve la url del evento anterior
  def prev_calendar_url
    if params[:event_search_form].present?
      events_path(date: (@start_date - 1.month), event_search_form: params[:event_search_form])
    else
      events_path(date: (@start_date - 1.month))
    end
  end

  # Devuelve la url del evento siguiente
  def next_calendar_url
    if params[:event_search_form].present?
      events_path(date: (@start_date + 1.month), event_search_form: params[:event_search_form])
    else
      events_path(date: (@start_date + 1.month))
    end
  end

  # Devuelve el link para ir al formulario de creación de eventos
  def link_to_new_event date
    link_to fa_icon('plus')+" Crear evento", new_event_path(date: date.to_s), class: 'btn btn-sm btn-primary'
  end
end
