class EventParticipant < ActiveRecord::Base
  ######## VALIDATIONS
  validates :event_id, presence: true
  validates :participant_id, presence: true, uniqueness: {scope: :event_id}
  validate :can_participate?

  ######## RELATIONSHIPS
  belongs_to :event
  belongs_to :participant, class_name: "User", primary_key: 'id', foreign_key: "participant_id"

  private
    # Indica si se puede crear la participación
    def can_participate?
      # Definimos los participantes actuales del event
      event_participants_num = event.participants.size

      # Definimos los participantes máximos del evento
      max_participants = event.max_participants
      max_participants ||= 99999

      # Comprobamos
      if event_participants_num >= max_participants
        errors.add(:max_participants, 'Se ha alcanzado el número máximo de participantes en el evento.')
      end
    end
end
