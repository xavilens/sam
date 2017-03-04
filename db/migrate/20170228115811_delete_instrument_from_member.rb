class DeleteInstrumentFromMember < ActiveRecord::Migration
  def change
    remove_foreign_key "members", "instruments"
    remove_index :members, :instrument_id
    remove_column :members, :instrument_id
  end
end
