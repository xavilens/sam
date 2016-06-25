class ChangeColumnNameInEvent < ActiveRecord::Migration
  def change
    # remove_index :events, :creador
    # remove_foreign_key :events, column: :creador
    # rename_column :events, :creador, :creator_id
    # add_index :events, :creator_id
    add_foreign_key :events, :users, column: :creator_id
  end
end
