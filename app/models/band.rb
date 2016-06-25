class Band < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :genre1, presence: true

  ################### RELACIONES ###################
  has_one :user, as: :profileable

  # TODO: Soft-delete?? // Historial de musicos??
  has_many :members, dependent: :delete_all
  has_many :musicians, through: :members

  belongs_to :genre_1, class_name: 'Genre', foreign_key: "genre_id"
  belongs_to :genre_2, class_name: 'Genre', foreign_key: "genre_id"
  belongs_to :genre_3, class_name: 'Genre', foreign_key: "genre_id"

  belongs_to :band_statuses

  ################### METODOS ###################
  def genero(genero_id)
    Genre.find_by_id(genero_id).name
  end

  def estado
    BandStatus.find_by_id(musician_status_id).name
  end
end
