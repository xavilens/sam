class ModVideoColumns < ActiveRecord::Migration
  def change
    rename_column :videos, :name, :title
    rename_column :videos, :track_id, :video_id

    add_column :videos, :thumbnail, :string
    add_column :videos, :duration, :integer
    add_column :videos, :provider, :string, null: false
  end
end
