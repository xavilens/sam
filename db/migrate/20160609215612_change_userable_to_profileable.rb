class ChangeUserableToProfileable < ActiveRecord::Migration
  def change
    rename_column :users, :userable_id, :profileable_id
    rename_column :users, :userable_type, :profileable_type
  end
end
