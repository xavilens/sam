class EventCalendar
  attr_reader :calendar, :start_date, :finish_date

  def initialize start_date, finish_date, user = nil
    # Definimos las fechas y el calendario
    set_dates start_date, finish_date

    # Si está definido el usuario obtiene de él los eventos en las fechas dadas,
    # si no los saca de todos los eventos creados
    @events = if user.present?
      user.created_events.date(start_date, finish_date) +
      user.participated_events.date(start_date, finish_date) +
      user.member_events.date(start_date, finish_date)
    else
      Event.all.date(start_date, finish_date)
    end

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

  def any_event? date
    calendar[date].present?
  end

  private
    attr_accessor :events

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
end
