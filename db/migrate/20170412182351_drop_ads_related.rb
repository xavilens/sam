class DropAdsRelated < ActiveRecord::Migration
  def change
    remove_foreign_key :trade_ads, :t_ad_items
    remove_foreign_key :trade_ads, :t_ad_types
    remove_index :trade_ads, name: "index_trade_ads_on_t_ad_item_id"
    remove_index :trade_ads, name: "index_trade_ads_on_t_ad_type_id"
    drop_table :trade_ads

    drop_table :t_ad_types
    drop_table :t_ad_items

    ######################################################

    remove_foreign_key :btb_ad_genres, :band_to_band_ads
    remove_foreign_key :btb_ad_genres, :genres
    remove_index :btb_ad_genres, name: "index_btb_ad_genres_on_band_to_band_ad_id"
    remove_index :btb_ad_genres, name: "index_btb_ad_genres_on_genre_id"
    drop_table :btb_ad_genres

    remove_foreign_key :band_to_band_ads, :btb_ad_types
    remove_index :band_to_band_ads, name: "index_band_to_band_ads_on_btb_ad_type_id"
    drop_table :band_to_band_ads

    drop_table :btb_ad_types

    ######################################################

    remove_foreign_key :bm_ad_genres, :band_musician_ads
    remove_foreign_key :bm_ad_genres, :genres
    remove_index :bm_ad_genres, name: "index_bm_ad_genres_on_band_musician_ad_id"
    remove_index :bm_ad_genres, name: "index_bm_ad_genres_on_genre_id"
    drop_table :bm_ad_genres

    remove_foreign_key :bm_ad_instruments, :band_musician_ads
    remove_foreign_key :bm_ad_instruments, :instruments
    remove_index :bm_ad_instruments, name: "index_bm_ad_instruments_on_band_musician_ad_id"
    remove_index :bm_ad_instruments, name: "index_bm_ad_instruments_on_instrument_id"
    drop_table :bm_ad_instruments

    drop_table :band_musician_ads

    ######################################################

    remove_foreign_key :ads, :users
    remove_index :ads, name: "index_ads_on_adeable_type_and_adeable_id"
    remove_index :ads, name: "index_ads_on_user_id"
    drop_table :ads
  end
end
