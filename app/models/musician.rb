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
  def conocimientos
    knowledges = Array.new

    knowledges.each do |k|
      knowledges.push(Knowledge.find_by_id(k.id).name)
    end

    return knowledges
  end

  def estado
    return MusicianStatus.find_by_id(musician_status_id).name
  end

  private

    def set_default
      self.musician_status_id = MusicianStatus.find_by_name('Activo').id if self.musician_status_id.blank?
    end
end
