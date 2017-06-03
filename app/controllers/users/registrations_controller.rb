class Users::RegistrationsController < Devise::RegistrationsController
  ######### CALLBACKS
  prepend_before_action :require_no_authentication, only: [:new, :create, :cancel]
  prepend_before_action :authenticate_scope!, only: [:edit, :update, :destroy]

  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  ######### ACTIONS
  def new
    @page = 'Regístrate'
    build_resource
    resource.build_address
    @user = resource
  end

  def create
    # Creamos el usuario
    build_resource(sign_up_params)

    # Añadimos la dirección del usuario
    resource.build_address(address_params)

    # Añadimos el perfil del usuarios
    profile_type = sign_up_params[:profileable_type]
    resource.profileable = if profile_type == 'Musician'
      Musician.new
    elsif profile_type == 'Band'
      Band.new
    end

    # Añadimos las redes sociales del usuario
    resource.build_social_networks_set

    # Añadimos el avatar por defecto del usuario si no se ha subido otro
    resource.avatar = ImageUploader.new.default_url if sign_up_params[:avatar].blank?

    # Guardamos el usuario
    resource.save
    @user = resource

    # Resto de algoritmo de la clase padre
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def edit
    @page = 'Editar datos de acceso'
    super
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :name, :avatar])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end

  # Ruta utilizada tras registrarse
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # Ruta utilizada tras registrarse cuando la cuenta se inhabilita
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end

  # Parámetros permitidos para la creación de la dirección
  def address_params
    allow = [:gaddress, :city, :municipality, :province, :region, :country]

    params.require(:user).require(:address_attributes).permit(allow)
  end

  # Parámetros permitidos en el registro
  def sign_up_params
    allow = [:email, :password, :name, :profileable_type, :profileable_id, :avatar, :social_network_set_id]

    params.require(:user).permit(allow)
  end
end
