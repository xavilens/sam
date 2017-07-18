class MessagesController < ApplicationController
  ######### FILTERS
  before_filter :authenticate_user!

  ######### CALLBACKS
  before_action :set_current_user
  before_action :set_users_new, only: [:new]
  before_action :set_users_create, only: [:create]

  before_action :set_boxes_variables, only: [:index, :inbox, :outbox, :memberships, :participants, :search]

  ######### DECORATORS
  decorates_assigned :conversations, :conversation, :messages, :user, :sender, :recipent

  ######### ACTIONS
  def index
    @conversations = Conversation.inbox(current_user.id).search(@search)
    @page ||= 'Mensajes'
    set_conversations
  end

  def inbox
    @page = 'Mensajes recibidos'
    index
  end

  def outbox
    @conversations = Conversation.outbox(current_user.id).search(@search)
    @page = 'Mensajes enviados'
    set_conversations
  end

  def memberships
    @conversations = Conversation.membership(current_user.id).search(@search)
    @page = 'Mensajes de miembros'
    set_conversations
  end

  def participants
    @conversations = Conversation.participants(current_user.id).search(@search)
    @page = 'Mensajes de eventos'
    set_conversations
  end

  def search
    @conversations = Conversation.global_search(current_user.id, @search)
    @page = 'Mensajes encontrados'
    set_conversations
  end

  def new
    # Definimos los usuarios participantes y creamos la conversacion y un mensaje en él
    to_user = User.find(new_params[:to_user])

    @conversation = if params[:subject].present?
      current_user.conversations.build(user_2: to_user, subject: params[:subject])
    else
      current_user.conversations.build(user_2: to_user)
    end

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

    # Define las variables necesarias para los buzones de mensajes
    def set_boxes_variables
      @show = index_params[:show]
      @order = index_params[:order] || 'desc'
      @search = params[:messages].present? ? search_params[:body] : ""
    end

    # Prepara las conversaciones para ser mostradas y se asegura de renderizar el index
    def set_conversations
      @conversations = @conversations.send(@order) unless @conversations.blank?
      @conversations = @conversations.page(params[:page]).per(15)

      render :index
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
