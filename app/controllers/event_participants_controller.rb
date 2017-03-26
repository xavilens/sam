class EventParticipantsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :js

  def new
    # Obtenemos el evento y el participante a través de los parámetros
    event = Event.find params[:event_id]
    participant = User.find params[:participant_id]

    # Definimos el título del modal
    @title = "Incorporar a #{participant.name} al evento '#{event.name}'"

    # Definimos el mensaje del modal
    @message = "Está a punto de aceptar la petición de <b>#{participant.name}</b> para participar en su evento <b>#{event.name}</b>."
    @message += "<br><br>¿Desea continuar?"

    # Definimos el Miembro con el grupo y el músico para el formulario
    @event_participant = EventParticipant.new(event_id: event.id, participant_id: participant.id)
  end

  def create
    debugger
    @event_participant = EventParticipant.new(event_participants_param)

    # Persistimos el participante en la BD, si no mostramos una alerta
    if @event_participant.save
      # Definimos el otro usuario implicado en el miembro
      # Si el usuario es grupo el otro será el músico y viceversa
      other_user =  @member.user current_user

      # Borramos todos los mensajes de petición de membresía para esta relación
      Conversation.add_participant_conversation(current_user.id, other_user.id).destroy_all

      # Definimos una alerta de éxito
      flash.now[:notice] ||= "Miembro añadido"

      redirect_to root_path
    else
      flash.now[:alert] ||= "No se ha podido procesar la petición debido a un error"
      redirect_to :back
    end
  end

  def show
    debugger
  end

  def destroy
  end

  def participant_request
    # Definimos el creador
    event = Event.find(params[:event_id])
    creator = event.creator

    # Definimos el título del modal y el mensaje que mostraremos
    @title = "¿Deseas participar en el evento?"

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
    if SendAddParticipantMessage.new(event, creator, current_user).do
      flash.now[:notice] = "Petición enviada a #{creator.name}"
    else
      flash.now[:alert] = "No se ha podido enviar la petición a #{creator.name}"
    end
  end

  private

    def event_participants_params
      params.require(:event_participant).permit(:event_id, :participant_id)
    end
end
