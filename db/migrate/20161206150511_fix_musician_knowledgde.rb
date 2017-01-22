class FixMusicianKnowledgde < ActiveRecord::Migration
  def change
    # remove_foreign_key :musician_knowledges, :instruments
    # remove_foreign_key :musician_knowledges, :levels
    # remove_index :musician_knowledges, name: "index_musician_knowledges_on_instruments_id"
    # remove_index :musician_knowledges, name: "fk_rails_a84f9e8cce"
    # remove_index :musician_knowledges, name: "fk_rails_7dc6259d74"
    # remove_index :musician_knowledges, name: "index_musician_knowledges_on_levels_id"
    remove_column :musician_knowledges, :instrument_id
    remove_column :musician_knowledges, :level_id
    add_reference :musician_knowledges, :instrument, index: true, foreign_key: true
    add_reference :musician_knowledges, :level, index: true, foreign_key: true
  end
end
