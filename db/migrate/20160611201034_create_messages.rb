class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :autor
      t.string :cuerpo
      t.references :conversation, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_foreign_key :messages, :users, column: :autor
  end
end
