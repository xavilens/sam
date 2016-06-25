class CreateRehearsalStudioReviews < ActiveRecord::Migration
  def change
    create_table :rehearsal_studio_reviews do |t|
      t.string :title, null: false
      t.string :description
      t.decimal :rate, precision: 1, null: false
      t.decimal :room_dimension, precision: 2
      t.decimal :room_price, precision: 2
      t.string :avaliability
      t.boolean :equipped_room
      t.boolean :shared_room
      t.integer :bands_in_room
      t.references :user
      t.references :rehearsal_studio

      t.timestamps null: false
    end
  end
end
