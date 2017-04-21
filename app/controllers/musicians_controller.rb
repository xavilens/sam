class MusiciansController < ApplicationController
  before_filter :authenticate_user!

  before_action :set_current_user, only: [:edit, :update]
  before_action :set_musician, only: [:edit, :update]
  before_action :set_musicians, only: [:index]

  def index
    # Definimos el nombre de la página
    @page = 'Músicos'
  end

  def edit
  end

  # FIXME: Poner de forma que usar
  def update
    if update_resource(@musician, update_params)
      redirect_to @user, notice: 'Tu cuenta ha sido actualizada correctamente.' and return
    else
      set_edit
      render :edit
    end
  end

  private
    # Definimos el nombre de la página
    def set_edit
      @page = "Editar cuenta"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def update_params
      allow = [ :id, :musician_status_id,
        musician_knowledges_attributes: [:id, :instrument_id, :level_id]]

      params.require(:user).permit(allow)
    end

    # Define la variable @user con el usuario actual
    def set_current_user
      @user = current_user
    end

    # Define lo necesario para que la vista EditKnowledge funcione correctamente
    def set_musician
      if @user.musician?
        @musician = @user.profile
        @musician.musician_knowledges.build
      else
        raise ActionController::RoutingError.new
      end
    end

    # Define la variable @users como solo musicos
    def set_musicians
      @users = User.where(profileable_type: 'Musician').decorate
    end
end
