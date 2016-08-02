class UsersController < ApplicationController

  before_filter :authenticate_user!, only: [:edit, :update]
  before_action :set_user, only: [:show]
  before_action :set_current_user, only: [:edit, :update]
  before_action :search_params, only: [:index]
  before_action :update_params, only: [:update]

  def index
    index_param = search_params
    profileable_type = index_param[:profileable_type] unless search_params[:profileable_type].blank?
    name = index_param.delete(:name)
    city = index_param.delete(:city)
    state = index_param.delete(:state)

    unless profileable_type.blank?
      @page = profileable_type.pluralize
    else
      @page = User.to_s.pluralize
    end

    users = User.where(index_param).where("name like :name and city like :city and state like :state",
      name: "%#{name}%", city: "%#{city}%", state: "%#{state}%")

    @users = UserPresenter.wrap(users)
  end

  def show
    @page = @user.name

    redirect_to root_path, alert: "No existe el usuario" if @user.blank?
  end

  def edit
    @page = "Editar cuenta"

    # @user = current_user if @user != current_user
    if @user.musician?
      @musician_statuses = MusicianStatus.all if @musician_statuses.blank?
    elsif @user.band?
      @genres = Genre.all if @genres.blank?
      @band_statuses = BandStatus.all if @band_statuses.blank?
    end

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
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.where(id: params[:id]).first
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_current_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
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
      if params[:search]
        allow = [:name, :city, :state, :country, :profileable_type, :role_id]

        search_params = params[:search]
        search_params.delete_if { |k, v| v.blank? }

        search_params.permit(allow)
      else
        params.permit(:profileable_type)
      end
    end
end
