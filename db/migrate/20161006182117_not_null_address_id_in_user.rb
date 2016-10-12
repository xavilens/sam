class NotNullAddressIdInUser < ActiveRecord::Migration
  def change
    change_column :users, :address_id, :integer, null: true
  end
end
