class CreateSalaUsers < ActiveRecord::Migration
  def change
    create_table :sala_users do |t|
      t.references :sala, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
