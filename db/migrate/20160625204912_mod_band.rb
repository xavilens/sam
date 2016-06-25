class ModBand < ActiveRecord::Migration
  def change
    remove_foreign_key :bands, column: :genre1_id
    remove_index :bands, :genre1_id
    rename_column :bands, :genre1_id, :genre_1_id
    add_index :bands, :genre_1_id
    add_foreign_key :bands, :genres, column: :genre_1_id

    remove_foreign_key :bands, column: :genre2_id
    remove_index :bands, :genre2_id
    rename_column :bands, :genre2_id, :genre_2_id
    add_index :bands, :genre_2_id
    add_foreign_key :bands, :genres, column: :genre_2_id

    remove_foreign_key :bands, column: :genre3_id
    remove_index :bands, :genre3_id
    rename_column :bands, :genre3_id, :genre_3_id
    add_index :bands, :genre_3_id
    add_foreign_key :bands, :genres, column: :genre_3_id
  end
end
