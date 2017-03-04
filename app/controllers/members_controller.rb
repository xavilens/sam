class MembersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @members = Member.all

    @page = 'Miembros'
  end

  def show
    @member = Member.find(params[:id])

    user = @member.user(current_user)

    @title = "Actualizar miembro"
    @message = ""

    @page = 'Miembros'
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
      "Está a punto de enviar una petición a #{to_user.name} para que se una a su grupo.<br><br>¿Desea continuar?"
    else
      "Está a punto de enviar una petición a #{to_user.name} para unirse a su grupo.<br><br>¿Desea continuar?"
    end

    @member = Member.new(band: band, musician: musician)
    @member.member_instruments.build

    respond_to do |format|
      format.js
    end
  end

  # Envia un mensaje con petición de membresía
  def send_request_message
    band = Band.find member_params[:band_id]
    musician = Musician.find member_params[:musician_id]

    user = current_user.musician? ? band.user : musician.user

    # Si es valido lo guarda y envía un mensaje de noticia, si no envía uno de advertencia
    if SendMembership.new(current_user, user).do
      flash.now[:notice] = "Petición enviada a #{user.name}"
    else
      flash.now[:alert] = "No se ha podido enviar la petición a #{user.name}"
    end
  end

  def new
    band = Band.find params[:band_id]
    musician = Musician.find params[:musician_id]
    from_user = current_user.band? ? musician.user : band.user

    @title = if from_user.band?
      "Incorporarse al grupo #{from_user.name}"
    else
      "Incorporar a #{from_user.name} al grupo"
    end

    @message = "Está a punto de aceptar la petición de <b>#{from_user.name}</b> para unirse a su grupo."
    @message += "<br><br>¿Está seguro de querer continuar?"

    @member = Member.new(band_id: band.id, musician_id: musician.id)
  end

  def create
    @member = Member.new(member_params)

    if @member.save
      debugger
      other_user =  @member.user current_user
      # Borramos todos los mensajes de petición de membresía para esta relación
      Conversation.add_member_conversation(current_user.id, other_user.id).destroy_all

      flash.now[:notice] ||= "Miembro añadido"

      respond_to do |format|
        format.js { redirect_to user_path(current_user) }
      end
    else
      flash.now[:alert] ||= "No se ha podido procesar la petición debido a un error"
    end

  end

  def edit
    @member = Member.find(params[:id])

    user = @member.user(current_user)

    @title = "Actualizar miembro"
    @message = ""

    @page = 'Miembros'
  end

  # Controlador para la vista de eliminación de un miembro
  def delete
    # Si tenemos parametro de member_id lo hace el usuario desde su página,
    # si no lo hace desde la pagina del otro usuario implicado
    if params[:member_id]
      debugger
      @member = Member.find(params[:member_id])
      delete_member_user = @member.user current_user

      # member_array = if current_user.band?
      #   Member.find(band: current_user.profile, musician: delete_member_user.id)
      # else
      #   Member.find(musician: current_user.profile, band: delete_member_user.id)
      # end

      @title = "Eliminar #{delete_member_user.name}"
      @message = "¿Desea eliminar a #{delete_member_user.name} del grupo?"
    else
      delete_member_user = User.find(params[:user_id])

      @member = if current_user.band?
        Member.get(current_user.profile, delete_member_user.profile)
      else
        Member.get(delete_member_user.profile, current_user.profile)
      end

      @title = "Expulsar a #{delete_member_user.name}"
      @message = "Si expulsa ahora a <b>#{delete_member_user.name}</b> del grupo no podrá deshacer esta acción.<br/><br/>"
      @message += "¿De verdad desea expulsar a #{delete_member_user.name} del grupo?"
    end
  end

  def update
    debugger
    if params[:type] == 'delete'
      delete_member
    end
  end

  def delete_member
    debugger
    @member = Member.find(member_params[:id])
    member_user = @member.user current_user
    @member.destroy

    if @member.persisted?
      flash.now[:alert] = "No se ha podido eliminar a #{member_user.name}"
    else
      flash.now[:success] = "#{member_user.name} eliminado"
    end
  end

  private
    def member_params
      params.require(:member).permit(:id, :band_id, :musician_id,
        member_instruments_attributes: [:id, :member_id, :instrument_id])
    end
end
