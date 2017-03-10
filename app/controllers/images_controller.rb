class ImagesController < ApplicationController
  before_filter :authenticate_user!

  before_action :set_image, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:index, :show]
  before_action :set_current_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :author?, only: [:edit, :update, :destroy]

# GET /post_attachments
# GET /post_attachments.json
def index
  @images = Image.all
end

# GET /post_attachments/1
# GET /post_attachments/1.json
def show
end

# GET /post_attachments/new
def new
  @images = @user.images.build

  @page = 'Nueva imagen'
end

# GET /post_attachments/1/edit
def edit

  @page = 'Editar imagen'
end

# POST /post_attachments
# POST /post_attachments.json
def create
  # @image = Image.new(image_params)

  respond_to do |format|
    # if @image.save
    if @user.update(image_create_params)
      format.html { redirect_to @user, notice: 'Imágenes publicadas' }
      format.json { render :show, status: :created, location: @user }
    else
      format.html { render :new }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end
end

# PATCH/PUT /post_attachments/1
# PATCH/PUT /post_attachments/1.json
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

# DELETE /post_attachments/1
# DELETE /post_attachments/1.json
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
    @user = User.params[:user_id].decorate
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_current_user
    @user = current_user.decorate
  end

  # Indica si el usuario actual que intenta modificar la imagen es el autor de esta
  def author?
    is_user = case @image.imageable_type
    when 'User'
      @image.imageable == @user
    when 'Event'
      @image.imageable == @event
    end

    unless is_user
      redirect_to :back, alert: 'No tiene permisos para acceder a esa página'
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_create_params
    params.require(:user).permit(images_attributtes: [:title, :description, :image])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_params
    params.require(:images).permit(:title, :description, :imageable, :image)
  end
end
