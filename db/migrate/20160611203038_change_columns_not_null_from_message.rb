class ChangeColumnsNotNullFromMessage < ActiveRecord::Migration
  def change
    change_column :messages, :autor, :integer, null: false
    change_column :messages, :conversation_id, :integer, null: false
    change_column :messages, :cuerpo, :text, null: false
  end
end
