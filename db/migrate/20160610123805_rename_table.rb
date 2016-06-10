class RenameTable < ActiveRecord::Migration
  def change
    rename_table :nivels, :levels
  end
end
