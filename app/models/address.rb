class Address < ActiveRecord::Base
  belongs_to :addresseable, polymorphic: true

  validates :addresseable_type, presence: true, uniqueness: {scope: :addresseable_id}
end
