class Address < ActiveRecord::Base
  ######## VALIDATIONS
  # validates :addresseable, presence: true

  ######## SCOPES
  scope :in_location, -> (location){
    where("city like :location or region like :location or municipality like :location or province like :location",
    location: "%#{location}%") }

  ######## RELATIONSHIPS
  belongs_to :addresseable, polymorphic: true

end
