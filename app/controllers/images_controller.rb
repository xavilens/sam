class ImagesController < ApplicationController
  before_filter :authenticate_user!

  before_action :set_user, only: [:index, :show]
  before_action :set_current_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :author?, only: [:edit, :update, :destroy]
  before_action :set_image, only: [:show, :edit, :update, :destroy]
  before_action :set_new, only: [:new]
  before_action :set_edit, only: [:edit]

def index
  @images = Image.all

  @page = "Imágenes de #{@user.name}"
  @title = @page
end

def show
  # Calculamos la imágen anterior y la siguiente
  images = @user.images.select(:id).order(id: :desc)
  image_pos = images.index(@image)

  @prev_image = if image_pos - 1 < 0
    nil
  else
    images.at(image_pos - 1)
  end

  @next_image = if image_pos + 1 >= images.size
    nil
  else
    images.at(image_pos + 1)
  end

  # Definimos el título y el nombre de la página
  @page = "Imágenes de #{@user.name}"
  @title = @image.title
end

def new
end

def edit
end

def create
  respond_to do |format|
    # if @image.save
    if @user.update(image_create_params)
      format.html { redirect_to @user, notice: 'Imágenes publicadas' }
      format.json { render :show, status: :created, location: @user }
    else
      format.html {
        set_new
        flash[:alert] = @user.errors
        render action: :new
      }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end
end

def update
  respond_to do |format|
    if @image.update(image_params)
      format.html {
        redirect_to user_image_path(user_id: @user.id, id: @image.id),
        notice: 'Imagen actualizada correctamente.'
      }
      format.json { render :show, status: :ok, location: @image }
    else
      format.html {
        set_edit
        flash[:alert] = @image.errors
        render :edit }
      format.json { render json: @image.errors, status: :unprocessable_entity }
    end
  end
end

def destroy
  @image.destroy
  respond_to do |format|
    format.html { redirect_to :back, notice: 'Imagen borrada correctamente.' }
    format.json { head :no_content }
  end
end

private
  # Define el usuario a partir de los parámetros
  def set_user
    @user = User.find(params[:user_id]).decorate
  end

  # Define el usuario con el usuario actual
  def set_current_user
    @user = current_user.decorate
  end

  # Define la imagen
  def set_image
    @image = @user.images.find(params[:id])
  end

  # Define el título de la página New
  def set_new
    @page = 'Publicar imágenes'
    @title = @page
  end

  # Define el título de la página Edit
  def set_edit
    @page = 'Editar imagen'
    @title = @page
  end

  # Indica si el usuario actual que intenta modificar la imagen es el autor de esta
  def author?
    is_author = case @image.imageable_type
    when 'User'
      @image.imageable == @user
    when 'Event'
      @image.imageable.creator == @user
    end

    unless is_author
      raise ActionController::RoutingError.new
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_create_params
    params.require(:user).permit(images_attributes: [:title, :description, :image, :imageable])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_params
    params.require(:image).permit(:title, :description, :image, :_destroy)
  end
end
