class CreateNivels < ActiveRecord::Migration
  def change
    create_table :nivels do |t|
      t.string :nombre

      t.timestamps null: false
    end
  end
end
