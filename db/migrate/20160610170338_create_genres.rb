class CreateGenres < ActiveRecord::Migration
  def change
    create_table :genres do |t|
      t.string :nombre, null: false
      t.string :categoria, null: false
    end
  end
end
