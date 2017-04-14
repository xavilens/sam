class AddNameColumnToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :name, :string, null: false
  end
end
