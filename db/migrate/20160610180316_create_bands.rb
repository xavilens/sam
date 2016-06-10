class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.references :genre1, index: true, foreign_key: true, null: false
      t.references :genre2, index: true, foreign_key: true
      t.references :genre3, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
