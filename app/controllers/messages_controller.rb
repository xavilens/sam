class MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :redirect_cancel, only: [:create]
  before_action :set_current_user

  def index
    @page = 'Mensajes'

    @conversations = Conversation.my_conversations(current_user.id)
    @conversations = ConversationPresenter.wrap(@conversations)
  end

  def new
    # Definimos los usuarios participantes y creamos la conversacion
    to_user = User.find(new_params[:to_user])
    @conversation = current_user.conversations.build(user_2: to_user)
    @conversation.messages.build(author: current_user)

    @recipent = UserPresenter.new(to_user)
    @sender = current_user

    @page = 'Enviar mensaje'
  end

  def create
    # Creamos la conversación
    conversation = Conversation.new(create_params)

    # Si la conversación es valida la guardamos, si no (o si hay  volvemos y mostramos los errores
    if conversation.valid?
      if conversation.save

        # Creamos el mensaje, si no se puede guardar se borra la conversación
        create_message_params.each do |message_params|
          author_id = message_params[1][:author_id]
          body = message_params[1][:body]

          message = conversation.messages.build()
          message.author_id = author_id
          message.body = body
          unless message.save
            conversation.delete
            redirect_to :back, error: conversation.errors
          end
        end

        redirect_to user_path(create_params[:user_2_id]), notice: 'Mensaje enviado correctamente.'
      else
        redirect_to :back, error: conversation.errors
      end
    else
      redirect_to :back, error: conversation.errors
    end
  end

  def show
    @conversation = Conversation.find(show_params[:id])
    @messages = @conversation.messages.desc

    @conversation.read (@user.id)
  end

  def send_message

  end

  private
    def set_current_user
      @user = UserPresenter.new(current_user)
    end

    def redirect_cancel
      id = create_params[:user_2_id]
      redirect_to user_path(id) if params[:cancel]
    end

    def index_params
      params.permit()
    end

    def new_params
      params.permit(:user_id, :id, :to_user)
    end

    def create_params
      allow = [ :user_1_id, :user_2_id, :subject, :commit]

      params.require(:conversation).permit(allow)
    end

    def create_message_params
      allow = [:author_id, :body]

      params.require(:conversation).require(:messages_attributes)
      # params.require(:conversation).require(:messages_attributes).permit(allow)
    end

    def show_params
      allow = [:id]

      params.permit(allow)
    end
end
