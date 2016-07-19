class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_current_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    redirect_to root_path, alert: "No existe el usuario" if @user.blank?
  end

  def edit
    @user = current_user if @user.blank? || @user != current_user
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
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
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
      allow = [:name, :city, :state, :country, :bio,
        profileable_attributes: [:genre_1_id, :genre_2_id, :genre_3_id, :band_status_id, :id]]
      params.require(:user).permit(allow)
    end
end
