class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :url, null: false
      t.references :user, index: true, foreign_key: true, null: false
      t.boolean :in_user_page, null: false, default: false

      t.timestamps null: false
    end
  end
end
