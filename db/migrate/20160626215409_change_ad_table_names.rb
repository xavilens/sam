class ChangeAdTableNames < ActiveRecord::Migration
  def change
    rename_table :band_musicians, :band_musician_ads
    rename_table :trades, :trade_ads
  end
end
