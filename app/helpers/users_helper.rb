module UsersHelper
  # Indica si la variable @user es el usuario actual
  def is_current_user?
    @user.id == current_user.id
  end

  # Devuelve la url necesaria para tratar el formulario (edit/new registration)
  def url_form_action
    if (page? 'users', 'edit') || (page? 'users', 'update')
      user_path(@user)
    else
      registration_path(@user)
    end
  end
end
