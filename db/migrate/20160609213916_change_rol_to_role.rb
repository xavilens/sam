class ChangeRolToRole < ActiveRecord::Migration
  def change
    rename_table :rols, :roles
  end
end
