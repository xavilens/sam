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
    
  end

  # Pantalla para mandar el mensaje con petición de membresía
  def send_request
    from_user = User.find(params[:from_user])
    if from_user.band?
      band = from_user.profile
      musician = User.find(params[:user_id]).profile
    else
      musician = from_user.profile
      band = User.find(params[:user_id]).profile
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
    if SendMembership.new(current_user, user, instrument).do
      flash[:notice] = "Petición enviada a #{user.name}"
    else
      flash[:advert] = "No se ha podido enviar la petición a #{user.name}"
    end

    redirect_to user_path(user)
  end

  def create

  end

  def update

  end

  def add
    redirect_to :back, notice: 'Prueba'
  end

  private
    def create_params

    end

    def update_params

    end
end
