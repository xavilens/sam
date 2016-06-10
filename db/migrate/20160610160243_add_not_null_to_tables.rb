class AddNotNullToTables < ActiveRecord::Migration
  def change
    change_column :users, :nombre, null: false
    change_column :users, :ciudad, null: false
    change_column :users, :comunidad, null: false
    change_column :users, :pais, null: false
    change_column :users, :profileable_id, null: false
    change_column :users, :profileable_type, null: false
    change_column :users, :role_id, null: false

    change_column :knowledges, :nombre, null: false
    change_column :levels, :nombre, null: false
    change_column :roles, :nombre, null: false
  end
end
