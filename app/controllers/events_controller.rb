class EventsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :edit, :update]

  def index
    @page = 'Calendario de eventos'
    @events = Event.all
  end

  def new
    @page = 'Nuevo evento'

    @event = Event.new
    @event_statuses = EventStatus.all
    @event_types = EventType.all

    # @user = current_user
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
