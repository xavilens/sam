class CreateRols < ActiveRecord::Migration
  def change
    create_table :rols do |t|
      t.string :descripcion

      t.timestamps null: false
    end
  end
end
