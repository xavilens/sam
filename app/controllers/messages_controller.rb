class MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :redirect_cancel, only: [:create]
  before_action :set_current_user
  before_action :set_users_new, only: [:new]
  before_action :set_users_create, only: [:create]

  # Breadcrumbs generales
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

    @conversation = current_user.conversations.build(user_2: to_user)
    @conversation.messages.build(author: current_user)

    # Damos nombre a la página
    @page = 'Enviar mensaje'
  end

  def create
    @conversation = Conversation.new(create_params)

    if @conversation.save
      redirect_to @recipent, notice: 'Mensaje enviado correctamente.'
    else
      render action: :new
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

    # Definimos usuarios para acción create
    def set_users_create
      set_recipent User.find(create_params[:user_2_id])
      set_sender
    end

    # Define usuarios para acción new
    def set_users_new
      set_recipent User.find(new_params[:to_user])
      set_sender
    end

    # Define la variable @sender
    def set_sender
      @sender = current_user
    end

    # Define la variable @sender
    def set_recipent to_user
      @recipent = UserPresenter.new(to_user)
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
      params.permit(:id, :to_user)
    end

    # Define los Strong Parameters al crear una nuevo conversación
    def create_params
      allow = [ :user_1_id, :user_2_id, :subject, :commit,
        messages_attributes: [:author_id, :body, :conversation_id]]

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
