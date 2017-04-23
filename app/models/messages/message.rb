class Message < ActiveRecord::Base

  ######## VALIDACIONES
  validates :author_id, presence: true
  validates :body, presence: true

  ######## SCOPES
  # Devuelve aquellos mensajes enviados por el otro usuario de la conversación
  scope :recipent_messages, -> (user_id){ where("author_id != :user_id", user_id: user_id) }

  # Devuelve aquellos mensajes enviados por el usuario
  scope :my_messages, -> (user_id){ where(author_id: user_id) }

  # Devuelve aquellos mensajes que aun no han sido leídos
  scope :unread, -> (user_id){
    recipent_messages(user_id).where(read: false)
  }

  # Devuelve los mensajes ordenados de manera descendiente
  scope :desc, -> { order(id: :desc) }

  # Devolvemos los mensajes de un tipo determinado
  scope :regular, -> { where(type: nil) }
  scope :add_member, -> { where(type: 'AddMemberMessage') }
  scope :participant_related, -> { where(type: ['AddParticipantMessage', 'RemoveParticipantMessage']) }
  scope :add_participant, -> { where(type: 'AddParticipantMessage') }
  scope :remove_participant, -> { where(type: 'RemoveParticipantMessage') }

  ######## RELATIONSHIPS
  belongs_to :conversation
  belongs_to :author, class_name: 'User', primary_key: 'id', foreign_key: 'author_id'

  self.inheritance_column = :type

  def self.types
    %w(AddMemberMessage AddParticipantMessage RemoveParticipantMessage)
  end

  ######## METHODS
  # Indica si se ha leido el mensaje
  def read?
    read
  end

end
