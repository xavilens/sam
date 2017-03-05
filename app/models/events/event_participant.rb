class EventParticipant < ActiveRecord::Base
  ######## VALIDATIONS
  validates :participant_id, presence: true
  validates :participant, presence: true, uniqueness: {scope: :event_id}

  ######## RELATIONSHIPS
  belongs_to :event
  belongs_to :reverse_event, class_name: "Event", primary_key: "id", foreign_key: "event_id"
  belongs_to :participant, class_name: "User", primary_key: 'id', foreign_key: "participant_id"
end
