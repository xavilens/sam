class ConversationIndexesInEnglish < ActiveRecord::Migration
  def change
    remove_foreign_key :conversations, column: :usuario_1
    remove_index :conversations, :usuario_1
    rename_column :conversations, :usuario_1, :user_1_id
    add_index :conversations, :user_1_id
    add_foreign_key :conversations, :users, column: :user_1_id

    remove_foreign_key :conversations, column: :usuario_2
    remove_index :conversations, :usuario_2
    rename_column :conversations, :usuario_2, :user_2_id
    add_index :conversations, :user_2_id
    add_foreign_key :conversations, :users, column: :user_2_id
  end
end
