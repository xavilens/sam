class AddDetailsToDelegatedUsers < ActiveRecord::Migration
  def change
    change_column :delegated_users, :delegated_user, :integer, null: false
    change_column :delegated_users, :current_user, :integer, null: false
    change_column :delegated_users, :activo, :boolean, default: false, null: false
  end
end
