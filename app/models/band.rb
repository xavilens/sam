class Band < ActiveRecord::Base
  ################### ACCIONES ###################

  before_validation :set_default, on: :create

  ################### VALIDACIONES ###################

  validates :band_status_id, presence: true

  ################### RELACIONES ###################

  has_one :user, as: :profileable, dependent: :destroy
  accepts_nested_attributes_for :user

  # TODO: Soft-delete?? // Historial de musicos??
  has_many :members, dependent: :delete_all
  has_many :musicians, through: :members

  belongs_to :genre_1, class_name: 'Genre', foreign_key: "genre_id"
  belongs_to :genre_2, class_name: 'Genre', foreign_key: "genre_id"
  belongs_to :genre_3, class_name: 'Genre', foreign_key: "genre_id"

  belongs_to :band_status


  ################### METODOS ###################

  def member?(musician)
    musicians.include? musician
  end

  # def member!(musician)
  #   unless member?(musician)
  #     musicians << musician
  #   end
  # end

  def genres
    # {genre_1: genre_1.name, genre_2: genre_2.name, genre_3: genre_3.name}
    [genre_1.name, genre_2.name, genre_3.name]
  end

  def status
    band_status.name
  end

  private

    def set_default
      self.band_status_id = BandStatus.find_by_name('Activo').id if self.band_status_id.blank?
    end

end
