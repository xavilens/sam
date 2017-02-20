class MembersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @members = Members.all

    @page = 'Miembros'
  end

  def show
    @members = Members.find(params[:id])

    @page = 'Miembros'
  end

  def new
    from_user = User.find(params[:from_user])
    if from_user.band?
      band = from_user.profile
      musician = User.find(params[:user_id]).profile
    else
      musician = from_user.profile
      band = User.find(params[:user_id]).profile
    end

    @member = Member.new(band: band, musician: musician)
  end

  def send_request
    from_user = User.find(params[:from_user])
    if from_user.band?
      band = from_user.profile
      musician = User.find(params[:user_id]).profile
    else
      musician = from_user.profile
      band = User.find(params[:user_id]).profile
    end

    @member = Member.new(band: band, musician: musician)

    respond_to do |format|
      format.js
    end
  end

  def create

  end

  def update

  end

  def add
    redirect_to :back, notice: 'Prueba'
  end

  private
    def create_params

    end

    def update_params

    end
end
