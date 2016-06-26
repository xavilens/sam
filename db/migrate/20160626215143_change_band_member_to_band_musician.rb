class ChangeBandMemberToBandMusician < ActiveRecord::Migration
  def change
    rename_table :band_members, :band_musicians
    add_column :band_musicians, :type, :string, null: false
  end
end
