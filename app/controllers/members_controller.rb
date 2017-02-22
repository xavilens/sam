class MembersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @members = Members.all

    @page = 'Miembros'
  end

  def show
    @members = Members.find(params[:id])

    @page = 'Miembros'
  end

  def new
    band = Band.find params[:band_id]
    musician = Musician.find params[:musician_id]
    instrument = Instrument.find params[:instrument_id]
    from_user = current_user.band? ? musician.user : band.user

    @title = if from_user.band?
      "Incorporarse al grupo #{from_user.name}"
    else
      "Incorporar a #{from_user.name} al grupo"
    end

    @message = "Está a punto de aceptar la petición de <b>#{from_user.name}</b> para "
    @message += "unirse a su grupo con el puesto <b>#{instrument.name}</b>. "
    @message += "<br><br>¿Está seguro de querer continuar?"

    @member = Member.new(band_id: band.id, musician_id: musician.id, instrument_id: instrument.id)
  end

  # Pantalla para mandar el mensaje con petición de membresía
  def send_request
    to_user = User.find(params[:user_id])
    from_user = current_user
    if from_user.band?
      band = from_user.profile
      musician = User.find(params[:user_id]).profile
    else
      musician = from_user.profile
      band = User.find(params[:user_id]).profile
    end

    @title = if current_user.band?
      "¿Deseas que #{to_user.name} forme parte del grupo?"
    else
      "¿Deseas formar parte de #{to_user.name}?"
    end

    @message = if from_user.band?
      "Está a punto de enviar una petición a #{to_user.name} para que se una a su grupo.<br><br>¿Qué puesto va a ocupar?"
    else
      "Está a punto de enviar una petición a #{to_user.name} para unirse a su grupo.<br><br>¿Qué puesto va a ocupar?"
    end

    @member = Member.new(band: band, musician: musician)

    respond_to do |format|
      format.js
    end
  end

  # Envia un mensaje con petición de membresía
  def send_request_message
    member = params[:member]
    band = Band.find member[:band_id]
    musician = Musician.find member[:musician_id]
    instrument = Instrument.find member[:instrument_id]

    user = current_user != band.user ? band.user : musician.user

    # Si es valido lo guarda y envía un mensaje de noticia, si no envía uno de advertencia
    @conv = SendMembership.new(current_user, user, instrument).do
    if @conv.save
      flash.now[:notice] = "Petición enviada a #{user.name}"
    else
      flash.now[:advert] = "No se ha podido enviar la petición a #{user.name}"
    end
  end

  def create
    @member = Member.new(member_params)

    if @member.save
      flash.now[:notice] = "Miembro añadido"
    else
      flash.now[:advert] = "No se ha podido procesar la petición debido a un error"
    end
  end

  def update

  end

  private
    def member_params
      params.require(:member).permit(:band_id, :musician_id, :instrument_id)
    end
end
