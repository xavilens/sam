class EventsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :edit, :update]
  before_action :set_event_presenter, only: [:show]
  before_action :set_event, only: [:edit, :update, :destroy]

  def index
    @page = 'Calendario de eventos'
    @events = EventPresenter.wrap(Event.all)
  end

  def new
    @page = 'Nuevo evento'

    @event = Event.new
    @images = @event.images.build
    # @event_image = @event.build_image
  end

  def show
    @page = @event.name
  end

  def edit
    @page = 'Editar evento'
  end

  def create
    raise params.inspect

    @event = Event.new(event_params)
    @event.creator_id = current_user

    if params[:add_image]
      @event.images.build
      # render :new
    else
      respond_to do |format|
        if @event.save
          # event_image_params.each do |image|
          #   @event_image = @event.images.create!(image: event_image_params[:image])
            # @event_image.save
          # end

          # @event_image = @event.build_image(image: event_image_params[:image])
          # @event_image.save

          format.html { redirect_to @event, notice: 'Evento creado satisfactoriamente.' }
          format.json { render :show, status: :created, location: @event }
        else
          format.html { render :new }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    images = event_params[:image_attributes]

    respond_to do |format|
      if @event.update(event_params)
        # images.each do |image|
        #   @event.image.create!(image: image.second)
        # end

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
    def set_event_presenter
      @event = EventPresenter.new(set_event)
    end

    # Parámetros de evento permitidos por el controlador
    def event_params
      params.require(:event).permit(:name, :description, :date, :time, :event_status_id, :event_type_id, :street,
        :city, :state, :country, :address, :max_participants, :pvp, :creator, :sala)
    end

    # Parámetros de imágenes de evento permitidos por el controlador
    def event_image_params
      params.require(:event).require(:image_attributes).permit(:image)
    end
end
