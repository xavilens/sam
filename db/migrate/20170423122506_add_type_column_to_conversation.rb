class AddTypeColumnToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :type, :string, null: true
  end
end
