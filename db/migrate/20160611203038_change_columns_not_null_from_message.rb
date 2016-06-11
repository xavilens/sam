class ChangeColumnsNotNullFromMessage < ActiveRecord::Migration
  def change
    change_column :messages, :autor, null: false
    change_column :messages, :conversation_id, null: false
    change_column :messages, :cuerpo, null: false
  end
end
