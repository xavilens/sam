class MessageIndexToEnglish < ActiveRecord::Migration
  def change
    # remove_foreign_key :messages, column: :autor
    # remove_index :messages, :autor
    rename_column :messages, :autor, :author_id
    add_index :messages, :author_id
    add_foreign_key :messages, :users, column: :author_id
  end
end
