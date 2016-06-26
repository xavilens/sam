class AddColumnsToBandToMember < ActiveRecord::Migration
  def change
    add_column :band_to_members, :city, :string, null: false
    add_column :band_to_members, :state, :string, null: false
    add_column :band_to_members, :country, :string, null: false
  end
end
