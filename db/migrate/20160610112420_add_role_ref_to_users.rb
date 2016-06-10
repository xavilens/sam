class AddRoleRefToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :role, index: true, foreign_key: true
    remove_column :users, :rol_id

    remove_column :roles, :updated_at
    remove_column :roles, :created_at
  end
end
