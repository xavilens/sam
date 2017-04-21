namespace :events do
  desc "Cierra aquellos eventos activos para los que se ha pasado la fecha"
  task close_passed_events: :environment do
    opened = EventStatus.find_by_name('Abierto')
    closed = EventStatus.find_by_name('Cerrado')
    yesterday = Date.yesterday

    passed_events = Event.where(event_status: opened).where("date <= ?", yesterday)
    passed_events.each do |event|
      event.update(event_status: closed)
    end
  end

end
