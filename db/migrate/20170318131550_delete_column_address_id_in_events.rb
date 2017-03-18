class DeleteColumnAddressIdInEvents < ActiveRecord::Migration
  def change
    remove_column :events, :address_id
  end
end
