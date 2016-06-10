class AddLevelRefToMusicianKnowledges < ActiveRecord::Migration
  def change
    add_reference :musician_knowledges, :level, index: true, foreign_key: true
  end
end
