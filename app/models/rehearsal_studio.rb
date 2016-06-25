class RehearsalStudio < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :event_status_id, presence: true
  validates :event_type_id, presence: true

  ################### RELACIONES ###################
  belongs_to :creator_id, class_name: 'User', foreign_key: 'user_id'

  has_many :rehearsal_studio_reviews
  has_many :rehearsal_studio_users
  has_many :users, through: :rehearsal_studio_users

  ################### METODOS ###################
end
