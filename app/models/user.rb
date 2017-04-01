class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ######## FILTROS
  # Ejecuta el método set-deault antes de efectuar las validaciones
  # ref: https://github.com/plataformatec/devise/wiki/How-To:-Add-a-default-role-to-a-User
  before_validation :set_default, on: :create

  ######## VALIDACIONES
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :role_id, presence: true
  validates :profileable_id, presence: true
  validates :profileable_type, presence: true, uniqueness: {scope: :profileable_id}
  validates :social_networks_set_id, presence: true

  ######## SCOPES
  # Muestra si el usuario está online
  # ref: http://stackoverflow.com/questions/5504130/whos-online-using-devise-in-rails
  scope :online, lambda{ where("updated_at > ?", 10.minutes.ago) }

  # Busca los usuarios con nombre parecido
  scope :name_like, -> (name){ where("name like :name", name: "%#{name}%") }

  ######## UPLOADERS
  mount_uploader :avatar, AvatarUploader

  ######## RELATIONS

  # USER RELATED
  belongs_to :role
  belongs_to :profileable, polymorphic: true
  accepts_nested_attributes_for :profileable, allow_destroy: true

  # ADDRESS RELATED
  has_one :address, as: :addresseable
  accepts_nested_attributes_for :address, allow_destroy: true

  # SOCIAL NETWORK RELATED
  belongs_to :social_networks_set
  accepts_nested_attributes_for :social_networks_set, allow_destroy: true

  # CONVERSATIONS RELATED
  # TODO: Soft-delete?? Borrar/ocultar solo si no quedan usuarios!!
  has_many :conversations, foreign_key: :user_1_id
  has_many :messages, through: :conversations
  has_many :reverse_conversations, foreign_key: :user_2_id, class_name: 'Conversation'
  has_many :messages_inverse, through: :reverse_conversations

  # IMAGE RELATED
  has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true,
    reject_if: proc { |att| att['title'].blank? || att['image'].blank? }

  # EVENTS RELATED
  # has_many :events, foreign_key: :creator_id, primary_key: :id
  has_many :created_events, foreign_key: :creator_id, primary_key: :id, class_name: 'Event'
  has_many :event_participants, foreign_key: :participant_id
  has_many :participated_events, through: :event_participants, source: :event

  # FOLLOWSHIPS RELATED
  has_many :followships, foreign_key: 'follower_id'
  has_many :leaders, through: :followships
  has_many :reverse_followships, foreign_key: :leader_id, class_name: 'Followship'
  has_many :followers, through: :reverse_followships


  ######## METHODS

  # Indica si el usuario es uno mismo
  def current_user?
    id == current_user.id
  end

  # Indica si el perfil es de Musician
  def musician?
    profileable_type == 'Musician'
  end

  # Indica si el perfil es de Musician
  def band?
    profileable_type == 'Band'
  end

  # Devuelve el perfil
  def profile
    self.profileable
  end

  # Devuelve el estado
  def status
    self.profileable.status
  end

  # Indica si posee alguna relacion de Member
  def memberships?
    if musician?
      profile.members.any?
    elsif band?
      profile.members.any?
    end
  end

  # Devuelve aquellos registros en los que el usuario conste como grupo o como músico del que no haya sido expulsado
  def members
    profile.members
  end

  # Indica si el usuario pasado es miembro del grupo del usuario o viceversa
  def member? user
    if band? && user.musician?
      profile.member? user
    elsif musician? && user.band?
      user.profile.member? self
    else
      false
    end
  end

  # Indica si tiene conocimiento en instrumentos
  def instruments?
    if musician?
      profile.instruments.any?
    elsif band?
      false
    end
  end

  # Indica si tiene una Bio
  def bio?
    !bio.blank?
  end

  # Devuelve la longitud de la Bio
  def bio_size
    bio? ? bio.size : 0
  end

  # Indica si tiene redes sociales definidas
  def social_networks?
    !social_networks_set.blank?
  end

  # Devuelve todas las redes sociales
  def social_networks
    social_networks_set.avaliables
  end

  # Devuelve todas las conversaciones en las que interviene el usuario
  def my_conversations
    conversations + reverse_conversations
  end

  # Indica si tiene algún evento propio
  def events?
    !events.empty?
  end

  # Indica si tiene algún evento en calidad de participante
  def participated_events?
    participated_events.any?
  end

  # Indica si tiene algún evento en calidad de participante
  def member_events
    profileable.events if musician?
  end

  # Devuelve todos los eventos en los que participa, propio o de participante
  def events
    # Obtenemos todos los eventos
    every_events = created_events.asc.decorate + participated_events.asc.decorate
    every_events += member_events.asc.decorate if musician?

    # Ordenamos los eventos
    return every_events.sort_by! { |event| event.date }
  end

  # Indica si el usuario sigue al leader
  def following?(leader)
    leaders.include? leader
  end

  # Indica si el usuario sigue al leader
  def follow!(leader)
    if leader != self && !following?(leader)
      leaders << leader
    end
  end

  # Indica si el usuario es seguido por el follower
  def followed?(follower)
    followers.include? follower
  end

  # Indica si el usuario está online
  def online?
    updated_at > 10.minutes.ago
  end

  # Devuelve todas las conversaciones en las que participa el usuario
  def conversations_all
    conversations + reverse_conversations
  end

  # Indica el tipo de perfil en Español
  def type
    if musician?
      'Músico'
    elsif band?
      'Grupo'
    end
  end

  # Indica si es administrador
  def is_admin?
    role.name.downcase == 'admin'
  end

  private

    # Define el rol por defecto del usuario como 'registrado'
    # ref: https://github.com/plataformatec/devise/wiki/How-To:-Add-a-default-role-to-a-User
    def set_default
      self.role_id |= Role.find_by_name('registrado').id if self.role_id.blank?
    end

    # Indica si se puede guardar la image o si se considera vacía
    def image_blank?(att)
      att[:title].blank? || att[:image].blank?
    end
end
