class AddAddressToUser < ActiveRecord::Migration
  def change
    # remove_foreign_key :users, :addresses
    # remove_index :users, :address_id
    # remove_column :users, :address_id
    # add_reference :users, :addresses, index: true
    remove_reference :users, :addresses
    add_reference :users, :address, index: true
    add_foreign_key :users, :addresses
  end
end
