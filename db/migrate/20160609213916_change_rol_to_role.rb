class ChangeRolToRole < ActiveRecord::Migration
  def change
    rename_table :rol, :role
  end
end
