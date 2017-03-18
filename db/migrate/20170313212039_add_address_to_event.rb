class AddAddressToEvent < ActiveRecord::Migration
  def change
    remove_column :events, :street
    remove_column :events, :city
    remove_column :events, :state
    remove_column :events, :country

    add_column :events, :address_id, :integer, null: false, index: true, foreign_key: true
  end
end
