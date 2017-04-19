class BandsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @page = 'Grupos'
    @users = User.where(profileable_type: 'Band').decorate
  end

end
