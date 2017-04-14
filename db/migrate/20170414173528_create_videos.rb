class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.string :track_id, null: false
      t.references :user, index: true, foreign_key: true, null: false
      t.boolean :in_user_page, null: false, default: false

      t.timestamps null: false
    end
  end
end
