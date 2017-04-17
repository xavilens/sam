class VideosController < ApplicationController
  before_action :set_user, only: [:index]
  before_action :set_current_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_video, only: [:edit, :update, :destroy]
  before_action :set_new_title, only: [:new, :create]
  before_action :set_edit_title, only: [:edit, :update]

  def index
    @videos = @user.videos

    @page = "Vídeos"
    @title = "Vídeos de #{@user.name}"
  end

  def new
    @video = @user.videos.build
  end

  def edit
    @page = "Editar vídeo"
    @title = @page
  end

  def create
    @video = @user.videos.build(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to user_videos_path(user_id: @user.id), notice: 'Video creado correctamente' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to user_videos_path(user_id: @user), notice: 'Video actualizado correctamente' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to user_videos_path(user_id: @user), notice: 'Video eliminado correctamente' }
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
    def set_video
      @video = @user.videos.find(params[:id])
    end

    # Inicializa las variables para nombrar la página New
    def set_new_title
      @page = "Nuevo vídeo"
      @title = @page
    end

    # Inicializa las variables para nombrar la página Edit
    def set_edit_title
      @page = "Editar vídeo"
      @title = @page
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      api_data_param = params[:api_data].present? ? params[:api_data] : {}

      params.require(:video).permit(:url, :in_user_page, :title, :description).merge(api_data: api_data_param)
    end
end
