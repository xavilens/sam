class EventsController < ApplicationController
  def index
    @page = 'Calendario de eventos'
    @events = Event.all
  end

  def new
    @page = 'Nuevo evento'
  end

  def show
    @page = 'Evento'
  end

  def edit
    @page = 'Editar evento'
  end

  def update
  end
end
