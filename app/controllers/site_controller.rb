class SiteController < ApplicationController
  ######### DECORATORS
  decorates_assigned :user

  ######### ACTIONS
  def index
    if user_signed_in?
      redirect_to user_path(current_user)
    end
  end
end
