class ChangeVideos < ActiveRecord::Migration
  def change
    change_column :videos, :title, :string, null: true
    change_column :videos, :video_id, :string, null: true
    change_column :videos, :video_id, :string, null: true
    change_column :videos, :thumbnail, :string, null: true
    change_column :videos, :duration, :integer, null: true

    add_column :videos, :embed_code, :string
  end
end
