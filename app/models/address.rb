class Address < ActiveRecord::Base
  # VALIDATIONS
  validates :addresseable_type, presence: true, uniqueness: {scope: :addresseable_id}

  # SCOPES
  scope :in_location, -> (location){
    where("city like :location or region like :location or municipality like :location or province like :location",
    location: "%#{location}%") }

  # RELATIONS
  belongs_to :addresseable, polymorphic: true

end
