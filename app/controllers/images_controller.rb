class ImagesController < ApplicationController
  before_filter :authenticate_user!

  before_action :set_image, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:index, :show]
  before_action :set_new, only: [:new]
  before_action :set_edit, only: [:edit]
  before_action :set_current_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :author?, only: [:edit, :update, :destroy]

def index
  @images = Image.all

  @page = "Imágenes de #{@user.name}"
  @title = "Imágenes"
end

def show
  @page = "Imágenes de #{@user.name}"

  images = @user.images.order(id: :desc)
  image_pos = images.index(@image)

  @prev_image = images.at(image_pos - 1)
  @next_image = images.at(image_pos + 1)

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
        flash[:alert] = 'No se pueden procesar las imágenes'
        render action: :new
      }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end
end

def update
  respond_to do |format|
    if @image.update(image_params)
      format.html { redirect_to @image.imageable, notice: 'Imagen actualizada correctamente.' }
      format.json { render :show, status: :ok, location: @image }
    else
      format.html { render :edit }
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
  # Use callbacks to share common setup or constraints between actions.
  def set_image
    @image = Image.find(params[:id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:user_id]).decorate
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_current_user
    @user = current_user.decorate
  end

  def set_new
    @page = 'Publicar imágenes'
  end

  def set_edit
    @page = 'Editar imagen'
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
      redirect_to :back, alert: 'No tiene permisos para acceder a esa página'
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_create_params
    params.require(:user).permit(images_attributes: [:title, :description, :image, :imageable])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_params
    params.require(:images).permit(:title, :description, :imageable, :image)
  end
end
