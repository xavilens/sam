class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  cattr_accessor :admin_id

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
  has_many :posts, dependent: :destroy
  # TODO: Soft-delete?
  has_many :comments, dependent: :destroy

  # DELEGATED USER RELATED
  has_many :delegated_users, dependent: :destroy

  # EVENTS RELATED
  has_many :events
  has_many :event_participants

  # ACTIVITY FEED RELATED
  has_many :activities, dependent: :destroy

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
  has_many :created_rehearsal_studio, class_name: 'RehearsalStudio'
  has_many :rehearsal_studio_reviews
  has_many :rehearsal_studio_users
  has_many :rehearsal_studios, through: :rehearsal_studio_users

  # AD RELATED
  has_many :ads


  ################### ACCIONES ###################

  before_create :set_default


  ################### METODOS ###################

  def es_musico?
    profileable_type == 'Musician'
  end

  def es_grupo?
    profileable_type == 'Band'
  end

  def tipo_perfil
    profileable_type
  end

  def perfil
    if es_musico?
      Musician.find(profileable_id)
    elsif es_grupo?
      Band.find(profileable_id)
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

  def is_admin?
    role_id == User.admin_id
  end

  def self.initialize_attributes!
    if User.admin_id.blank?
      User.admin_id = User.set_admin_id
    end
  end

  # PRIVATE METHODS

  private

  def setDefault
    self.role_id = Role.find_by_name('registrado').id
  end

  def self.set_admin_id
    Role.find_by_name('admin').id
  end
end
