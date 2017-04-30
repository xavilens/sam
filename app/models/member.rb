class Member < ActiveRecord::Base
  ######## VALIDATIONS
  validates :band_id, presence: true
  validates :musician_id, presence: true, uniqueness: {scope: :band_id}

  ######## SCOPES
  # Devuelve aquellos mensajes enviados por el otro usuario de la conversación
  scope :get_member, -> (band_id, musician_id){ where(band_id: band_id, musician_id: musician_id) }

  ######## RELATIONSHIPS
  belongs_to :band
  belongs_to :musician

  has_many :member_instruments, dependent: :destroy
  accepts_nested_attributes_for :member_instruments, allow_destroy: true, reject_if: :all_blank
  has_many :instruments, through: :member_instruments

  ######## METHODS
  # Devuelve el usuario cuyo perfil sea el contrario al actual
  def user current_user
    user_aux = current_user.musician? ? band.user : musician.user
    
    return user_aux.decorate
  end

  def self.get band_id, musician_id
    get_member(band_id, musician_id).first
  end

  def name
    musician.user.name
  end

  def band_name
    band.user.name
  end

end
