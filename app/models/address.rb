class Address < ActiveRecord::Base
  ######## VALIDATIONS
  validates :city, presence: true
  validates :municipality, presence: true
  validates :province, presence: true
  validates :region, presence: true
  validates :country, presence: true

  ######## SCOPES
  # Devuelve las direcciones de la localización dada
  scope :in_location, -> (location){
    where("city like :location or region like :location or municipality like :location or province like :location",
    location: "%#{location}%")
  }

  # Devuelve las direcciones de los eventos
  scope :events, -> {
    where(addresseable_type: "Event")
  }

  # Devuelve las direcciones de los usuarios
  scope :users, -> {
    where(addresseable_type: "User")
  }

  # Devuelve las direcciones de los eventos
  scope :cities, -> {
    group(:city)
  }

  # Devuelve las direcciones de los usuarios
  scope :regions, -> {
    group(:region)
  }

  # Devuelve las direcciones de los usuarios
  scope :provinces, -> {
    group(:province)
  }

  ######## RELATIONSHIPS
  belongs_to :addresseable, polymorphic: true

end
