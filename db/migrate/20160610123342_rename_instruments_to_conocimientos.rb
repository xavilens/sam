class RenameInstrumentsToConocimientos < ActiveRecord::Migration
  def change
    rename_table :instruments, :knowledges
  end
end
