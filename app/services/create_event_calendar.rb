class CreateEventCalendar
  attr_accessor :events, :start_date, :finish_date, :calendar, :search

  def initialize (params, date)
    # Definimos la fecha
    if date.present? || params["start_date(2i)"].present?
      date = date.present? ? date : "01/#{params['start_date(2i)'].to_i}/#{params['start_date(1i)'].to_i}"

      @start_date = Date.parse(date)
      @start_date = @start_date.beginning_of_month
    else
      today = Date.today
      @start_date = Date.new today.year, today.month
    end

    @finish_date = @start_date.end_of_month

    # Creamos el buscador
    @search = EventSearchForm.new(params)
    @search.start_date = @start_date
    @search.finish_date = @finish_date

    # Creamos calendario
    @calendar = EventCalendar.new @start_date, @finish_date, @search, (@is_user_calendar ? @user : nil)
  end
end
