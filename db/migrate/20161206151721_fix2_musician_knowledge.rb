class Fix2MusicianKnowledge < ActiveRecord::Migration
  def change
    remove_column :musician_knowledges, :instruments_id
    remove_column :musician_knowledges, :levels_id
  end
end
