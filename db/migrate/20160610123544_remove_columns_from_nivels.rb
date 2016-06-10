class RemoveColumnsFromNivels < ActiveRecord::Migration
  def change
    remove_column :nivels, :created_at, :timestamp
    remove_column :nivels, :updated_at, :timestamp
  end
end
