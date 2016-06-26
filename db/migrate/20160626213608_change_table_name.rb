class ChangeTableName < ActiveRecord::Migration
  def change
    rename_table :band_to_members, :band_members
    rename_table :btm_ad_instruments, :bm_ad_instruments
    rename_table :mtb_ad_genres, :bm_ad_genres
  end
end
