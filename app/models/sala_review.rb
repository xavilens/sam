class SalaReview < ActiveRecord::Base
  ######## VALIDATIONS
  validates :title, presence: true
  validates :service_rate, presence: true
  validates :gear_rate, presence: true
  validates :user_id, presence: true
  validates :sala_id, presence: true, uniqueness: {scope: :user_id}

  ######## RELATIONSHIPS
  belongs_to :user
  belongs_to :sala

  has_many :images, as: :imageable
  accepts_nested_attributes_for :images

end
