class CreateConversationRelateds < ActiveRecord::Migration
  def change
    create_table :conversation_relateds do |t|
      t.references :conversation, index: true, foreign_key: true
      t.references :conversationable, polymorhpic: true, index: true

      t.timestamps null: false
    end
  end
end
