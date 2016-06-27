class CreateBtbAdGenres < ActiveRecord::Migration
  def change
    create_table :btb_ad_genres do |t|
      t.references :band_to_band_ad, index: true, foreign_key: true
      t.references :genre, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
