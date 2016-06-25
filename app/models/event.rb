class Event < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :event_status_id, presence: true
  validates :event_type_id, presence: true

  ################### RELACIONES ###################
  belongs_to :event_status
  belongs_to :event_type

  has_many :event_participants
  has_many :participants, through: :event_participants, class_name: "User", foreign_key: "user_id"

  belongs_to :sala
end
