class ChangeColumnNameInSalas < ActiveRecord::Migration
  def change
    rename_column :salas, :direction, :street
  end
end
