class RemoveAddressIdInUser < ActiveRecord::Migration
  def change
    # remove_foreign_key :users, :addresses
    remove_reference :users, :address
  end
end
