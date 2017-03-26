class EventParticipant < ActiveRecord::Base
  ######## VALIDATIONS
  validates :event_id, presence: true
  validates :participant_id, presence: true, uniqueness: {scope: :event_id}

  ######## RELATIONSHIPS
  belongs_to :event
  belongs_to :participant, class_name: "User", primary_key: 'id', foreign_key: "participant_id"
end
