class MessagesController < ApplicationController
  ######### FILTERS
  before_filter :authenticate_user!

  ######### CALLBACKS
  before_action :set_current_user
  before_action :set_users_new, only: [:new]
  before_action :set_users_create, only: [:create]

  ######### DECORATORS
  decorates_assigned :conversations, :conversation, :messages, :user, :sender, :recipent

  ######### ACTIONS
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
      @conversations = Conversation.inbox(current_user.id).search(@search)
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
        @conversations = Conversation.none
        @page = 'Mensajes encontrados'
      end
    end

    @conversations = @conversations.send(@order) if (@order and @conversations)

    @conversations = @conversations.page(params[:page]).per(15)
    # @conversations = @conversations.page(params[:page]).per(15) if @conversations
    # @conversations = @conversations.page(params[:page]).per(15).decorate if @conversations

    @page ||= 'Mensajes'
  end

  def inbox
    # Obtenemos la bandeja de correo
    @show = index_params[:show]
    @order = index_params[:order] || 'desc'

    @search = params[:messages].present? ? search_params[:body] : ""

    @conversations = Conversation.inbox(current_user.id).search(@search)
    @page = 'Mensajes recibidos'

    @conversations = @conversations.send(@order) unless @conversations.blank?
    @conversations = @conversations.page(params[:page]).per(15)

    render :index
  end

  def outbox
    # Obtenemos la bandeja de correo
    @show = index_params[:show]
    @order = index_params[:order] || 'desc'

    @search = params[:messages].present? ? search_params[:body] : ""

    @conversations = Conversation.outbox(current_user.id).search(@search)
    @page = 'Mensajes enviados'

    @conversations = @conversations.send(@order) unless @conversations.blank?
    @conversations = @conversations.page(params[:page]).per(15)

    render :index
  end

  def memberships
    # Obtenemos la bandeja de correo
    @show = index_params[:show]
    @order = index_params[:order] || 'desc'

    @search = params[:messages].present? ? search_params[:body] : ""

    @conversations = Conversation.membership(current_user.id).search(@search)
    @page = 'Mensajes de miembros'

    @conversations = @conversations.send(@order) unless @conversations.blank?
    @conversations = @conversations.page(params[:page]).per(15)

    render :index
  end

  def participants
    # Obtenemos la bandeja de correo
    @show = index_params[:show]
    @order = index_params[:order] || 'desc'

    @search = params[:messages].present? ? search_params[:body] : ""

    @conversations = Conversation.participants(current_user.id).search(@search)
    @page = 'Mensajes de eventos'

    @conversations = @conversations.send(@order) unless @conversations.blank?
    @conversations = @conversations.page(params[:page]).per(15)

    render :index
  end

  def search
    # Obtenemos la bandeja de correo
    @show = index_params[:show]
    @order = index_params[:order] || 'desc'

    @search = params[:messages].present? ? search_params[:body] : ""

    @conversations = Conversation.global_search(current_user.id, @search).search(current_user.id, @search)
    @page = 'Mensajes encontrados'

    @conversations = @conversations.send(@order) if (@order and @conversations)

    @conversations = @conversations.page(params[:page]).per(15)

    render :index
  end

  def new
    # Definimos los usuarios participantes y creamos la conversacion y un mensaje en él
    to_user = User.find(new_params[:to_user])

    @conversation = current_user.conversations.build(user_2: to_user)
    @conversation.messages.build(author: current_user)

    set_new_page
  end

  def create
    @conversation = Conversation.new(create_params)

    respond_to do |format|
      if @conversation.save
        flash.now[:notice] = 'Mensaje enviado correctamente.'
        format.html { redirect_to @recipent }
        format.js
      else
        set_new_page
        format.html { render :new }
        format.js
      end
    end
  end

  def show
    # Cargamos la conversación
    @conversation = Conversation.find(params[:id])

    # Cargamos los mensajes
    @messages = @conversation.messages.desc.page(params[:page]).per(10)

    # Marcamos la conversación como leída
    @conversation.read @user.id

    # Damos nombre a la página
    @page = "Mensajes"
  end

  # Al actualizar una conversación realmente lo que hacemos es mandar un mensaje
  def update
    @conversation = Conversation.find(params[:id])
    # @message = @conversation.messages.build(new_message_params)
    @conversation.messages.build(new_message_params)
    @conversation.updated_at = Time.now

    # if @message.save
    if @conversation.save
      flash.now[:notice] = 'Mensaje enviado correctamente'
    else
      flash.now[:error] = 'No se ha podido enviar el mensaje'
    end

    redirect_to message_path(@conversation)
  end

  private
    ## SETTERS
    # Define la variable @user como el usuario actual
    def set_current_user
      @user = current_user
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
      @recipent = to_user
    end

    # Define el nombre de la página New
    def set_new_page
      @page = 'Enviar mensaje'
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
      allow = [ :user_1_id, :user_2_id, :subject,
        messages_attributes: [:author_id, :body, :conversation_id]]

      params.require(:conversation).permit(allow)
    end

    # Define los Strong Parameters al actualizar una conversación
    def new_message_params
      allow = [ :author_id, :body ]

      params.require(:conversation).require(:message).permit(allow)
    end
end
