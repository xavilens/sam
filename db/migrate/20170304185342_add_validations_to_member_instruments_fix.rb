class AddValidationsToMemberInstrumentsFix < ActiveRecord::Migration
  def change
    change_column :member_instruments, :instrument_id, :integer, null: false
  end
end
