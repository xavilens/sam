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
  validates :profileable, presence: true
  validates :address, presence: true
  validate :non_repeated_profile
  validates :social_networks_set, presence: true

  ######## SCOPES
  # Devuelve los usuarios con perfil de Grupo (Band)
  scope :bands, -> {
    where(profileable_type: "Band").joins("INNER JOIN bands ON profileable_id = bands.id")
  }

  # Devuelve los usuarios grupos que tienen asociado alguno de los géneros pasados
  scope :genres, -> (genres) {
    where("bands.genre_1_id in (:genres) OR bands.genre_2_id in (:genres) OR bands.genre_3_id in (:genres)",
        genres: genres)
  }

  # Devuelve los usuarios grupos que tienen asociado alguno de los estados pasados
  scope :band_status, -> (statuses) {
    where("bands.band_status_id in (:statuses)", statuses: statuses)
  }

  # Devuelve los usuarios con perfil de Músico (Musician)
  scope :musicians, -> {
    where(profileable_type: "Musician").joins("INNER JOIN musicians ON profileable_id = musicians.id")
  }

  # Devuelve los usuarios músicos que tienen asociado alguno de los instrumentos pasados
  scope :instruments, -> (instruments) {
    joins("INNER JOIN musician_knowledges ON musician_knowledges.musician_id = musicians.id")
      .where("musician_knowledges.instrument_id in (:instruments)", instruments: instruments)
  }

  # Devuelve los usuarios músicos que tienen asociado alguno de los instrumentos pasados
  scope :musician_status, -> (statuses) {
    where("musicians.musician_status_id in (:statuses)", statuses: statuses)
  }

  # Muestra si el usuario está online
  # ref: http://stackoverflow.com/questions/5504130/whos-online-using-devise-in-rails
  scope :online, lambda{ where("updated_at > ?", 10.minutes.ago) }

  ######## UPLOADERS
  mount_uploader :avatar, AvatarUploader

  ######## RELATIONS

  # USER RELATED
  belongs_to :role
  belongs_to :profileable, polymorphic: true, dependent: :destroy
  accepts_nested_attributes_for :profileable, allow_destroy: true

  # ADDRESS RELATED
  has_one :address, as: :addresseable, dependent: :destroy
  accepts_nested_attributes_for :address, allow_destroy: true

  # SOCIAL NETWORK RELATED
  belongs_to :social_networks_set, dependent: :destroy
  accepts_nested_attributes_for :social_networks_set, allow_destroy: true

  # CONVERSATIONS RELATED
  has_many :conversations, foreign_key: :user_1_id, dependent: :destroy
  has_many :messages, through: :conversations
  accepts_nested_attributes_for :conversations, allow_destroy: true

  has_many :reverse_conversations, foreign_key: :user_2_id, class_name: 'Conversation', dependent: :destroy
  has_many :messages_inverse, through: :reverse_conversations
  accepts_nested_attributes_for :reverse_conversations, allow_destroy: true

  # IMAGE RELATED
  has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true,
    reject_if: proc { |att| att['title'].blank? || att['image'].blank? }

  # EVENTS RELATED
  has_many :created_events, foreign_key: :creator_id, primary_key: :id, class_name: 'Event', dependent: :destroy

  has_many :event_participants, foreign_key: :participant_id, dependent: :destroy
  has_many :participated_events, through: :event_participants, source: :event

  # FOLLOWSHIPS RELATED
  has_many :followships, -> {order(id: :desc)}, foreign_key: 'follower_id', dependent: :destroy
  has_many :leaders, through: :followships

  has_many :reverse_followships, -> {order(id: :desc)}, foreign_key: :leader_id, class_name: 'Followship', dependent: :destroy
  has_many :followers, through: :reverse_followships

  # MEDIA RELATED
  has_many :songs, dependent: :destroy
  has_many :profile_songs,-> {where(in_user_page: true)}, class_name: 'Song'

  has_many :videos, dependent: :destroy
  has_many :profile_videos,-> {where(in_user_page: true)}, class_name: 'Video'

  ######## PAGINATION
  paginates_per 48

  ######## METHODS
  ## USER DATA
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
    profileable
  end

  # Devuelve el estado
  def status
    profile.status
  end

  # Indica si tiene una Bio
  def bio?
    !bio.blank?
  end

  # Devuelve la longitud de la Bio
  def bio_size
    bio? ? bio.size : 0
  end

  # Indica si el usuario está online
  def online?
    updated_at > 10.minutes.ago
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

  ## SOCIAL NETWORKS
  # Indica si tiene redes sociales definidas
  def social_networks?
    social_networks_set.avaliables?
  end

  # Devuelve todas las redes sociales
  def social_networks
    social_networks_set.avaliables
  end

  ## MEMBERS
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

  ## INSTRUMENTS
  # Indica si tiene conocimiento en instrumentos
  def instruments?
    if musician?
      profile.instruments.any?
    elsif band?
      false
    end
  end

  ## MESSAGES
  # Devuelve todas las conversaciones en las que participa el usuario
  def conversations_all
    conversations + reverse_conversations
  end

  # Devuelve todas las conversaciones en las que interviene el usuario
  def my_conversations
    conversations + reverse_conversations
  end

  ## EVENTS
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
    every_events.uniq.sort_by! { |event| event.date }
    every_events.delete_if { |event| event.date < Date.today }
  end

  ## MEDIA
  # Indica si el usuario tiene canciones
  def images?
    images.any?
  end
  # Indica si el usuario tiene canciones
  def songs?
    songs.any?
  end

  # Indica si el usuario tiene canciones que mostrar en su pagina
  def profile_songs?
    profile_songs.any?
  end

  # Indica si el usuario tiene canciones
  def videos?
    videos.any?
  end

  # Indica si el usuario tiene canciones que mostrar en su pagina
  def profile_videos?
    profile_videos.any?
  end

  ## FOLLOWSHIPS
  # Indica si el usuario sigue al leader
  def following?(leader)
    leaders.include? leader
  end

  # Hace que el usuario siga al líder
  def follow!(leader)
    if leader != self && !following?(leader)
      leaders << leader
    end
  end

  # Indica si el usuario es seguido por el follower
  def followed?(follower)
    followers.include? follower
  end

  # Indica si el usuario sigue al leader
  def leaders?
    leaders.any?
  end

  # Indica si el usuario es seguido por el follower
  def followers?
    followers.any?
  end

  private

    # Inicializa las relaciones por defecto del usuario
    # ref: https://github.com/plataformatec/devise/wiki/How-To:-Add-a-default-role-to-a-User
    def set_default
      # Define el rol por defecto del usuario como 'registrado'
      self.role_id |= Role.find_by_name('registrado').id if self.role_id.blank?

      # Asocia un conjunto de redes sociales nuevo para el usuario
      self.social_networks_set = SocialNetworksSet.new

      # Asocia un perfil nuevo según la elección.
      # Si se modificó el valor del perfil escogido devolvemos un error
      case profileable_type
      when 'Band'
        self.profileable = Band.new
      when 'Musician'
        self.profileable = Musician.new
      else
        self.errors.add(:profileable_type, "El tipo de perfil escogido no existe")
      end
    end

    # Indica si se puede guardar la image o si se considera vacía
    def image_blank?(att)
      att[:title].blank? || att[:image].blank?
    end

    # Comprueba que el perfil no esté asociado a otro usuario
    def non_repeated_profile
      unless profileable_id.blank?
        # Buscamos los usuarios que tienen el mismo perfil y lo metemos en un array
        user_array = User.where(profileable_type: profileable_type, profileable_id: profileable_id).to_a

        # Si al borrar nuestro usuario del array sigue quedando más de un usuario es que ya está asociado
        user_array.delete(self)
        if user_array.size > 0
          errors.add(:profileable_type, "El perfil está asignado al usuario #{profileable.user.id}.")
        end
      end
    end
end
