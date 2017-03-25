class RenameColumnParticipantInEventParticipants < ActiveRecord::Migration
  def change
    remove_foreign_key "event_participants", column: "participant"
    remove_index :event_participants, name: "index_event_participants_on_participant"

    rename_column :event_participants, :participant, :participant_id
  end
end
