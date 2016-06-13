class AddUniquenessScope < ActiveRecord::Migration
  def change
    change_column :musician_knowledges, :knowledge_id, :integer, unique: {scope: :musician_id}
    change_column :members, :instrument_id, :integer, unique: {scope: [:band_id, :musician_id]}
  end
end
