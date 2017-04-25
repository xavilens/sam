# Módulo en el que definimos las distintas tareas (Jobs) para la clase Event
module EventJobs
  # Cierra aquellos eventos abiertos cuya fecha haya pasado
  def self.close_expired_events
    opened = EventStatus.find_by_name('Abierto')
    closed = EventStatus.find_by_name('Cerrado')
    yesterday = Date.yesterday

    passed_events = Event.where(event_status: opened).where("date <= ?", yesterday)
    passed_events.each do |event|
      event.update(event_status: closed)
    end
  end
end
