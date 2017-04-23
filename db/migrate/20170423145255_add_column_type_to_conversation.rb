class AddColumnTypeToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :type, :string
  end
end
