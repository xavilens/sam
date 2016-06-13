class AddNotNullToAsuntoInConversation < ActiveRecord::Migration
  def change
    change_column :conversations, :asunto, :string, null: false
  end
end
