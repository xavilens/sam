class EventParticipant < ActiveRecord::Base
  ################### VALIDACIONES ###################
  validates :participant_id, presence: true
  validates :participant, presence: true, uniqueness: {scope: :event_id}

  ################### RELACIONES ###################
  belongs_to :event
  belongs_to :participant, class_name: "User", foreign_key: "user_id"
end
