class RenameEventIndexOnEventParticipant < ActiveRecord::Migration
  def change
    # remove_foreign_key :event_participants, :events
    # remove_index :event_participants, name: "fk_rails_565ef9d942"

    add_index :event_participants, :event_id
    add_foreign_key :event_participants, :events
  end
end
