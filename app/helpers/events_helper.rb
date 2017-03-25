module EventsHelper
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
end
