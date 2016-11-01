class UsersController < ApplicationController

  before_filter :authenticate_user!, only: [:edit, :update]
  before_action :set_user_presenter, only: [:show]
  before_action :set_current_user, only: [:edit, :update]
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

    # Breadcrumbs
    # add_breadcrumb "#{@user.type}", ("#{@user.profileable_type}_path").to_sym

    # Definimos el nombre de la página
    @page = @user.name
  end

  def edit
    # Definimos el nombre de la página
    @page = "Editar cuenta"
  end

  def update
    respond_to do |format|
      if update_resource(@user, update_params)
        format.html { redirect_to @user, notice: 'Tu cuenta ha sido actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
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
        social_networks_set_attributes: [:id, :facebook_url, :youtube_url, :twitter_url, :gplus_url, :soundcloud_url, :instagram_url, :website_url]]

      params.require(:user).permit(allow)
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
