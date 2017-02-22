class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

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
  @image = Image.new
end

# GET /post_attachments/1/edit
def edit
end

# POST /post_attachments
# POST /post_attachments.json
def create
  @image = Image.new(image_params)

  respond_to do |format|
    if @image.save
      format.html { redirect_to @image, notice: 'Imagen creada correctamente.' }
      format.json { render :show, status: :created, location: @image }
    else
      format.html { render :new }
      format.json { render json: @image.errors, status: :unprocessable_entity }
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_params
    params.require(:images).permit(:title, :description, :imageable, :image)
  end
end