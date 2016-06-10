class AddNotNullToTables < ActiveRecord::Migration
  def change
    change_column :users, :nombre, :string, null: false
    change_column :users, :ciudad, :string, null: false
    change_column :users, :comunidad, :string, null: false
    change_column :users, :pais, :string, null: false
    change_column :users, :profileable_id, :integer, null: false
    change_column :users, :profileable_type, :string, null: false
    change_column :users, :role_id, :integer, null: false

    change_column :knowledges, :nombre, :string, null: false
    change_column :levels, :nombre, :string, null: false
    change_column :roles, :nombre, :string, null: false
  end
end
