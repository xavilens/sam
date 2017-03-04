class AddValidationsToMemberInstruments < ActiveRecord::Migration
  def change
    change_column :member_instruments, :member_id, :integer, null: false
    change_column :member_instruments, :instrument_id, :integer, null: false, uniqueness: :member_id 
  end
end
