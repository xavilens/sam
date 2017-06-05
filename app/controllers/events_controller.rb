class EventsController < ApplicationController
  ######### FILTERS
  before_filter :authenticate_user!, except: [:index, :show]

  ######### CALLBACKS
  before_action :is_user_calendar?, only: [:index]
  before_action :set_user, only: [:show, :index]
  before_action :set_current_user, except: [:show, :index]

  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_events, only: [:index, :show]

  ######### DECORATORS
  decorates_assigned :events, :event, :user

  ######### ACTIONS
  def index
    event_calendar = if @is_user_calendar
      CreateUserEventCalendar.new(@user, event_search_params, params[:page])
    else
      CreateEventCalendar.new(event_search_params, params[:date], params[:page])
    end

    @start_date = event_calendar.start_date
    @finish_date = event_calendar.finish_date
    @calendar = event_calendar.calendar
    @search = event_calendar.search

    if (@is_user_calendar || !first_page && !last_page) && !uniq_page
      @start_date = @calendar.first_event_date
      @finish_date = @calendar.last_event_date
    elsif first_page
      @finish_date = @calendar.last_event_date
    elsif last_page
      @start_date = @calendar.first_event_date
    end

    # Datos página
    @page = 'Calendario de eventos'
    @title = @is_user_calendar ? "Eventos de #{@user.name}" : @page
  end

  def show
    # Calculamos el evento anterior y el siguiente
    event_pos = @events.index(@event)
    @prev_event = event_pos - 1 < 0 ? nil : @events.at(event_pos - 1)
    @next_event = event_pos + 1 >= @events.size ? nil : @events.at(event_pos + 1)

    # Definimos el título y el nombre de la página
    @page = @event.name
    @title = @page
  end

  def new
    @event = params[:date].present? ? Event.new(date: params[:date]) : Event.new
    set_new
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

  def edit
    set_edit
  end

  def update
    respond_to do |format|
      if @event.update(event_update_params)
        format.html { redirect_to user_event_path(user_id: @event.creator_id, id: @event),
          notice: 'Evento actualizado satisfactoriamente.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html {
          set_edit
          render :new
        }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_view
    # Comprobamos que se hay coherencia en los datos y que se tienen los privilegios para realizar la acción
    @event = current_user.created_events.find params[:event_id]

    # Definimos los datos para la vista
    @title = "Eliminar evento"

    @message = "Está a punto de eliminar el evento <b>'#{@event.name}'</b>.<br><br>¿Desea continuar?"
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: 'Evento borrado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Seteamos la variable @event con el evento cuyo id obtenemos de los parametros
    def is_user_calendar?
      @is_user_calendar = params[:user_id].present?
    end

    # Seteamos la variable @event con el evento cuyo id obtenemos de los parametros
    def set_user
      @user = params[:user_id].present? ? User.find(params[:user_id]).decorate : set_current_user
    end

    # Seteamos la variable @event con el presentador del evento cuyo id obtenemos de los parametros
    def set_current_user
      @user = current_user.decorate
    end

    # Seteamos la variable @event con el evento cuyo id obtenemos de los parametros
    def set_event
      @event = @is_user_calendar ? @user.created_events.find(params[:id]) : Event.find(params[:id])
    end

    # Seteamos la variable @events con los eventos del usuario o con todos los existentes
    def set_events
      @events = @is_user_calendar ? @user.events : Event.all.asc
    end

    # Definimos condiciones iniciales de la página New
    def set_new
      @event.build_address
      @event.images.build

      @page = 'Nuevo evento'
    end

    # Definimos condiciones iniciales de la página Edit
    def set_edit
      @event.images.build

      @page = 'Editar evento'
      @title = @page
    end

    # Indica si es la primera página
    def first_page
      !uniq_page && (params[:page].blank? || params[:page] == 1)
    end

    # Indica si es la última página
    def last_page
      !uniq_page && (params[:page] != @calendar.events.num_pages)
    end

    # Indica si es la última página
    def uniq_page
      @calendar.events.num_pages == 1
    end

    # Parámetros de evento permitidos por el controlador
    def event_params
      params.require(:event).permit(:name, :description, :date, :time, :event_status_id, :event_type_id,
       :max_participants, :pvp, :creator_id, :_destroy,
       address_attributes: [:street, :gaddress, :city, :region, :country, :municipality, :postal_code,
         :province])
    end

    # Parámetros de evento permitidos por el controlador
    def event_with_images_params
      params.require(:event).permit(:name, :description, :date, :time, :event_status_id, :event_type_id,
        :max_participants, :pvp, :creator_id, :_destroy,
        address_attributes: [:street, :gaddress, :city, :region, :country, :municipality, :postal_code, :province],
        images_attributes: [:image, :title, :desciption])
    end

    # Parámetros de evento permitidos por el controlador
    def event_update_params
      params.require(:event).permit(:name, :description, :date, :time, :event_status_id, :event_type_id,
        :max_participants, :pvp, :creator_id, :_destroy,
        address_attributes: [:id, :addresseable_type, :addresseable_id, :street, :gaddress, :city, :region,
          :country, :municipality, :postal_code, :province],
        images_attributes: [:id, :image, :title, :desciption, :_destroy])
    end

    # Parámetros de evento permitidos por el controlador
    def event_search_params
      if params[:event_search_form].present?
        params.require(:event_search_form).permit(:name, :finish_date, :location_type,
          :city, :province, :region, :start_date, type: [], status: [])
      else
        {}
      end
    end

    # Parámetros de imágenes de evento permitidos por el controlador
    def event_image_params
      params.require(:event).permit(images_attributes: [:image])
    end
end
