class Musician < ActiveRecord::Base
  ######## ACTIONS / FILTERS
  before_validation :set_default, on: :create

  ######## VALIDATIONS
  validates :musician_status_id, presence: true

  ######## RELATIONSHIPS
  has_one :user, as: :profileable, dependent: :destroy

  # TODO: Soft-delete?? Historial de grupos??
  has_many :members, dependent: :delete_all
  has_many :bands, through: :members
  has_many :musician_knowledges, dependent: :delete_all
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

  # Indica si el instrumento está ya incluido
  def instrument?(instrument)
    instruments.include? instrument
  end

  # Si el instrumento no es
  def instrument!(instrument, level)
    unless instrument?(instrument)
      MusicianKnowledge.create(musician: self, instrument: instrument, level: level)
    end
  end

  def status
    musician_status.name
  end


  private

    def set_default
      self.musician_status_id = MusicianStatus.find_by_name('Activo').id if self.musician_status_id.blank?
    end
end
