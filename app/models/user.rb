class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  cattr_accessor :admin_id

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
  has_many :events, foreign_key: :creator_id, primary_key: :id
  has_many :event_participants, foreign_key: :participant
  has_many :reverse_events, through: :event_participants, source: :event

  # FOLLOWSHIPS RELATED
  has_many :followships, foreign_key: 'follower_id'
  has_many :leaders, through: :followships
  has_many :reverse_followships, foreign_key: :leader_id, class_name: 'Followship'
  has_many :followers, through: :reverse_followships

  # # AD RELATED
  # has_many :ads

  # # POSTS RELATED
  # has_many :posts
  # has_many :comments

  # # DELEGATED USER RELATED
  # has_many :delegated_users

  # # ACTIVITY FEED RELATED
  # has_many :activities

  # # SALAS RELATED
  # has_many :created_salas, class_name: 'Sala'
  # has_many :sala_reviews
  # has_many :sala_users
  # has_many :salas, through: :sala_users

  # # REHEARSAL STUDIOS RELATED
  # has_many :created_rehearsal_studio, class_name: 'RehearsalStudio'
  # has_many :rehearsal_studio_reviews
  # has_many :rehearsal_studio_users
  # has_many :rehearsal_studios, through: :rehearsal_studio_users

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

  # Indica si está asociado a algún evento
  def any_events?
    events? or reverse_events?
  end

  # Indica si tiene algún evento propio
  def events?
    events.any?
  end

  # Indica si tiene algún evento en calidad de participante
  def reverse_events?
    reverse_events.any?
  end

  # Indica si tiene algún evento en calidad de participante
  def member_events
    profileable.events if musician?
  end

  # Devuelve todos los eventos en los que participa, propio o de participante
  def all_events
    # (events.decorate + reverse_events.decorate).sort_by{ |event| event[:date] }
    # every_events = events.next_five + reverse_events.next_five + member_events.next_five
    every_events = events.decorate + reverse_events.decorate
    every_events += member_events.decorate if musician?

    # return every_events.sort_by!{|event| event.date}.first(5)
    return every_events
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

  # Indica si el usuario es Admin
  def is_admin?
    User.initialize_attributes!

    role_id == User.admin_id
  end

  def self.initialize_attributes!
    if User.admin_id.blank?
      User.admin_id = User.set_admin_id
    end
  end

  private

    # Define el rol por defecto del usuario como 'registrado'
    # ref: https://github.com/plataformatec/devise/wiki/How-To:-Add-a-default-role-to-a-User
    def set_default
      self.role_id |= Role.find_by_name('registrado').id if self.role_id.blank?
    end

    # Define el id del rol 'admin'
    def self.set_admin_id
      Role.find_by_name('admin').id
    end

    # Indica si se puede guardar la image o si se considera vacía
    def image_blank?(att)
      att[:title].blank? || att[:image].blank?
    end
end
