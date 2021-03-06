class ImagesController < ApplicationController
  ######### FILTERS
  before_filter :authenticate_user!

  ######### CALLBACKS
  before_action :set_user, only: [:index, :show]
  before_action :set_current_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  ######### DECORATORS
  decorates_assigned :images, :image, :user

  ######### ACTIONS
  def index
    if @is_user_images
      @images = @user.images
      @page = "Imágenes de #{@user.name}"
    else
      @images = Image.all
      @page = "Imágenes"
    end

    @images = @images.page(params[:page])
    @title = @page
  end

  def show
    # Calculamos la imágen anterior y la siguiente
    images = @user.images.select(:id).order(id: :desc)
    image_pos = images.index(@image)

    @prev_image = image_pos - 1 < 0 ? nil : images.at(image_pos - 1)
    @next_image =  image_pos + 1 >= images.size ? nil : images.at(image_pos + 1)

    # Definimos el título y el nombre de la página
    @page = "Imágenes de #{@user.name}"
    @title = @image.title
  end

  def new
    set_new
  end

  def edit
    set_edit
  end

  def create
    respond_to do |format|
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
      @is_user_images = params[:user_id].present?
      @user = @is_user_images ? User.find(params[:user_id]).decorate : set_current_user
    end

    # Define el usuario con el usuario actual
    def set_current_user
      @user = current_user
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_create_params
      params.require(:user).permit(images_attributes: [:title, :description, :image, :imageable])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:title, :description, :image, :_destroy)
    end
end
