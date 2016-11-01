class MusiciansController < ApplicationController
  before_filter :authenticate_user!

  def index
    @page = 'Músicos'
    @users = UserPresenter.wrap(User.where(profileable_type: 'Musician'))
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def musician_params
      params.fetch(:musician, {})
    end
end
