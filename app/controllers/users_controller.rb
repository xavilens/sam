class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update]

  before_action :set_user, only: [:show]
  before_action :set_current_user, only: [:edit, :update, :update_knowledges]
  before_action :set_edit_page, only: [:edit]
  before_action :set_edit_musician_knowledges, only: [:edit_knowledges]

  def index
    # Define el tipo de perfil sacado de los parámetros
    profileable_type = search_params[:profileable_type] unless search_params.blank?

    # Creamos el objeto SearchForm
    @search = UserSearchForm.new(search_params)

    # Definimos el nombre de la pantalla
    @page = profileable_type.blank? ? User.to_s.pluralize : profileable_type.pluralize

    # Obtenemos los usuarios a través del servicio de búsqueda de usuarios
    @users = @search.users.decorate
    # @users = SearchUsers.new(search_params).users
  end

  def show
    # Redirige a inicio y muestra mensaje de error si no existe el usuario
    redirect_to root_path, alert: "No existe el usuario" if @user.blank?

    # Breadcrumb genérico para músicos y grupos
    add_breadcrumb "#{@user.type.pluralize}", ("#{@user.profileable_type.downcase.pluralize}_path").to_sym

    # Definimos el nombre de la página
    @page = @user.name
  end

  def edit
  end

  def update
    if update_resource(@user, update_params)
      redirect_to @user, notice: 'Tu cuenta ha sido actualizada correctamente.'
    else
      render action: :edit
    end
  end

  # Dirige a la página donde poder gestionar los conocimientos musicales
  def edit_knowledges
    @musician.musician_knowledges.build
  end

  # Método que actualiza los conocimientos musicales
  def update_knowledges
    @musician = @user.profile

    if params[:add_musician_knowledge]
      @user.profile.musician_knowledges.build
    else
      if @musician.update(update_musician_params)
        flash[:notice] = 'Tu cuenta ha sido actualizada correctamente.'
      end
    end

    render :edit_knowledges
  end

  private
    ## SETTERS
    # Define la variable @user con el usuario pasado por parámetros
    def set_user
      @user = User.find(params[:id]).decorate
    end

    # Define la variable @user con el usuario actual
    def set_current_user
      @user = current_user.decorate
    end

    # Define variables para la pagina edit
    def set_edit_page
      # Definimos el nombre de la página
      @page = "Editar cuenta"
      @edit = params[:edit]
    end

    # Define variables para la pagina edit knowledge
    def set_edit_musician_knowledges
      if @user.musician?
        # Definimos el nombre de la página
        @page = "Editar cuenta"

        set_musician

        @musician.musician_knowledges.build
      else
        raise ActionController::RoutingError.new
      end
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
        :instagram_url, :website_url]]

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
