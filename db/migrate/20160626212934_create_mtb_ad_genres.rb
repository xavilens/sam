class CreateMtbAdGenres < ActiveRecord::Migration
  def change
    create_table :mtb_ad_genres do |t|
      t.references :member_to_band, index: true, foreign_key: true
      t.references :genre, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
