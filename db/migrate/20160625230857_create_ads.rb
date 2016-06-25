class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :adeable, polymorphic: true, index: true, null: false
      t.string :title, null: false
      t.text :body

      t.timestamps null: false
    end
  end
end
