class FollowshipsController < ApplicationController
  before_action :set_user, only: [:index]
  before_action :set_users, only: [:create, :destroy]
  respond_to :html, :js

  def index
    @leaders = @user.leaders
    @followers = @user.followers
    @page = "Usarios que sigue #{@user.name}"
  end

  def create
    @user.follow! @leader

    respond_to do |format|
      format.html { redirect_to @leader }
      format.js {}
    end
  end

  def destroy
    if @user.following? @leader
      followship = @user.followships.where(leader_id: @leader.id).first
      followship.destroy

      respond_to do |format|
        format.html { redirect_to @leader }
        format.js {}
      end
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  private
    def set_user
      @user = User.find(params[:user_id]).decorate
    end

    def set_users
      @user = current_user
      @leader = User.find(params[:user_id])
    end
end
