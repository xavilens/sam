class EventsController < ApplicationController
  ######### FILTERS
  before_filter :authenticate_user!

  ######### CALLBACKS
  before_action :is_user_calendar?, only: [:index]
  before_action :set_user, only: [:show, :index]
  before_action :set_current_user, only: [:new, :create, :edit, :update, :destroy_view, :destroy]

  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_events, only: [:index, :show]

  ######### DECORATORS
  decorates_assigned :events, :event

  ######### ACTIONS
  def index
    # Definimos fechas
    if @is_user_calendar
      @start_date = @events.first.date
      @finish_date = @events.last.date
    else
      if params[:date].present? || event_search_params["start_date(2i)"].present?
        date = params[:date].present? ? params[:date] : "01/#{event_search_params['start_date(2i)'].to_i}/#{event_search_params['start_date(1i)'].to_i}"

        @start_date = Date.parse(date)
        @start_date = @start_date.beginning_of_month
      else
        today = Date.today
        @start_date = Date.new today.year, today.month
      end

      @finish_date = @start_date.end_of_month
    end

    # Creamos el buscador
    @search = EventSearchForm.new(event_search_params)
    @search.start_date = @start_date
    @search.finish_date = @finish_date

    # Creamos calendario
    @calendar = EventCalendar.new @start_date, @finish_date, @search, (@is_user_calendar ? @user : nil)

    debugger
    @calendar.events = Kaminari.paginate_array(@calendar.events).page(params[:page]).per(1)

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
