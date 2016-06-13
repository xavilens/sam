class UniquenessScopeInMusicianKnowledge < ActiveRecord::Migration
  def change
    change_column :musician_knowledges, :knowledge_id, :integer, scope: :musician_id
  end
end
