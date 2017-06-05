class SongsController < ApplicationController
  ######### FILTERS
  before_filter :authenticate_user!

  ######### CALLBACKS
  before_action :set_user, only: [:index]
  before_action :set_current_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_song, only: [:edit, :update, :destroy]

  ######### DECORATORS
  decorates_assigned :songs, :song, :user

  ######### ACTIONS
  def index
    @songs = @user.songs
  end

  def new
    @song = @user.songs.build
  end

  def edit
  end

  def create
    @song = @user.songs.build(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to @user, notice: 'Tema añadido correctamente' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @user, notice: 'Tema actualizado correctamente' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to @user, notice: 'Tema eliminado correctamente' }
      format.json { head :no_content }
    end
  end

  private
    # Definimos la variable @user con el usuario pasado por url o el actual
    def set_user
      @user = User.find(params[:user_id]).decorate
    end

    # Definimos la variable @user con el usuario actual
    def set_current_user
      @user = current_user.decorate
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = @user.songs.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.require(:song).permit(:name, :url, :user_id, :in_user_page)
    end
end
