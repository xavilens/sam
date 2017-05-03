class CreateUserEventCalendar
  attr_accessor :events, :start_date, :finish_date, :calendar, :page, :user, :search

  def initialize (user, params, page)
    @user = user
    @page = page
    @events = @user.events

    # Definimos fechas
    @start_date = @events.first.date
    @finish_date = @events.last.date

    # Creamos el buscador
    @search = EventSearchForm.new(params)
    @start_date = @search.start_date.present? ? @search.start_date : @events.first.date
    @finish_date = @search.finish_date.present? ? @search.finish_date : @events.last.date

    # Creamos calendario
    @calendar = EventCalendar.new @start_date, @finish_date, @search, @user

    # Creamos la paginación
    @calendar.events = Kaminari.paginate_array(@calendar.events).page(page).per(15)
  end
end
