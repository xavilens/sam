class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :usuario_1, index: true, null: false
      t.integer :usuario_2, index: true, null: false

      t.timestamps null: false
    end

    add_foreign_key :conversations, :users, column: :usuario_1
    add_foreign_key :conversations, :users, column: :usuario_2
  end
end
