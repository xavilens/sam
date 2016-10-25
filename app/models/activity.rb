class Activity < ActiveRecord::Base
  ######## VALIDATIONS
  validates :user_id, presence: true
  validates :activity_type_id, presence: true
  validates :description, presence: true

  ######## RELATIONSHIPS
  belongs_to :user
  belongs_to :activity_type
end
