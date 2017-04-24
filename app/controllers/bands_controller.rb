class BandsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user
    @users = User.bands.decorate
    @page = 'Grupos'
  end
end
