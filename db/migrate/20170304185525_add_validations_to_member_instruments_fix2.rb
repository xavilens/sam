class AddValidationsToMemberInstrumentsFix2 < ActiveRecord::Migration
  def change
    change_column :member_instruments, :member_id, :integer, null: false
    change_column :member_instruments, :instrument_id, :integer, null: false, unique: {scope: :member_id} 
  end
end
