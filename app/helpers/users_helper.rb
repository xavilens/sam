module UsersHelper
  # Indica si la variable @user es el usuario actual
  def is_current_user?
    @user.id == current_user.id
  end

  # Devuelve la url necesaria para tratar el formulario (edit/new registration)
  def url_form_action
    # active_page 'users' ? user_path(@user) : registration_path(@user)
    if params[:controller] == 'users'
      user = true
    end

    if user && params[:action] == 'edit'
      user_path(@user)
    else
      registration_path(@user)
    end
  end
end
