class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    redirect_to root_path, alert: "No existe el usuario" if @user.blank?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.where(id: params[:id]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :email, :password, :name, :city, :state,
        :country, :profileable_type, :profileable_id, :role_id)
    end
end
