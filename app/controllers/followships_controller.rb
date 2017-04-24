class FollowshipsController < ApplicationController
  respond_to :html, :js

  before_filter :authenticate_user!

  before_action :set_user, only: [:leaders, :followers]
  before_action :set_users, only: [:create, :destroy]

  def leaders
    @leaders = @user.leaders.order(id: :desc).decorate
    @page = "Usarios que sigue #{@user.name}"
    @title = @page
  end

  def followers
    @followers = @user.followers.order(id: :desc).decorate
    @page = "Usarios que siguen a #{@user.name}"
    @title = @page
  end

  def create
    @user.follow! @leader

    respond_to do |format|
      format.html { redirect_to :back, notice: "Estás siguiendo a #{@leader.name}" }
      format.js {}
    end
  end

  def destroy
    if @user.following? @leader
      followship = @user.followships.where(leader_id: @leader.id).first
      followship.destroy

      respond_to do |format|
        format.html { redirect_to :back, alert: "Has dejado de seguir a #{@leader.name}" }
        format.js {}
      end
    else
      raise ActionController::RoutingError.new
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
