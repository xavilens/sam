class Band < ActiveRecord::Base
  ######## ACTIONS / FILTERS
  before_validation :set_default, on: :create

  ######## VALIDATIONS
  validates :band_status_id, presence: true

  ######## RELATIONSHIPS
  has_one :user, as: :profileable, dependent: :destroy
  accepts_nested_attributes_for :user

  has_many :members, dependent: :destroy
  accepts_nested_attributes_for :members
  has_many :musicians, through: :members

  has_many :events, through: :user, source: :created_events

  belongs_to :genre_1, class_name: 'Genre'
  belongs_to :genre_2, class_name: 'Genre'
  belongs_to :genre_3, class_name: 'Genre'

  belongs_to :band_status


  ######## METHODS
  # Devuelve el nombre del grupo
  def name
    user.name
  end

  # Devuelve si un músico es miembro del grupo
  def musician_member?(musician)
    musicians.include? musician
  end

  # Devuelve si un músico es miembro del grupo
  def member? user
    musician = if user.is_a? User and user.musician?
      user.profile
    elsif user.is_a? Musician
      user
    end

    if musician
      musician_member? musician
    else
      false
    end
  end

  # Método que añade al músico a los miembros del grupo si no es miembro ya y lo elimina si es miembro
  def member!(musician)
    unless member?(musician)
      musicians << musician
    else
      musicians.destroy(musician.id)
    end
  end

  # Devuelve un array con los géneros del grupo
  def genres
    [genre_1.name, genre_2.name, genre_3.name]
  end

  # Devuelve el estado del grupo
  def status
    band_status.name
  end

  private
    # Define el estado del grupo por defecto
    def set_default
      self.band_status_id = BandStatus.find_by_name('Activo').id if self.band_status_id.blank?
    end

end
