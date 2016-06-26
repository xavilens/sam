class AddIndexesToBmAdTables < ActiveRecord::Migration
  def change
    # remove_foreign_key :bm_ad_genres, :member_to_bands
    # remove_index :bm_ad_genres, name: 'index_bm_ad_genres_on_member_to_band_id'
    # rename_column :bm_ad_genres, :member_to_band_id, :band_musician_id
    # remove_index :bm_ad_genres, :band_musician_id
    # rename_column :bm_ad_genres, :band_musician_id, :band_musician_ad_id
    # add_index :bm_ad_genres, :band_musician_ad_id
    # add_foreign_key :bm_ad_genres, :band_musician_ads

    # rename_column :bm_ad_instruments, :instruments_id, :instrument_id
    # add_index :bm_ad_instruments, :instrument_id
    # add_foreign_key :bm_ad_instruments, :instruments
    rename_column :bm_ad_instruments, :band_to_members_id, :band_musician_ad_id
    add_index :bm_ad_instruments, :band_musician_ad_id
    add_foreign_key :bm_ad_instruments, :band_musician_ads

  end
end
