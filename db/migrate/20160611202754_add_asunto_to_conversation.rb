class AddAsuntoToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :asunto, :string
  end
end
