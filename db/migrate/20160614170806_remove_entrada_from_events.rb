class RemoveEntradaFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :entrada, :boolean
  end
end
