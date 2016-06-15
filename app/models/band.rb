class Band < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :genre1, presence: true

  ################### RELACIONES ###################
  has_one :user, as: :profileable

  # TODO: Soft-delete?? // Historial de musicos??
  has_many :members, dependent: :delete_all
  has_many :musicians, through: :members

  belongs_to :genre1, class_name: 'Genre', foreign_key: "genre_id"
  belongs_to :genre2, class_name: 'Genre', foreign_key: "genre_id"
  belongs_to :genre3, class_name: 'Genre', foreign_key: "genre_id"

  belongs_to :band_statuses
  # TODO: Campo Estado = {buscando miembros, buscando conciertos, ninguno}
  def estado
    return BandStatus.find_by_id(musician_status_id).name
  end
end
