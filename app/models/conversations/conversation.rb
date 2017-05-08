class Conversation < ActiveRecord::Base
  ######## VALIDACIONES
  validates :user_1, presence: true
  validates :user_2, presence: true
  validates :subject, presence: true

  ######## SCOPES
  ## BASIC
  # Devuelve aquellos mensajes que han sido enviado por el usuario
  scope :author, -> (user_id) {
    joins(:messages).where(messages: {author_id: user_id})
  }

  # Devuelve aquellos mensajes que no han sido enviado por el usuario
  scope :not_author, -> (user_id) {
    joins(:messages).where("messages.author_id != :author_id",author_id: user_id)
  }
  # Devuelve todas las conversaciones en las que participa el usuario
  scope :my_conversations, -> (user_id){
    where("user_1_id = :user_id OR user_2_id = :user_id", user_id: user_id)
  }

  # Devuelve los mensajes no leidos
  scope :unread, -> (user_id){
    joins(:messages).where("messages.author_id != :user_id and messages.read = false", user_id: user_id)
  }

  # Devuelve las conversaciones que tiene mensajes sin leer por el usuario
  # (aunque el otro usuario haya leído todos sus mensajes)
  # SQL "select count(1) from conversations c, messages m where c.id = m.conversation_id and (c.user_1_id = :user_id or user_2_id = :user_id) and m.author_id = :recipent_id and m.false group by c.id"
  # scope :unread_conversations, -> (user_id){
  #   my_conversations(user_id).joins(:messages).where("messages.author_id != :user_id and messages.read = false",
  #     user_id: user_id).distinct(:id)
  # }
  scope :unread_conversations, -> (user_id){
    my_conversations(user_id).unread(user_id).distinct(:id)
  }

  # Devuelve aquellos mensajes que no han sido enviado por el usuario
  scope :global_search, -> (user_id, text) {
    my_conversations(user_id).joins(:messages).where("body like :text or subject like :text",
      text: "%#{text}%").distinct(:id)
  }

  # Devuelve aquellos mensajes que no han sido enviado por el usuario
  scope :search, -> (text) {
    joins(:messages).where("body like :text or subject like :text", text: "%#{text}%").distinct(:id)
  }

  # Devuelve aquellas conversaciones entre dos usuarios
  scope :between, -> (user_1_id, user_2_id) {
    where("user_1_id in (:users) and user_2_id in (:users)", users: [user_1_id, user_2_id])
  }

  ## INBOX
  # Devuelve aquellas conversaciones con mensajes recibidos por el usuario (no los únicamente enviados)
  scope :inbox, -> (user_id) {
    my_conversations(user_id).regular.not_author(user_id).distinct(:id)
  }

  # Devuelve los mensajes recibidos no leidos
  scope :inbox_unread_count, -> (user_id) {
    inbox(user_id).unread(user_id).size
  }

  ## OUTBOX
  # Devuelve aquellas conversaciones con mensajes enviados por el usuario aun sin tener respuesta
  scope :outbox, -> (user_id) {
    my_conversations(user_id).regular.author(user_id).distinct(:id)
  }

  # Devuelve los mensajes enviados con respuestas no leidas
  scope :outbox_unread_count, -> (user_id) {
    outbox(user_id).unread(user_id).size
  }

  ## ADD MEMBER
  # Devuelve aquellas conversaionces con mensajes enviados por el usuario aun sin tener respuesta
  scope :membership, -> (user_id) {
    my_conversations(user_id).add_member.not_author(user_id).distinct(:id)
  }

  # Devuelve las peticiones de membresía no leídas
  scope :membership_unread_count, -> (user_id) {
    membership(user_id).unread(user_id).size
  }

  # Devuelve aquellos mensajes que sean peticiones de amistad
  # scope :add_member, -> { where(type: "AddMemberConversation") }

  # Devuelve aquellos mensajes que no han sido enviado por el usuario
  scope :add_member_conversation, -> (user_1_id, user_2_id) {
    add_member.between(user_1_id, user_2_id)
  }

  ## ADD PARTICIPANTS
  # Devuelve aquellas conversaciones referentes a peticiones de participación en eventos
  scope :participants, -> (user_id) {
    my_conversations(user_id).participant_related.not_author(user_id).distinct(:id)
  }

  # Devuelve las peticiones de membresía no leídas
  scope :participants_unread_count, -> (user_id) {
    participants(user_id).unread(user_id).size
  }

  # Devuelve aquellos mensajes que sean peticiones de participación en eventos
  # scope :participant_related, -> {
  #   joins(:messages).where(type: ['AddParticipantConversation','RemoveParticipantConversation'])
  # }

  # Devuelve aquellos mensajes que sean peticiones de participación en evento
  # scope :add_participant, -> { where(type: "AddParticipantConversation") }

  # Devuelve aquellos mensajes que sean peticiones de participación en evento
  scope :add_participant_conversation, -> (user_1_id, user_2_id) {
    add_participant.between(user_1_id, user_2_id)
  }

  # Devuelve aquellos mensajes que sean eliminaciones de participación en evento
  # scope :remove_participant, -> { where(type: "RemoveParticipantConversation") }

  # Devuelve aquellos mensajes que sean peticiones de participación en evento
  scope :remove_participant_conversation, -> (user_1_id, user_2_id) {
    remove_participant.between(user_1_id, user_2_id)
  }

  # Devuelve aquellos mensajes que no han sido enviado por el usuario
  scope :participant_related_conversations, -> (user_1_id, user_2_id) {
    participant_related.between(user_1_id, user_2_id: user_2_id)
  }

  ## TYPES
  # Devolvemos las conversaciones de un tipo determinado
  scope :regular, -> { where(type: nil) }
  scope :add_member, -> { where(type: 'AddMemberConversation') }
  scope :participant_related, -> { where(type: ['AddParticipantConversation', 'RemoveParticipantConversation']) }
  scope :add_participant, -> { where(type: 'AddParticipantConversation') }
  scope :remove_participant, -> { where(type: 'RemoveParticipantConversation') }

  ######## ORDER
  # Devuelve las conversaciones ordenadas de manera descendiente
  # scope :desc, -> { order(id: :desc) }
  scope :desc, -> { order(updated_at: :desc) }

  # Devuelve las conversaciones ordenadas de manera descendiente
  # scope :asc, -> { order(id: :asc) }
  scope :asc, -> { order(updated_at: :asc) }

  # Devuelve las conversaciones ordenadas de manera descendiente
  scope :subject_desc, -> { order(subject: :desc) }

  # Devuelve las conversaciones ordenadas de manera descendiente
  scope :subject_asc, -> { order(subject: :asc) }


  ######## RELACIONES
  has_many :messages, dependent: :destroy
  accepts_nested_attributes_for :messages

  has_one :conversation_related, dependent: :destroy
  has_one :event_related, through: :conversation_related, source: :conversationable, source_type: "Event"

  belongs_to :user_1, class_name: 'User', primary_key: 'id', foreign_key: 'user_1_id'
  belongs_to :user_2, class_name: 'User', primary_key: 'id', foreign_key: 'user_2_id'

  self.inheritance_column = :type
  def self.types
    %w(AddMemberConversation AddParticipantConversation RemoveParticipantConversation)
  end

  delegate :regular, to: :messages
  delegate :add_member, to: :messages
  delegate :add_participant, to: :messages
  delegate :remove_participant, to: :messages

  ######## METHODS
  # Indica si hay mensajes sin leer
  def unread? user_id
    !unread_messages(user_id).blank?
  end

  # Devuelve los mensajes no leidos
  def unread_messages user_id
    messages.unread(user_id)
  end

  # Indica si hay conversaciones no leidas
  def self.unread? user_id
    #SQL "select count(1) from conversations c, messages m where c.id = m.conversation_id and (c.user_1_id = :user_id or user_2_id = :user_id) and m.author_id = :recipent_id and m.read = false group by c.id"
    convs = Conversation.unread_conversations(user_id)
    convs.exists?
  end

  # Devuelve el número de conversaciones con mensajes no leidos
  def self.unread_count user_id
    #SQL "select count(1) from conversations c, messages m where c.id = m.conversation_id and (c.user_1_id = :user_id or user_2_id = :user_id) and m.author_id = :recipent_id and m.read = false group by c.id"
    convs = Conversation.unread_conversations(user_id)
    convs.size
  end

  # Marca los mensajes como leidos
  def read user_id
    messages.unread(user_id).each do |m|
      m.read = true
      m.save
    end
  end

  # Devuelve el usuario con el que se mantiene la conversacion
  def recipent sender_id
    if user_1_id == sender_id
      recipent = user_2
    else
      recipent = user_1
    end
  end

  # Devuelve el último mensaje
  def last_message
    messages.last
  end

  # Devuelve la hora del último mensaje
  def last_message_time
    messages.last.created_at.time
  end

  # Indica el número de mensajes de la conversacion
  def messages_count
    messages.count
  end
end
