class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :activity_type, index: true, foreign_key: true, null: false
      t.string :descripcion, null: false

      t.timestamps null: false
    end
  end
end
