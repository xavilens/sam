class CreateSalas < ActiveRecord::Migration
  def change
    create_table :salas do |t|
      t.string :name, null: false
      t.string :direction, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :country, null: false
      t.integer :creator_id, index:true, null: false
      t.integer :creator_id, null: false
      t.integer :n_reviews, default: 0, null: false
      t.decimal :total_rating

      t.timestamps null: false
    end

    add_foreign_key :salas, :users, column: :creator_id
  end
end
