class RemoveColumnTypeFromConversation < ActiveRecord::Migration
  def change
    remove_column :conversations, :type
  end
end
