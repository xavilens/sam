class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # CAMPOS: id, email, encrypted_password, nombre, ciudad, comunidad, pais,
  # profileable_id, profileable_type, role_id, created_at, updated_at

  # TODO: Campos Youtube?, Soundcloud?, Facebook?, Twitter?

  #CAMPOS DEVISE: reset_password_token, reset_password_sent_at,
  # remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at,
  # current_sign_in_ip, last_sign_in_ip

  ################### VALIDACIONES ###################
  validates :nombre, presence: true
  validates :ciudad, presence: true
  validates :comunidad, presence: true
  validates :pais, presence: true
  validates :role_id, presence: true
  validates :profileable_id, presence: true
  validates :profileable_type, presence: true, uniqueness: {scope: :profileable_id}

  ################### RELACIONES ###################
  belongs_to :role
  belongs_to :userable, polymorphic: true

  # TODO: Soft-delete?? Borrar/ocultar solo si no quedan usuarios!!
  has_many :conversations, dependent: :delete_all
  has_many :messages, through: :conversations

  has_many :posts
  has_many :comments

  has_many :delegated_users, dependent: :delete_all

  has_many :events
  has_many :event_participants

  has_many :activities

  # TODO: Arreglar Relacion (follows, followers)
  has_many :followships

  has_many :sala_reviews
  has_many :sala_users
  has_many :salas, through: :sala_users

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

  def follows
    follows = Followship.where(follower_id: :id)
    return follows
  end

  def followers
    followers = Followship.where(followed_id: :id)
    return followers
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
