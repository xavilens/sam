class ChangeIndexOfEventParticipants < ActiveRecord::Migration
  def change
    add_index :event_participants, :participant_id
    add_foreign_key :event_participants, :users, column: :participant_id
    add_foreign_key :event_participants, :events
  end
end
