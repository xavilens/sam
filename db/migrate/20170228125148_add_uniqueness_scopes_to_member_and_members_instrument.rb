class AddUniquenessScopesToMemberAndMembersInstrument < ActiveRecord::Migration
  def change
    # rename_table :members_instruments, :member_instruments
    change_column :members, :musician_id, :integer, scope: {uniqueness: :band_id}
    change_column :member_instruments, :instrument_id, :integer, scope: {uniqueness: :member_id}
  end
end
