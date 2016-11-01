class BandsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @page = 'Grupos'
    @users = UserPresenter.wrap(User.where(profileable_type: 'Band'))
  end

  # Breadcrumbs
  add_breadcrumb "Inicio", :root_path
  add_breadcrumb "Usuarios", :users_path
  add_breadcrumb "Grupos", :bands_path

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def band_params
      params.require(:band).permit(:genre_1_id, :genre_2_id, :genre_3_id,
        :band_status_id, user_attributes: [:bio])
    end
end
