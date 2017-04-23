class EventParticipantsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :js

  before_action :check_participants_avaliable, only: [:new, :create, :participant_request, :send_request]

  def participant_request
    # Definimos el creador
    event = Event.find(params[:event_id])
    creator = event.creator

    # Definimos el título del modal y el mensaje que mostraremos
    @title = "Enviar petición de participación"

    @message = "Está a punto de enviar una petición a #{creator.name} para participar en su evento."
    @message += "<br><br>¿Desea continuar?"

    # Creamos el participante con el evento y el músico para el formulario
    @event_participant = EventParticipant.new(event: event, participant: current_user)
  end

  def send_request
    # Definimos el creador
    event = Event.find(event_participants_params[:event_id])
    creator = event.creator

    # Si es válido envía un mensaje al creador pidiendo ser participante
    send_message = SendAddParticipantMessage.new(event, creator, current_user)
    if send_message.do
      send_message.relate_to_event
      flash.now[:notice] = "Petición enviada a #{creator.name}"
    else
      flash.now[:alert] = "No se ha podido enviar la petición a #{creator.name}"
    end
  end

  def new
    # Obtenemos el evento y el participante a través de los parámetros
    event = Event.find event_participants_params[:event_id]
    participant = User.find event_participants_params[:participant_id]

    # Definimos el título del modal
    @title = "Incorporar participante"

    # Definimos el mensaje del modal
    @message = "Está a punto de aceptar la petición de <b>#{participant.name}</b> para participar en su evento <b>#{event.name}</b>."
    @message += "<br><br>¿Desea continuar?"

    # Definimos el Miembro con el grupo y el músico para el formulario
    @event_participant = EventParticipant.new(event_id: event.id, participant_id: participant.id)
  end

  def create
    debugger
    @event_participant = EventParticipant.new(event_participants_params)

    # Persistimos el participante en la BD, si no mostramos una alerta
    if @event_participant.save
      # Definimos el creador del evento
      participant =  @event_participant.participant

      # Borramos todos los mensajes de petición de membresía para esta relación
      event = @event_participant.event
      conversations = event.conversations.add_participant_conversation(current_user, participant)
      conversations.destroy_all

      redirect_to root_path, notice: "#{participant.name} añadido al evento #{event.name}"
    else
      error_msg = ""
      @event_participant.errors.full_messages.each do |msg|
        error_msg = error_msg + "<p>#{msg}</p>"
      end

      redirect_to :back, alert: "#{error_msg}"
    end
  end

  def destroy_view
    # Comprobamos que se hay coherencia en los datos y que se tienen los privilegios para realizar la acción
    participant = User.find params[:id]
    event = Event.find params[:event_id]
    @event_participant = EventParticipant.where(event_id: event.id, participant_id: participant.id).first
    creator = event.creator

    if current_user != creator && current_user != participant
      redirect_to :back, alert: 'No tiene privilegios para acceder a la página'
    end

    # Definimos los datos para la vista
    @title = "Eliminar participante"

    @message = if creator == current_user
      "Está a punto de eliminar a <strong>#{participant.name}</strong> del evento."
    else
      "Está a punto de dejar de participar en el evento."
    end
    @message += "<br><br>¿Desea continuar?"
  end

  def destroy
    @event_participant = EventParticipant.find params[:id]
    event = @event_participant.event
    @event_participant.destroy

    send_message = SendRemoveParticipantMessage.new(@event_participant, current_user)
    if send_message.do
      send_message.relate_to_event
      redirect_to event_path(user_id: event.creator_id, id: event.id), notice: "Eliminada la participación del evento"
    else
      redirect_to :back, alert: 'No se ha podido procesar la petición debido a un error'
    end
  end

  private
    # Comprueba y actúa en relación a si puede participar
    def check_participants_avaliable
      redirect_to :back, alert: 'Ya se ha llegado al máximo de participantes posibles para el evento' unless can_participate?
    end

    # Indica si se puede participar
    def can_participate?
      event = if params[:event_id]
        Event.find params[:event_id]
      else
        Event.find event_participants_params[:event_id]
      end

      return event.max_participants > event.participants.size
    end

    def event_participants_params
      params.require(:event_participant).permit(:event_id, :participant_id)
    end
end
