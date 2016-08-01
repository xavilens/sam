class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :title
      t.text :description
      t.references :imageable, polymorphic: true, index: true
      t.string :image, null: false

      t.timestamps null: false
    end
  end
end
