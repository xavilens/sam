class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [:new, :create, :cancel]
  prepend_before_action :authenticate_scope!, only: [:edit, :update, :destroy]
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def new
    @page = 'Regístrate'
    # super
    build_resource
    resource.build_address
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

    # Añadimos a los parametros el id del perfil
    params[:user][:profileable_id] = profile.id
    # Añadimos el avatar por defecto si no se ha dado ninguno
    params[:user][:avatar] = ImageUploader.new.default_url if params[:user][:avatar].blank?
    # Creamos y añadimos el conjunto de redes sociales
    social_networks_set = SocialNetworksSet.create

    # OLD: Llamamos a la clase padre
    # super

    # Creamos el usuario
    build_resource(sign_up_params)
    resource.create_social_networks_set

    # si se puede guardar creamos una dirección asociada al usuario
    if resource.valid?
      resource.save
      resource.build_address(address_params).save
    else # Si no, destruimos los registros creados
      if profile_type == 'Musician'
        profile = Musician.destroy(profile.id)
      elsif profile_type == 'Band'
        profile = Band.destroy(profile.id)
      end
      SocialNetworksSet.destroy(resource.social_networks_set)
    end

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
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :name,
      :profileable_type, :profileable_id, :avatar, :social_network_set_id])
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

  def address_params
    allow = [:gaddress, :city, :municipality, :province, :region, :country]

    params.require(:user).require(:address_attributes).permit(allow)
  end

  def sign_up_params
    allow = [:email, :password, :name, :profileable_type, :profileable_id, :avatar, :social_network_set_id]

    params.require(:user).permit(allow)
  end
end
