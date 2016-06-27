class CreateMtbAdGenres < ActiveRecord::Migration
  def change
    create_table :mtb_ad_genres do |t|
      t.references :member_to_band, index: true, foreign_key: true, null: false
      t.references :genre, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
