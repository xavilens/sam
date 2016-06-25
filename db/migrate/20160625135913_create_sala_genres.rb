class CreateSalaGenres < ActiveRecord::Migration
  def change
    create_table :sala_genres do |t|
      t.references :sala, index: true, foreign_key: true, null: false
      t.references :genre, index: true, foreign_key: true, null: false, unique: {scope: :sala_id}

      t.timestamps null: false
    end
  end
end
