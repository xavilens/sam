class CreateMainPosts < ActiveRecord::Migration
  def change
    create_table :main_posts do |t|
      t.references :post, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
