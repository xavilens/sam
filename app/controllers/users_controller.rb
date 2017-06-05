class UsersController < ApplicationController
  ######### FILTERS
  before_filter :authenticate_user!, except: [:show, :index]

  ######### CALLBACKS
  before_action :set_user, only: [:show]
  before_action :set_current_user, only: [:index, :edit, :update]

  ######### DECORATORS
  decorates_assigned :users, :user

  ######### ACTIONS
  def index
    # Define el tipo de perfil sacado de los parámetros
    profileable_type = search_params[:profileable_type] unless search_params.blank?

    # Creamos el objeto SearchForm
    @search = UserSearchForm.new(search_params)

    # Definimos el nombre de la pantalla
    @page = profileable_type.blank? ? User.to_s.pluralize : profileable_type.pluralize

    # Obtenemos los usuarios a través del servicio de búsqueda de usuarios
    @users = @search.users.page(params[:page])
  end

  def show
    # Redirige a inicio y muestra mensaje de error si no existe el usuario
    redirect_to root_path, alert: "No existe el usuario" if @user.blank?

    @social_networks = user.social_networks

    # Definimos el nombre de la página
    @page = @user.name
  end

  def edit
    set_edit_page
  end

  def update
    if @user.update(update_params)
      redirect_to @user, notice: 'Tu cuenta ha sido actualizada correctamente.'
    else
      render action: :edit
    end
  end

  private
    ## SETTERS
    # Define la variable @user con el usuario pasado por parámetros
    def set_user
      @user = User.find(params[:id])
    end

    # Define la variable @user con el usuario actual
    def set_current_user
      @user = current_user
    end

    # Define variables para la pagina edit
    def set_edit_page
      # Definimos el nombre de la página
      @page = "Editar cuenta"
      @edit = params[:edit]
    end

    ## STRONG PARAMETERS
    # Parámetros permitidos en el controlador de usuarios
    def user_params
      params.require(:user).permit(:id, :email, :password, :name, :city, :state,
        :country, :profileable_type, :profileable_id, :role_id)
    end

    # Método que actualiza el recurso sin necesidad de pedir confirmación por contraseña
    def update_resource(resource, params)
      resource.update_without_password(params)
    end

    # Parámetros permitidos en la actualización del usuario
    def update_params
      allow = [ :id, :name, :bio, :avatar,
        profileable_attributes: [:id, :musician_status_id, :genre_1_id, :genre_2_id, :genre_3_id, :band_status_id],
        address_attributes: [:id, :gaddress, :city, :municipality, :province, :region, :country],
        social_networks_set_attributes: [:id, :facebook_url, :youtube_url, :twitter_url, :gplus_url, :soundcloud_url,
        :instagram_url, :website_url, :vimeo_url, :bandcamp_url]]

      params.require(:user).permit(allow)
    end

    # Parámetros permitidos en la actualización del perfil músico
    def update_musician_params
      allow = [ :id, :id_musician_status, :add_musician_knowledge,
        musician_knowledges_attributes: [:id, :instrument_id, :level_id, :_destroy]]

      mk_params = params.require(:musician).permit(allow)

      # Eliminamos los parámetros que vengan vacíos
      mk_params[:musician_knowledges_attributes].each do |mk_key, mk_value|
        if (mk_value[:instrument_id].blank? && mk_value[:level_id].blank?)
          mk_params[:musician_knowledges_attributes].delete "#{mk_key}"
        end
      end

      return mk_params
    end

    # Parámetros de búsqueda de usuarios permitidos por el controlador
    def search_params
      if params[:user_search_form].present?
        params.require(:user_search_form).permit(:name, :location_type,
          :city, :province, :region, type: [])
      else
        {}
      end
    end
end
