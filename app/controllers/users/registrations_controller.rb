class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [:new, :create, :cancel]
  prepend_before_action :authenticate_scope!, only: [:edit, :update, :destroy]
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def new
    @page = 'Regístrate'
    super
  end

  def create
    # Comprobamos qué tipo de perfil tiene el usuario y creamos el perfil al que
    # lo asociaremos
    profile_type = params[:user][:profileable_type]

    if profile_type == 'Musician'
      profile = Musician.create()
    elsif profile_type == 'Band'
      profile = Band.create()
    end

    # Añadimos a los parametros su id
    params[:user][:profileable_id] = profile.id

    params[:user][:avatar] = ImageUploader.new.default_url  if params[:user][:avatar].blank?

    # Llamamos a la clase padre
    super
  end

  def edit
    @page = 'Editar datos de acceso'
    super
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :name, :city,
      :state, :country, :profileable_type, :profileable_id, :avatar])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end

  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end
end
