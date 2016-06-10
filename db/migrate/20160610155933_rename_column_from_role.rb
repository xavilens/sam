class RenameColumnFromRole < ActiveRecord::Migration
  def change
    rename_column :roles, :descripcion, :nombre
  end
end
