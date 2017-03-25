class EventsController < ApplicationController
  before_filter :authenticate_user!

  before_action :set_user, only: [:show, :index]
  before_action :set_current_user, only: [:new, :create, :edit, :update, :destroy]

  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_events, only: [:index, :show]

  # after_create :set_uploads_images

  def index
    @page = 'Calendario de eventos'
    @title = @page
  end

  def new
    @event = Event.new
    @page = 'Nuevo evento'

    @event.build_address
    @event.images.build
  end

  def show
    # Calculamos el evento anterior y el siguiente
    event_pos = @events.index(@event)
    @prev_event = if event_pos - 1 < 0
      nil
    else
      @events.at(event_pos - 1)
    end

    @next_event = if event_pos + 1 >= @events.size
      nil
    else
      @events.at(event_pos + 1)
    end

    # Definimos el título y el nombre de la página
    @page = @event.name
    @title = @page
  end

  def edit
    @page = 'Editar evento'
    @title = @page
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
    respond_to do |format|
      if @event.update(event_update_params)
        format.html { redirect_to user_event_path(user_id: @event.creator_id, id: @event), notice: 'Evento creado satisfactoriamente.' }
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
      @event = if params[:user_id]
        @user.events.find(params[:id]).decorate
      else
        Event.find(params[:id]).decorate
      end
    end

    def set_events
      @events = if params[:user_id]
        @user.events.asc.decorate
      else
        Event.all.asc.decorate
      end
    end

    # Seteamos la variable @event con el evento cuyo id obtenemos de los parametros
    def set_user
      @user = User.find(params[:user_id]).decorate
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
