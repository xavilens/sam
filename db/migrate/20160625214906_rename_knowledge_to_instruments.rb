class RenameKnowledgeToInstruments < ActiveRecord::Migration
  def change
    rename_table :knowledges, :instruments
  end
end
