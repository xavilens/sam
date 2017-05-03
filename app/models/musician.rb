class Musician < ActiveRecord::Base
  ######## ACTIONS / FILTERS
  before_validation :set_default, on: :create

  ######## VALIDATIONS
  validates :musician_status_id, presence: true

  ######## RELATIONSHIPS
  has_one :user, as: :profileable, dependent: :destroy
  accepts_nested_attributes_for :user

  has_many :members, dependent: :destroy
  accepts_nested_attributes_for :members, allow_destroy: true

  has_many :bands, through: :members

  has_many :events, through: :bands, source: :events

  has_many :musician_knowledges, dependent: :destroy
  accepts_nested_attributes_for :musician_knowledges, allow_destroy: true, reject_if: :all_blank
  has_many :instruments, through: :musician_knowledges

  belongs_to :musician_status

  ######## METHODS
  # Indica si el músico es miembro del grupo 'band'
  def member?(band)
    bands.include? band
  end

  # Si no es miembro del grupo lo incluye a la lista de grupos en los que es miembro, si lo es lo elimina
  def member!(band)
    unless member?(band)
      bands << band
    else
      bands.destroy(band.id)
    end
  end

  # Devuelve el estado del músico
  def status
    musician_status.name
  end

  private
    # Establece el estado por defecto del músico
    def set_default
      self.musician_status_id = MusicianStatus.find_by_name('Activo').id if self.musician_status_id.blank?
    end
end
