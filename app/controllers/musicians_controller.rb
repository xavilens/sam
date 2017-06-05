class MusiciansController < ApplicationController
  ######### FILTERS
  before_filter :authenticate_user!, except: [:index]

  ######### CALLBACKS
  before_action :set_current_user, only: [:index, :edit, :update]
  before_action :set_musician, only: [:edit, :update]

  ######### DECORATORS
  decorates_assigned :users

  ######### ACTIONS
  def index
    @search = MusicianSearchForm.new(search_params)
    @users = @search.users.page(params[:page])

    # Definimos el nombre de la página
    @page = 'Músicos'
  end

  def edit
    @musician.musician_knowledges.build
    set_edit
  end

  def update
    if @musician.update(update_params)
      redirect_to user_edit_knowledges_path(@musician.user), notice: 'Tu cuenta ha sido actualizada correctamente.'
    else
      set_edit
      render :edit
    end
  end

  private
    # Define variables para la pagina edit knowledge
    def set_edit
      # Definimos el nombre de la página
      @page = "Editar cuenta"
    end

    # Define la variable @user con el usuario actual
    def set_current_user
      @user = current_user
    end

    # Define lo necesario para que la vista Edit funcione correctamente
    def set_musician
      if @user.musician?
        @musician = @user.profile
      else
        raise ActionController::RoutingError.new
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def update_params
      allow = [:musician_status_id, musician_knowledges_attributes: [:id, :instrument_id, :level_id, :_destroy]]

      params.require(:musician).permit(allow)
    end

    # Parámetros de búsqueda de usuarios permitidos por el controlador
    def search_params
      if params[:musician_search_form].present?
        params.require(:musician_search_form).permit(:name, :location_type, :city, :province,
        :region, instrument: [], status: [])
      else
        {}
      end
    end
end
