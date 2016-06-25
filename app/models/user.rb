class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # TODO: Campos Youtube?, Soundcloud?, Facebook?, Twitter?, Bandcamp?, Página web?

  ################### VALIDACIONES ###################
  validates :name, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates :role_id, presence: true
  validates :profileable_id, presence: true
  validates :profileable_type, presence: true, uniqueness: {scope: :profileable_id}

  ################### RELACIONES ###################

  # USER RELATED
  belongs_to :role
  belongs_to :userable, polymorphic: true

  # CONVERSATIONS RELATED
  # TODO: Soft-delete?? Borrar/ocultar solo si no quedan usuarios!!
  has_many :conversations, foreign_key: :user_1_id
  has_many :messages, through: :conversations
  has_many :reverse_conversations, foreign_key: :user_2_id, class_name: 'Conversation'
  has_many :messages, through: :reverse_conversations

  # POSTS RELATED
  has_many :posts
  has_many :comments

  # DELEGATED USER RELATED
  has_many :delegated_users, dependent: :destroy

  # EVENTS RELATED
  has_many :events
  has_many :event_participants

  # ACTIVITY FEED RELATED
  has_many :activities

  # FOLLOWSHIPS RELATED
  has_many :followships, foreign_key: :follower_id, dependent: :destroy
  has_many :leaders, through: :followships
  has_many :reverse_followships, foreign_key: :leader_id, class_name: 'Followship', dependent: :destroy
  has_many :followers, through: :reverse_followships

  # SALAS RELATED
  has_many :created_salas, class_name: 'Sala'
  has_many :sala_reviews
  has_many :sala_users
  has_many :salas, through: :sala_users

  # REHEARSAL STUDIOS RELATED
  has_many :rehearsal_studio_reviews
  has_many :rehearsal_studio_users
  has_many :rehearsal_studios, through: :rehearsal_studio_users

  ################### ACCIONES ###################
  before_create :set_default

  ################### METODOS ###################
  def esMusico?
    return self.profileable_type == 'Musician'
  end

  def esGrupo?
    return self.profileable_type == 'Band'
  end

  def tipo
    return self.profileable_type
  end

  def perfil
    if esMusico?
      return Musician.find(profileable_id)
    else
      return Band.find(profileable_id)
    end
  end

  def following?(leader)
    leaders.include? leader
  end

  def follow!(leader)
    if leader != self && !following?(leader)
      leaders << leader
    end
  end

  def followed?(follower)
    followers.include? follower
  end

  def followed!(follower)
    if follower != self && !followed?(follower)
      followers << follower
    end
  end

  private
    def setDefault
      self.role_id = Role.find_by_name('registrado').id
    end

    def self.musicos
      return User.where(profileable_type: 'Musician')
    end
    def self.grupos
      return User.where(profileable_type: 'Band')
    end
end
