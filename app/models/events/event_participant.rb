class EventParticipant < ActiveRecord::Base
  ######## VALIDATIONS
  validates :event_id, presence: true
  validates :participant_id, presence: true, uniqueness: {scope: :event_id}
  validate :can_participate?

  ######## RELATIONSHIPS
  belongs_to :event
  belongs_to :participant, class_name: "User", primary_key: 'id', foreign_key: "participant_id"

  private
    def can_participate?
      if event.participants.size >= event.max_participants
        errors.add(:max_participants, 'Se ha alcanzado el número máximo de participantes en el evento.')
      end
    end
end
