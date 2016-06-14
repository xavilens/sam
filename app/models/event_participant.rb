class EventParticipant < ActiveRecord::Base

  belongs_to :event
  belongs_to :participant, class_name: "User", foreign_key: "user_id"

  validates :participant_id, presence: true
  validates :participant, presence: true, uniqueness: {scope: :event_id}

end
