class EventCalendar
  attr_reader :calendar, :start_date, :finish_date

  def initialize start_date, finish_date, search, user = nil
    # Definimos los atributos
    @search = search

    set_dates start_date, finish_date

    @search.start_date ||= @start_date
    @search.finish_date ||= @finish_date

    set_events user

    set_calendar
  end

  # Cambia las fechas y redefine el calendario
  def change_dates start_date, finish_date
    set_dates start_date, finish_date

    set_calendar
  end

  # Devuelve los eventos de la fecha pasada si existen, o un array vacío si no
  def day date
    if any_event? date
      calendar[date]
    else
      []
    end
  end

  # Indica si hay algún evento en la fecha pasada
  def any_event? date
    calendar[date].present?
  end

  private
    attr_accessor :events, :search

    # Define el calendario como un hash de fechas asociadas a un array de eventos celebrados en dicha fecha
    def set_calendar
      @calendar = Hash.new {|h, date| h[date] = Array.new}

      # Itera sobre cada evento y lo añade en la fecha en que se celebra si es que no está ya metido
      EventDecorator.decorate_collection(events).each do |event|
        unless @calendar[event.date].include? event
          @calendar[event.date] << event
        end
      end

      @calendar = @calendar.sort.to_h
    end

    # Define las fechas
    def set_dates start_date, finish_date
      @start_date = set_date start_date
      @finish_date = set_date finish_date
    end

    # Define las fechas
    def set_date date
      if date.is_a? String
        Date.parse(date)
      else
        date
      end
    end

    # Define los eventos
    def set_events user
      # Si está definido el usuario obtiene de él los eventos en las fechas dadas,
      # si no los saca de todos los eventos creados
      @events = if user.present?
        search.events(user.created_events) +
        search.events(user.participated_events) +
        search.events(user.member_events)
        # search.events user.member_events.date(start_date, finish_date)
      else
        search.events Event
      end
    end
end
