class CreateBandToBandAds < ActiveRecord::Migration
  def change
    create_table :band_to_band_ads do |t|
      t.string :city, null: false
      t.string :state, null: false
      t.string :country, null: false
      t.references :btb_ad_type, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
