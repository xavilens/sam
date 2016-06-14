class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :nombre, null: false
      t.string :descripcion
      t.date :fecha, null: false
      t.time :hora, null: false
      t.references :event_status, index: true, foreign_key: true, null: false
      t.string :calle, null: false
      t.string :ciudad, null: false
      t.string :comunidad, null: false
      t.string :pais, null: false
      t.integer :max_participantes
      t.boolean :entrada, default: false, null: false
      t.decimal :pvp
      t.integer :creador, index: true, null: false

      t.timestamps null: false
    end

    add_foreign_key :events, :users, column: :creador  
  end
end
