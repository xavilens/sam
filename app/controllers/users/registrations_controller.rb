class Users::RegistrationsController < Devise::RegistrationsController
before_action :configure_sign_up_params, only: [:create]
before_action :configure_account_update_params, only: [:update]

  # GET /user/sign_up
  def new
    super
  end

  # POST /user
  def create

    # Comprobamos qué tipo de perfil tiene el usuario y creamos el perfil al que
    # lo asociaremos
    profile_type = params[:user][:profileable_type]
    if profile_type == 'Musician'
      profile = Musician.create()
    elsif profile_type == 'Band'
      profile = Band.create()
    end

    respond_with resource if profile.blank?

    params[:user][:profileable_id] = profile.id

    super
  end

  # GET /user/edit
  def edit
    super
  end

  # PUT /user
  def update
    super
  end

  # DELETE /user
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password,
      :password_confirmation, :name, :city, :state, :country,
      :profileable_type, :profileable_id])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password,
      :password_confirmation, :name, :city, :state, :country])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end
end
