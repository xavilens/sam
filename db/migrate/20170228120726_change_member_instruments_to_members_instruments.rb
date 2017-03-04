class ChangeMemberInstrumentsToMembersInstruments < ActiveRecord::Migration
  def change
    rename_table :member_instruments, :members_instruments
  end
end
