class Conversation < ActiveRecord::Base
  # VALIDACIONES
  validates :user_1, presence: true
  validates :user_2, presence: true
  validates :subject, presence: true

  # SCOPES
  scope :my_conversations, -> (user_id){ where("user_1_id = :user_id OR user_2_id = :user_id", user_id: user_id) }

  # RELACIONES
  has_many :messages, dependent: :destroy
  accepts_nested_attributes_for :messages

  belongs_to :user_1, class_name: 'User', primary_key: 'id', foreign_key: 'user_1_id'
  belongs_to :user_2, class_name: 'User', primary_key: 'id', foreign_key: 'user_2_id'

  #SQL "select count(1) from conversations c, messages m where c.id = m.conversation_id and (c.user_1_id = :user_id or user_2_id = :user_id) and m.author_id = :recipent_id and m.false group by c.id"

  # METHODS

  # Indica si hay mensajes sin leer
  def unread? user_id
    !unread(user_id).blank?
  end

  # Devuelve los mensajes no leidos
  def unread_messages user_id
    messages.recipent_messages(user_id).unread
  end

  # Devuelve los mensajes no leidos
  def self.unread_conversations user_id

    # sql = "select count(1) "
    # sql += "from conversations c, messages m "
    # sql += "from conversations c, messages m "
    # sql += "where c.id = m.conversation_id "
    # sql += "and (c.user_1_id = "+user_id+" or user_2_id = "+user_id+") "
    # sql += "and m.author_id != "+user_id+" and m.read = false "
    # sql += "group by c.id"

    #SQL "select count(1) from conversations c, messages m where c.id = m.conversation_id and (c.user_1_id = :user_id or user_2_id = :user_id) and m.author_id = :recipent_id and m.read = false group by c.id"
    convs = Conversation.my_conversations(6).joins(:messages).where("messages.author_id != :user_id", user_id: user_id).where("messages.read= false").group("conversations.id")

    convs.count
  end

  # Marca los mensajes como leidos
  def read user_id
    messages.recipent_messages(user_id).unread.each do |m|
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

    UserPresenter.new(recipent)
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
