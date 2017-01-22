class RenameKnowledgeToInstrumentInMusicianKnowledge < ActiveRecord::Migration
  def change
    remove_foreign_key :musician_knowledges, column: "knowledge_id"
    remove_foreign_key :musician_knowledges, :levels
    remove_index :musician_knowledges, name: "index_musician_knowledges_on_knowledge_id"
    remove_index :musician_knowledges, name: "index_musician_knowledges_on_level_id"
    rename_column :musician_knowledges, :knowledge_id, :instrument_id
    add_reference :musician_knowledges, :instruments, index: true
    add_reference :musician_knowledges, :levels, index: true
    add_foreign_key :musician_knowledges, :instruments
    add_foreign_key :musician_knowledges, :levels
  end
end
