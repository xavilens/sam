class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  cattr_accessor :admin_id

  # FILTROS
  before_validation :set_default, on: :create

  # VALIDACIONES
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates :role_id, presence: true
  validates :profileable_id, presence: true
  validates :profileable_type, presence: true, uniqueness: {scope: :profileable_id}

  # SCOPES
  scope :in_location, -> (location){ where("city like :city or state like :state",
    city: "%#{location}%", state: "%#{location}%") }
  scope :name_like, -> (name){ where("name like :name", name: "%#{name}%") }

  # UPLOADERS
  mount_uploader :avatar, AvatarUploader

  # RELACIONES

  # USER RELATED
  belongs_to :role
  belongs_to :profileable, polymorphic: true
  accepts_nested_attributes_for :profileable

  # CONVERSATIONS RELATED
  # TODO: Soft-delete?? Borrar/ocultar solo si no quedan usuarios!!
  has_many :conversations, foreign_key: :user_1_id
  has_many :messages, through: :conversations
  has_many :reverse_conversations, foreign_key: :user_2_id, class_name: 'Conversation'
  has_many :messages_inverse, through: :reverse_conversations

  # POSTS RELATED
  has_many :posts, dependent: :destroy
  # TODO: Soft-delete?
  has_many :comments, dependent: :destroy

  # DELEGATED USER RELATED
  has_many :delegated_users, dependent: :destroy

  # EVENTS RELATED
  has_many :events, foreign_key: :creator_id, primary_key: :id
  has_many :event_participants

  # ACTIVITY FEED RELATED
  has_many :activities, dependent: :destroy

  # FOLLOWSHIPS RELATED
  has_many :followships, foreign_key: 'follower_id', dependent: :destroy
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

  # IMAGE RELATED
  has_many :images, as: :imageable, dependent: :delete_all
  accepts_nested_attributes_for :images
  # has_one :image, as: :imageable, dependent: :delete
  # accepts_nested_attributes_for :image

  # SOCIAL NETWORK RELATED
  has_one :social_network, as: :socialeable
  accepts_nested_attributes_for :social_network

  # SOCIAL NETWORK RELATED
  has_one :address, as: :addresseable
  accepts_nested_attributes_for :address

  def musician?
    profileable_type == 'Musician'
  end

  def band?
    profileable_type == 'Band'
  end

  def type
    if musician?
      'Músico'
    elsif band?
      'Grupo'
    end
  end

  def profile
    self.profileable
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

  def is_admin?
    role_id == User.admin_id
  end

  def self.initialize_attributes!
    if User.admin_id.blank?
      User.admin_id = User.set_admin_id
    end
  end

  private

    def set_default
      self.role_id |= Role.find_by_name('registrado').id if self.role_id.blank?
    end

    def self.set_admin_id
      Role.find_by_name('admin').id
    end
end
