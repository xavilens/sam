class MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :redirect_cancel, only: [:create]
  before_action :set_current_user

  add_breadcrumb "Inicio", :root_path
  add_breadcrumb "Mensajes", :messages_path

  def index
    # Obtenemos la bandeja de correo
    @show = index_params[:show]

    # Dependiendo de la bandeja de correo pasada por parámetros mostramos unos correos u otros
    if @show.blank? || @show == 'inbox'
      @conversations = Conversation.inbox(current_user.id)
    elsif @show == 'outbox'
      @conversations = Conversation.outbox(current_user.id)
    end

    @conversations = ConversationPresenter.wrap(@conversations)

    # Definimos el nombre de la página
    @page = 'Mensajes'
  end

  def new
    # Definimos los usuarios participantes y creamos la conversacion y un mensaje en él
    to_user = User.find(new_params[:to_user])
    @recipent = UserPresenter.new(to_user)
    @sender = current_user

    @conversation = current_user.conversations.build(user_2: to_user)
    @conversation.messages.build(author: current_user)

    # Damos nombre a la página
    @page = 'Enviar mensaje'
  end

  def create
    # Creamos la conversación
    conversation = Conversation.new(create_params)

    # Si la conversación es valida la guardamos, si no (o si hay  volvemos y mostramos los errores
    if conversation.valid?
      if conversation.save

        # Creamos los mensajes
        create_message_params.each do |message_params|
          author_id = message_params[1][:author_id]
          body = message_params[1][:body]

          # Si no se ha podido crear el mensaje se borra la conversación y se vuelve atrás
          # mostrando los errores
          message = conversation.messages.build(author_id: author_id, body: body)
          unless message.save
            conversation.delete
            redirect_to :back, error: conversation.errors
          end
        end

        # Si todo ha ido correctamente se vuelve al perfil con un mensaje
        redirect_to user_path(create_params[:user_2_id]), notice: 'Mensaje enviado correctamente.'
      else
        # Si no se ha podido crear la conversación se vuelve atrás y se muestran los errores
        redirect_to :back, error: conversation.errors
      end
    else
      # Si no se ha podido validar la conversación se vuelve atrás y se muestran los errores
      redirect_to :back, error: conversation.errors
    end
  end

  def show
    # Cargamos la conversación
    @conversation = Conversation.find(show_params[:id])

    # Cargamos los mensajes
    @messages = @conversation.messages.desc
    @messages = MessagePresenter.wrap(@messages)

    # Marcamos la conversación como leída
    @conversation.read (@user.id)

    # Breadcrumb
    add_breadcrumb "#{@conversation.subject}", :message_path

    # Damos nombre a la página
    @page = "Mensajes"
  end

  def send_message

  end

  private
    # Define la variable @user como el usuario actual
    def set_current_user
      @user = UserPresenter.new(current_user)
    end

    # Realiza la redirección al presionar el botón de cancelar
    def redirect_cancel
      id = create_params[:user_2_id]
      redirect_to user_path(id) if params[:cancel]
    end

    # Define los Strong Parameters de index
    def index_params
      params.permit(:show)
    end

    # Define los Strong Parameters para la vista de enviar un nuevo mensaje/conversación
    def new_params
      params.permit(:user_id, :id, :to_user)
    end

    # Define los Strong Parameters al crear una nuevo conversación
    def create_params
      allow = [ :user_1_id, :user_2_id, :subject, :commit]

      params.require(:conversation).permit(allow)
    end

    # Define los Strongs Parametes al crear un nuevo mensaje
    def create_message_params
      allow = [:author_id, :body]

      params.require(:conversation).require(:messages_attributes)
      # params.require(:conversation).require(:messages_attributes).permit(allow)
    end

    # Define los Strongs Parametes de la vista Show
    def show_params
      allow = [:id]

      params.permit(allow)
    end
end
