class ChangeColumnFromMessage < ActiveRecord::Migration
  def change
    change_column :messages, :cuerpo, :text
  end
end
