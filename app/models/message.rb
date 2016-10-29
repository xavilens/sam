class Message < ActiveRecord::Base
  ######## VALIDACIONES
  validates :conversation_id, presence: true
  validates :author_id, presence: true
  validates :body, presence: true

  ######## SCOPES
  # Devuelve aquellos mensajes enviados por el otro usuario de la conversación
  scope :recipent_messages, -> (user_id){ where("author_id != :user_id", user_id: user_id) }

  # Devuelve aquellos mensajes enviados por el usuario
  scope :my_messages, -> (user_id){ where(author_id: user_id) }

  # Devuelve aquellos mensajes que aun no han sido leídos
  scope :unread, -> { where(read: false) }

  # Devuelve los mensajes ordenados de manera descendiente
  scope :desc, -> { order(id: :desc) }

  ######## RELATIONSHIPS
  belongs_to :conversation
  belongs_to :author, class_name: 'User', primary_key: 'id', foreign_key: 'author_id'

  ######## METHODS
  # Indica si se ha leido el mensaje
  def read?
    read
  end

end
