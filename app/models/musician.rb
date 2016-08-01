class Musician < ActiveRecord::Base
  ################### ACCIONES ###################

  before_validation :set_default, on: :create

  ################### VALIDACIONES ###################

  validates :musician_status_id, presence: true

  ################### RELACIONES ###################

  has_one :user, as: :profileable, dependent: :destroy

  # TODO: Soft-delete?? Historial de grupos??
  has_many :members, dependent: :delete_all
  has_many :bands, through: :members
  has_many :musician_knowledges, dependent: :delete_all
  has_many :instruments, through: :musician_knowledges

  belongs_to :musician_status

  ################### METODOS ###################

  def member?(band)
    bands.include? band
  end

  def member!(band)
    unless member?(band)
      bands << band
    end
  end

  def instrument?(instrument)
    instruments.include? instrument
  end

  def instrument!(instrument)
    unless instrument?(instrument)
      instruments << instrument
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
