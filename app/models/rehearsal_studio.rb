class RehearsalStudio < ActiveRecord::Base
  ######## VALIDATIONS
  validates :event_status_id, presence: true
  validates :event_type_id, presence: true

  ######## RELATIONSHIPS 
  belongs_to :creator_id, class_name: 'User', primary_key: 'id', foreign_key: 'creator_id'

  has_many :rehearsal_studio_reviews
  has_many :rehearsal_studio_users
  has_many :users, through: :rehearsal_studio_users
end
