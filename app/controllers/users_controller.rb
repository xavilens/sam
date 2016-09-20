class UsersController < ApplicationController

  before_filter :authenticate_user!, only: [:edit, :update]
  before_action :set_user, only: [:show]
  before_action :set_current_user, only: [:edit, :update]
  before_action :search_params, only: [:index]
  before_action :update_params, only: [:update]

  def index
    profileable_type = search_params[:profileable_type] unless search_params.blank?

    @page = unless profileable_type.blank?
      profileable_type.pluralize
    else
      User.to_s.pluralize
    end

    @users = SearchUsers.new(search_params).users
  end

  def show
    @page = @user.name

    redirect_to root_path, alert: "No existe el usuario" if @user.blank?
  end

  def edit
    @page = "Editar cuenta"

    render :edit
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

    def set_user
      @user = UserPresenter.new(User.where(id: params[:id]).first)
    end

    def set_current_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:id, :email, :password, :name, :city, :state,
        :country, :profileable_type, :profileable_id, :role_id)
    end

    def update_resource(resource, params)
      resource.update_without_password(params)
    end

    def update_params
      allow = [ :name, :city, :state, :country, :bio, :avatar, :facebook, :youtube,
        :twitter, :gplus, :soundcloud, :instagram, :website,
        profileable_attributes: [:genre_1_id, :genre_2_id, :genre_3_id, :band_status_id, :id] ]

      params.require(:user).permit(allow)
    end

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
