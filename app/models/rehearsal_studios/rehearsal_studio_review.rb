class RehearsalStudioReview < ActiveRecord::Base
  ######## VALIDATIONS
  validates :title, presence: true
  validates :rate, presence: true
  validates :user_id, presence: true
  validates :rehearsal_studio_id, presence: true, uniqueness: {scope: :user_id}

  ######## RELATIONSHIPS
  belongs_to :user
  belongs_to :rehearsal_studio

  has_many :images, as: :imageable
  accepts_nested_attributes_for :images

end
