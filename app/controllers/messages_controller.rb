class MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :redirect_cancel, only: [:create]

  before_action :set_current_user
  before_action :set_users_new, only: [:new]
  before_action :set_users_create, only: [:create]

  def index
    # Obtenemos la bandeja de correo
    @show = index_params[:show]
    @order = index_params[:order] || 'desc'

    if params[:messages]
      @search = search_params[:body]
      @show = 'search'
    end

    # Si hay busqueda cargamos las conversaciones de la búsqueda, si no cargamos dependiendo la bandeja
    if @search
      # @conversations = Conversation.my_conversations(current_user.id).joins(:messages).where("messages.body like :text", text: "%#{@search}%").distinct(:id)
      @conversations = Conversation.search(current_user.id, @search)
      @page = 'Mensajes encontrados'
    else
      # Dependiendo de la bandeja de correo pasada por parámetros mostramos unos correos u otros
      if @show.blank? || @show == 'inbox'
        @conversations = Conversation.inbox(current_user.id)
        @page = 'Mensajes recibidos'
      elsif @show == 'outbox'
        @conversations = Conversation.outbox(current_user.id)
        @page = 'Mensajes enviados'
      elsif @show == 'membership'
        @conversations = Conversation.membership(current_user.id)
        @page = 'Mensajes de miembros'
      elsif @show == 'participants'
        @conversations = Conversation.participants(current_user.id)
        @page = 'Mensajes de eventos'
      elsif @show == 'search'
        @conversations = nil
        @page = 'Mensajes encontrados'
      end
    end

    @conversations = @conversations.send(@order) if (@order and @conversations)

    @conversations = ConversationDecorator.wrap(@conversations) if @conversations

    @page ||= 'Mensajes'
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
    @messages = MessageDecorator.wrap(@messages)

    # Marcamos la conversación como leída
    @conversation.read (@user.id)

    # Breadcrumb
    add_breadcrumb "#{@conversation.subject}", :message_path

    # Damos nombre a la página
    @page = "Mensajes"
  end

  # Al actualizar una conversación realmente lo que hacemos es mandar un mensaje
  def update
    @conversation = Conversation.find(params[:id])
    @message = @conversation.messages.build(new_message_params)

    if @message.save
      flash[:notice] = 'Mensaje enviado correctamente'
    else
      flash[:error] = 'No se ha podido enviar el mensaje'
    end

    redirect_to message_path(@conversation)
  end

  private
    ## SETTERS

    # Define la variable @user como el usuario actual
    def set_current_user
      @user = UserDecorator.new(current_user)
    end

    # Definimos usuarios para acción create
    def set_users_create
      set_sender_recipent User.find(create_params[:user_2_id])
    end

    # Define usuarios para acción new
    def set_users_new
      set_sender_recipent User.find(new_params[:to_user])
    end

    # Define usuarios para acción new
    def set_sender_recipent to_user
      set_recipent to_user
      set_sender
    end

    # Define la variable @sender
    def set_sender
      @sender = current_user
    end

    # Define la variable @sender
    def set_recipent to_user
      @recipent = UserDecorator.new(to_user)
    end

    ## ACTIONS

    # Realiza la redirección al presionar el botón de cancelar
    def redirect_cancel
      id = create_params[:user_2_id]
      redirect_to user_path(id) if params[:cancel]
    end

    ## STRONGS PARAMETERS

    # Define los Strong Parameters de index
    def index_params
      params.permit(:show, :order)
    end

    # Define los Strong Parameters de index
    def search_params
      params.require(:messages).permit(:body)
    end

    # Define los Strong Parameters para la vista de enviar un nuevo mensaje/conversación
    def new_params
      params.permit(:id, :to_user)
    end

    # Define los Strong Parameters al crear una nueva conversación
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

    # Define los Strong Parameters al actualizar una conversación
    def new_message_params
      allow = [ :author_id, :body ]

      params.require(:conversation).require(:message).permit(allow)
    end
end
