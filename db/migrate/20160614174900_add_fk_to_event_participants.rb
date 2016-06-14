class AddFkToEventParticipants < ActiveRecord::Migration
  def change
    add_foreign_key :event_participants, :users, column: :participant
    change_column :event_participants, :participant, :integer, uniq: {scope: :event_id}
  end
end
