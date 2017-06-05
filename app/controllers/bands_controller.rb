class BandsController < ApplicationController
  ######### FILTERS
  before_filter :authenticate_user!, except: [:index]

  ######### DECORATORS
  decorates_assigned :users

  ######### ACTIONS
  def index
    @user = current_user
    @search = BandSearchForm.new(search_params)
    @users = @search.users.page(params[:page])

    # Definimos el nombre de la página
    @page = 'Grupos'
  end

  private
    # Parámetros de búsqueda de usuarios permitidos por el controlador
    def search_params
      if params[:band_search_form].present?
        params.require(:band_search_form).permit(:name, :location_type, :city, :province,
        :region, genre: [], status: [])
      else
        {}
      end
    end
end
