class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update]

  before_action :set_edit_page, only: [:edit]
  before_action :set_user_presenter, only: [:show]
  before_action :set_current_user, only: [:update, :update_knowledges]
  before_action :set_edit_musician_knowledges, only: [:edit_knowledges]
  before_action :set_musician, only: [:update_knowledges]
  before_action :search_params, only: [:index]
  before_action :update_params, only: [:update]

  # Breadcrumbs
  add_breadcrumb "Inicio", :root_path
  add_breadcrumb "Usuarios", :users_path

  def index
    # Define el tipo de perfil sacado de los parámetros
    profileable_type = search_params[:profileable_type] unless search_params.blank?

    # Definimos el nombre de la pantalla
    @page = profileable_type.blank? ? User.to_s.pluralize : profileable_type.pluralize

    # Obtenemos los usuarios a través del servicio de búsqueda de usuarios
    @users = SearchUsers.new(search_params).users
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

  def edit_knowledges
  end

  def update_knowledges
    if params[:add_musician_knowledge]
      @user.profile.musician_knowledges.build
    else
      if @musician.update(update_musician_params)
        flash[:notice] = 'Tu cuenta ha sido actualizada correctamente.'
      end
    end

    render action: :edit_knowledges
  end

  private
    ## SETTERS

    # Define variables para la pagina edit
    def set_edit_page
      # Definimos el nombre de la página
      @page = "Editar cuenta"

      set_current_user

      @edit = params[:edit]
    end

    # Define variables para la pagina edit knowledge
    def set_edit_musician_knowledges
      set_current_user

      if @user.musician?
        # Definimos el nombre de la página
        @page = "Editar cuenta"

        set_musician

        @musician.musician_knowledges.build
      else
        redirect_to @user, alert: 'No tienes acceso a la página.'
      end
    end

    # Define la variable @user con el usuario pasado por parámetros
    def set_user
      @user = User.find(params[:id])
    end

    # Define la variable @user con el UserPresenter del usuario actual
    def set_user_presenter
      @user = UserPresenter.new(set_user)
    end

    # Define la variable @user con el usuario actual
    def set_current_user
      @user = current_user
    end

    # Define la variable @user con el UserPresenter del usuario actual
    def set_current_user_presenter
      @user = UserPresenter.new(current_user)
    end

    # Define lo necesario para que la vista EditKnowledge funcione correctamente
    def set_musician
      @musician = @user.profile
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

    # Parámetros permitidos en la búsqueda de usuarios
    def search_params
      begin
        allow = [:name, :location, :country, :profileable_type, :role_id]

        search_params = params[:search]
        search_params.delete_if { |k, v| v.blank? }

        search_params.permit(allow)
      rescue # StandardError
        nil
      end
    end
end
