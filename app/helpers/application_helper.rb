module ApplicationHelper
  # Devuelve el nombre del tipo traducido.
  # Si el caso no es tenido en cuenta se devuelve igual.
  def traducir_type type
    if type == 'Musician'
      'Músico'
    elsif type == 'Musicians'
      'Músicos'
    elsif type == 'Band'
      'Grupo'
    elsif type == 'Bands'
      'Grupos'
    elsif type == 'User'
      'Usuario'
    elsif type == 'Users'
      'Usuarios'
    else
      type
    end
  end

  # Configura el título de la página o de la página por defecto
  def page_title page = nil
    title = 'S.A.M. - Sociedad Anónima Músical'

    @page = traducir_type(page)
    title = "#{@page} | " + title unless page.blank?

    content_for :title, title
  end

  # Devuelve 'active' si nos encontramos en una página con el controlador
  # indicado y, si queremos, si se ha ejecutado con una acción
  def active_page controller, action = nil
    'active' if (page? controller, action)
  end

  # Indica si estamos en una página con un controlador y, si queremos,
  # si se ha ejecutado con una acción
  def page? controller, action = nil
    p_controller = params[:controller]

    res = p_controller == controller
    unless action.blank?
      p_action = params[:action]
      res = res && p_action == action
    end

    return res
  end

  # Devuelve el decorador con el número de mensajes no leídos
  def unread_conversations_count
    if Conversation.unread? (current_user.id)
      messages_count = content_tag(:span, Conversation.unread_count(current_user.id), class: 'badge unread-conversations')
    end

    return messages_count
  end

end
