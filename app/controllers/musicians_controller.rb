class MusiciansController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_musician, only: [:edit, :update]
  before_action :set_musicians, only: [:index]

  # Breadcrumbs
  add_breadcrumb "Inicio", :root_path
  add_breadcrumb "Usuarios", :users_path
  add_breadcrumb "Músicos", :musicians_path

  def index
    # Definimos el nombre de la página
    @page = 'Músicos'
  end

  # TODO: BORRAR??
  def edit
    # Definimos el nombre de la página
    @page = "Editar cuenta"
  end

  def update
    if params[:add_musician_knowledge]
      @musician.musician_knowledges.build
    else
      if update_resource(@musician, update_params)
        redirect_to @user, notice: 'Tu cuenta ha sido actualizada correctamente.' and return
      end
    end

    render action: :edit
  end


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def musician_params
      params.fetch(:musician, {})
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
      set_current_user

      @musician = @user.profile
      @musician.musician_knowledges.build
    end

    # Define la variable @users como solo musicos
    def set_musicians
      @users = UserPresenter.wrap(User.where(profileable_type: 'Musician'))
    end
end
