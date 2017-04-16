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

  def new
    # Obtenemos el grupo y el músico a través de los parámetros
    band = Band.find params[:band_id]
    musician = Musician.find params[:musician_id]
    from_user = current_user.band? ? musician.user : band.user

    # Definimos el título del modal
    @title = if from_user.band?
      "Incorporarse al grupo #{from_user.name}"
    else
      "Incorporar a #{from_user.name} al grupo"
    end

    # Definimos el mensaje del modal
    @message = "Está a punto de aceptar la petición de <b>#{from_user.name}</b> para unirse a su grupo."
    @message += "<br><br>¿Está seguro de querer continuar?"

    # Definimos el Miembro con el grupo y el músico para el formulario
    @member = Member.new(band_id: band.id, musician_id: musician.id)
  end

  def create
    # Creamos el miembro con los parámetros
    @member = Member.new(member_params)

    # Persistimos el miembro en la BD, si no mostramos una alerta
    if @member.save
      # Definimos el otro usuario implicado en el miembro
      # Si el usuario es grupo el otro será el músico y viceversa
      other_user =  @member.user current_user

      # Borramos todos los mensajes de petición de membresía para esta relación
      Conversation.add_member_conversation(current_user.id, other_user.id).destroy_all

      # Definimos una alerta de éxito
      flash.now[:notice] ||= "Miembro añadido"
    else
      flash.now[:alert] ||= "No se ha podido procesar la petición debido a un error"
    end
  end

  def edit
    # Definimos el miembro y definimos el otro usuario implicado en la definición del miembro
    @member = Member.find(params[:id]).decorate
    @member_user = UserDecorator.new(@member.user(current_user))

    # Crea un nuevo member_instrument asociado al miembro
    @member.member_instruments.build

    # Definimos el título y el mensaje para el modal
    @title = "Actualizar miembro"
    @message = "¿Qué instrumentos toca <b>#{@member_user.name}</b>?"
  end

  def update
    @member = Member.find(member_update_params[:id])

    if @member.update(member_update_params)
      respond_to do |format|
        format.html { redirect_to :back, notice: "Miembro actualizado" }
        format.js { flash.now[:notice] = "Miembro actualizado" }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, alert: "No se ha podido actualizar al miembro." }
        format.js { flash.now[:alert] = "No se ha podido actualizar al miembro" }
      end
    end
  end

  def destroy
    # Borramos al miembro
    @member = Member.find(params[:id])
    member_user = @member.user current_user
    @member.destroy

    # Si aun persiste (sigue en BD) será un error y mostraremos una alerta, sino un mensaje de éxito
    if @member.persisted?
      flash[:alert] = "No se ha podido eliminar a #{member_user.name}"
    else
      flash[:notice] = "#{member_user.name} eliminado"
    end

    redirect_to :back
  end

  # Pantalla para mandar el mensaje con petición de membresía
  def send_request
    # Definimos quién es el grupo y quien el músico
    to_user = User.find(params[:user_id])
    from_user = current_user
    if from_user.band?
      band = from_user.profile
      musician = User.find(params[:user_id]).profile
    else
      musician = from_user.profile
      band = User.find(params[:user_id]).profile
    end

    # Definimos el título del modal y el mensaje que mostraremos
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

    # Creamos el miembro con el grupo y el músico para el formulario
    @member = Member.new(band: band, musician: musician)
  end

  # Envia un mensaje con petición de membresía
  def send_request_message
    # Definimos el grupo y el músico a partir de los parámetros, así como el otro usuario implicado
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

  # Controlador para la vista de eliminación de un miembro
  def delete_view
    # Si tenemos parametro de member_id lo hace el usuario desde su página,
    # si no lo hace desde la pagina del otro usuario implicado
    if params[:member_id]
      # Definimos el miembro y el otro usuario del miembro
      @member = Member.find(params[:member_id])
      user = @member.user current_user

      # Definimos el título y el mensaje para el modal
      @title = "Eliminar #{user.name}"
      @message = "¿Desea eliminar a #{user.name} del grupo?"
    else
      # Definimos al otro usuario
      user = User.find(params[:user_id])

      # Definimos el miembro a partir de los usuarios
      @member = if current_user.band?
        Member.get(current_user.profile, user.profile)
      else
        Member.get(user.profile, current_user.profile)
      end

      # Definimos el título y el mensaje
      @title = "Expulsar a #{user.name}"
      @message = "Si expulsa ahora a <b>#{user.name}</b> del grupo no podrá deshacer esta acción.<br/><br/>"
      @message += "¿De verdad desea expulsar a #{user.name} del grupo?"
    end
  end

  private
    def member_params
      params.require(:member).permit(:id, :band_id, :musician_id,
        member_instruments_attributes: [:id, :member_id, :instrument_id])
    end

    def member_update_params
      params.require(:member).permit(:id, member_instruments_attributes: [:id, :instrument_id, :_destroy])
    end
end
