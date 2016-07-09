class Genre1NullableInBand < ActiveRecord::Migration
  def change
    change_column :bands, :genre_1_id, :integer, null: true
  end
end
