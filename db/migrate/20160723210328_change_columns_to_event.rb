class ChangeColumnsToEvent < ActiveRecord::Migration
  def change
    change_column :events, :descripcion, :text
    rename_column :events, :descripcion, :description
  end
end
