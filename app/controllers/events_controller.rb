class EventsController < ApplicationController
  before_filter :authenticate_user!

  before_action :set_event_Decorator, only: [:show]
  before_action :set_event, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:show, :index]
  before_action :set_current_user, only: [:new, :create, :edit, :update, :destroy]

  # after_create :set_uploads_images

  def index
    @page = 'Calendario de eventos'
    @events = EventDecorator.wrap(Event.all)
  end

  def new
    @event = Event.new
    @page = 'Nuevo evento'
    @event.build_address
    @event.images.build
  end

  def show
    @page = @event.name
  end

  def edit
    @page = 'Editar evento'
  end

  def create
    @event = Event.new(event_with_images_params)
    @event.creator = current_user

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Evento creado satisfactoriamente.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html {
          set_new
          render :new, alert: 'Ha habido errores al crear el evento.' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    debugger

    respond_to do |format|
      if @event.update(event_update_params)
        format.html { redirect_to @event, notice: 'Evento creado satisfactoriamente.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.images.destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Evento borrado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Seteamos la variable @event con el evento cuyo id obtenemos de los parametros
    def set_event
      @event = Event.find(params[:id])
    end

    # Seteamos la variable @event con el presentador del evento cuyo id obtenemos de los parametros
    def set_event_Decorator
      @event = EventDecorator.new(set_event)
    end

    # Seteamos la variable @event con el evento cuyo id obtenemos de los parametros
    def set_user
      @user = if params[:user_id]
        User.find(params[:user_id])
      else
        @event.creator
      end

      return @user.decorate
    end

    # Seteamos la variable @event con el presentador del evento cuyo id obtenemos de los parametros
    def set_current_user
      @user = current_user.decorate
    end

    # Parámetros de evento permitidos por el controlador
    def event_params
      params.require(:event).permit(:name, :description, :date, :time, :event_status_id, :event_type_id,
       :max_participants, :pvp, :creator_id, :sala_id, :_destroy,
       address_attributes: [:street, :gaddress, :city, :region, :country, :municipality, :postal_code,
         :province])
    end

    # Parámetros de evento permitidos por el controlador
    def event_with_images_params
      params.require(:event).permit(:name, :description, :date, :time, :event_status_id, :event_type_id,
        :max_participants, :pvp, :creator_id, :sala_id, :_destroy,
        address_attributes: [:street, :gaddress, :city, :region, :country, :municipality, :postal_code, :province],
        images_attributes: [:image, :title, :desciption])
    end

    # Parámetros de evento permitidos por el controlador
    def event_update_params
      params.require(:event).permit(:name, :description, :date, :time, :event_status_id, :event_type_id,
        :max_participants, :pvp, :creator_id, :sala_id, :_destroy,
        address_attributes: [:id, :addresseable_type, :addresseable_id, :street, :gaddress, :city, :region,
          :country, :municipality, :postal_code, :province],
        images_attributes: [:id, :image, :title, :desciption, :_destroy])
    end

    # Parámetros de imágenes de evento permitidos por el controlador
    def event_image_params
      params.require(:event).permit(images_attributes: [:image])
    end
end
