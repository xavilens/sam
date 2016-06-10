class CreateMusicianKnowledges < ActiveRecord::Migration
  def change
    create_table :musician_knowledges do |t|
      t.references :musician, index: true, foreign_key: true, null: false
      t.references :knowledge, index: true, foreign_key: true, null: false 

      t.timestamps null: false
    end
  end
end
