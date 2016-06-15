class AddStatusToBandAndMusician < ActiveRecord::Migration
  def change
    add_column :musicians, :musician_status_id, :integer, index: true, foreign_key: true
    add_column :bands, :band_status_id, :integer, index: true, foreign_key: true
  end
end
