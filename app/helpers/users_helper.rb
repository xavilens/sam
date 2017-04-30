module UsersHelper
  # Indica si la variable @user es el usuario actual
  def is_current_user?
    @user.id == current_user.id
  end

  # Alias para is_current_user?
  def current_user?
    is_current_user?
  end

  # Devuelve la url necesaria para tratar el formulario (edit/new registration)
  def url_form_action
    if (page? 'users', 'edit') || (page? 'users', 'update')
      user_path(@user)
    else
      registration_path(@user)
    end
  end

  # Devuelve el link para enviar un mensaje al usuario
  def link_to_send_message_to_user user, is_index = false
    # Definimos variables
    link_class = is_index ? "" : "option-button-icon option-button col-md-2 col-md-offset-1 gap-right"
    link_class = current_user == user ? link_class+" disabled" : link_class

    # Creamos el link
    link_to fa_icon('envelope'), new_message_path(to_user: user.id), remote: true,
      class: "btn btn-default #{link_class}",
      title: "Enviar mensaje", data: {toggle: 'tooltip', placement: 'top'}
  end

  # Devuelve el link para seguir o dejar de seguir al usuario
  def link_to_follow_user user, is_index = false
    # Definimos variables
    is_following = current_user.following? user

    icon = is_following ? 'eye-slash' : 'eye'
    method = is_following ? :delete : :post
    title = is_following ? "Dejar de seguir a #{user.name}" : "Seguir a #{user.name}"

    link_class = is_index ? "" : "option-button-icon option-button col-md-2 gap-right"
    link_class = current_user == user ? link_class+" disabled" : link_class

    # Creamos el link
    link_to fa_icon(icon, id: "followship-icon"), followships_path(user_id: user.id),
      method: method, class: "btn btn-default #{link_class}",
      data: {toggle: 'tooltip', placement: 'top'}, title: title, id: "followship"
  end

  # Devuelve el link para pedir ser miembro o para dejarlo
  def link_to_user_member user, is_index = false
    # Definimos variables
    link_class = is_index ? "" : "option-button-icon option-button col-md-2 gap-right"
    link_class = current_user == user ? link_class+" disabled" : link_class

    is_member = current_user.profile.member? user.profile
    icon = is_member ? 'user-times' : 'user-plus'
    url = is_member ? delete_user_membership_path(user_id: user) : send_user_membership_path(user_id: user, from_user: current_user)

    is_band_musician = current_user.band? && user.musician?
    is_musician_band = current_user.musician? && user.band?

    title = if is_band_musician
      if is_member
        "Expulsar del grupo"
      else
        "Invitar al grupo"
      end
    elsif is_musician_band
      if is_member
        "Dejar el grupo"
      else
        "Unirte al grupo"
      end
    end

    # Creamos el link si ambos usuarios son de distintos perfiles
    if is_band_musician || is_musician_band
      link_to fa_icon(icon), url, class:  "btn btn-default #{link_class}",
        title: title, remote: true, data: {toggle: 'tooltip', placement: 'top'}
    end
  end
end
